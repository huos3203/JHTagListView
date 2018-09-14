//
//  YiBanViewController.m
//  JHTagListView_Example
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import "YiBanViewController.h"
#import "YiBanCellView.h"
#import "JHTagBanliModel.h"
@interface YiBanViewController ()

@end

@implementation YiBanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - table dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YiBanCellView *shopCell = [tableView dequeueReusableCellWithIdentifier:@"YiBanCellView"];
    JHTagBanliModel *model = [self.dataArray objectAtIndex:indexPath.row];
    shopCell.model = model;
    return shopCell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
