//
//  SearchShopsViewController.m
//  YGPatrol(github地址)
//
//  Created by admin on 2018/5/14.
//Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "DaiBanViewController.h"
#import "DaiBanCellView.h"
#import "DaiBanCellModel.h"

@interface DaiBanViewController()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIButton *ibCheckAllButton;

@end

@implementation DaiBanViewController

#pragma mark - def
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
    DaiBanCellView *shopCell = [tableView dequeueReusableCellWithIdentifier:@"DaiBanCellView"];
    DaiBanCellModel *model = [self.dataArray objectAtIndex:indexPath.row];
    shopCell.dbModel = model;
    return shopCell;
}

- (IBAction)ibaZhifaAction:(id)sender {
    //TODO: 批量执法
}
- (IBAction)ibaResetCheckAllButtonAction:(id)sender {
    if (_ibCheckAllButton.isSelected) _ibCheckAllButton.selected = NO;
}

- (IBAction)ibaCheckAllAction:(UIButton *)sender {
    sender.selected = sender.isSelected?NO:YES;
    for (DaiBanCellModel *model in self.dataArray) {
        model.isEditing = sender.isSelected;
    }
    [self.tableView reloadData];
}


@end

