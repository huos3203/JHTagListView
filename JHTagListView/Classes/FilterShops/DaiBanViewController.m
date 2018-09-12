//
//  SearchShopsViewController.m
//  YGPatrol(github地址)
//
//  Created by admin on 2018/5/14.
//Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "DaiBanViewController.h"
#import "DaiBanCellView.h"

@interface DaiBanViewController()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation DaiBanViewController

#pragma mark - def
//MARK: override
-(void)viewDidLoad{
    [super viewDidLoad];
}


#pragma mark - table dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DaiBanCellView *shopCell = [tableView dequeueReusableCellWithIdentifier:@"FilterPatrolStoreCellView"];
    DaiBanCellModel *model = [self.dataArray objectAtIndex:indexPath.row];
    shopCell.model = model;
    return shopCell;
}

@end

