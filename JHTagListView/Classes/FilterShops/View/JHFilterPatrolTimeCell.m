//
//  JHFilterStoreLocCell.m
//  JHTagListView_Example
//
//  Created by admin on 2018/9/13.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import "JHFilterPatrolTimeCell.h"
#import "JHTagItem.h"
#import "JHTagCollCell.h"
#import "DateAlertPickerController.h"

@interface JHFilterPatrolTimeCell()<DateAlertPickerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *ibStartTimeButton;
@property (strong, nonatomic) IBOutlet UIButton *ibEndTimeButton;

@end

@implementation JHFilterPatrolTimeCell
{
    BOOL isStartTime;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)ibaStartTimeAction:(id)sender {
    isStartTime = YES;
    [self showDatePickerView];
}
- (IBAction)ibEndTimeAction:(id)sender {
    isStartTime = NO;
    [self showDatePickerView];
}

-(void)showDatePickerView
{
    UIDatePicker *QueryDatePicker = [[UIDatePicker alloc] init];
    //时间模式的选择 有多种
    QueryDatePicker.datePickerMode = UIDatePickerModeDate;
    QueryDatePicker.backgroundColor = [UIColor clearColor];
    // 设置最小时间
    QueryDatePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:280 * 24 * 60 * 60 * -1];
    QueryDatePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:0];
    //    用自定义的UIAlertController选择ActionShee信息模式  并将中间的信息显示范围空出来 高度自由指定
    
    DateAlertPickerController *alert = [DateAlertPickerController alertControllerWithTitle:nil
                                                                       message:@"\n\n\n\n\n\n\n\n\n\n\n"// 改变视图的高度以插入UIDatePicker
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
    alert.delegate = self;
    [alert insertDatePicker:QueryDatePicker];
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    [topController presentViewController:alert animated:YES completion:nil];
}

#pragma mark -日期代理
-(void)dateAlertControllerChoosedDate:(NSDate *)date
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    if (isStartTime) {
        [self.ibStartTimeButton setTitle:dateStr forState:UIControlStateNormal];
    }else{
        [self.ibEndTimeButton setTitle:dateStr forState:UIControlStateNormal];
    }
}
-(void)dateAlertControllerCancelChoosedDate
{
    
}
@end
