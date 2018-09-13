//
//  DateAlertController.m
//  datePicker
//
//  Created by VH on 2017/11/21.
//  Copyright © 2017年 Jinhe. All rights reserved.
//

#import "DateAlertController.h"

#define mainw [UIScreen mainScreen].bounds.size.width
#define mainh [UIScreen mainScreen].bounds.size.height

@interface DateAlertController ()

@end

@implementation DateAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)insertDatePicker:(UIDatePicker *)picker
{
    if (!picker)
        return;
    
    self.datePicker = picker;                         //高度需要估算
    self.datePicker.frame = CGRectMake(0, 20, mainw-20, 216);
    
    [self.view addSubview:self.datePicker];
    
//    UIToolbar的宽度和高度需要注意，位于datePicker的上方即可
    UIToolbar *toolView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,mainw-20, 35)];
    toolView.backgroundColor = [UIColor clearColor]; //set it's background
    toolView.barStyle = UIBarStyleDefault;
    
    
//    ----度和---------------对精确性要求不高的话可以大致将frame写死差别不会很大
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 35)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"选择时间";
    [titleLabel adjustsFontSizeToFitWidth];
    
    UIBarButtonItem *bbtTitle = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    UIBarButtonItem *bbtSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *bbtOK = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(OKWithPicker)];
     [bbtOK setTintColor:[UIColor blackColor]];
    bbtOK.width = mainw/8;
    UIBarButtonItem *bbtCancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(CancleWithPicker)];
    [bbtCancel setTintColor:[UIColor blackColor]];
    bbtCancel.width =mainw/8;
    toolView.items = [NSArray arrayWithObjects:bbtCancel,bbtSpace,bbtTitle,bbtSpace,bbtOK, nil];
    
    [self.view addSubview:toolView];
    
}

- (void)OKWithPicker
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dateAlertControllerChoosedDate:)])
    {
        [self.delegate dateAlertControllerChoosedDate:self.datePicker.date];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)CancleWithPicker
{
    [self.delegate dateAlertControllerCancelChoosedDate];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
