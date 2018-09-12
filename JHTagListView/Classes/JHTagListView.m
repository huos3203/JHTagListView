//
//  JHTagListView.m
//  JHTagListView_Example
//
//  Created by admin on 2018/9/11.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import "JHTagListView.h"
#import "JHGroupItem.h"
#import "JHTagItem.h"
#import "JHTagGroupItem.h"
#import "YZTagGroupCell.h"
#import "YZGroupHeaderView.h"
#import "TableCellViewInCell.h"
//#import "ReqFilterServer.h"

#import "StoreLocationModel.h"

@interface JHTagListView()
@property (strong, nonatomic) IBOutlet UITableView *ibTableView;
//动画
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ibTableViewToLeftViewConut;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ibShadeToFilterViewConut;
@property (nonatomic, strong) NSMutableArray *groups;
@end

@implementation JHTagListView
{
    NSMutableArray *_headerViewArray;
    NSBundle *_resourceBundle;
    BOOL _isHiddenFilterView;
}


-(void)setupFilterView:(NSArray *)dataArray{
    // 添加余下组

    _ibTableView.estimatedRowHeight = 100;
    //默认隐藏过滤Table
    _ibTableViewToLeftViewConut.constant = [UIScreen mainScreen].bounds.size.width;
    if ([[UIScreen mainScreen] currentMode].size.width > 640) {
        _ibShadeToFilterViewConut.constant = 100;
    }
    [self createHeaderView];
}

#pragma mark - table dataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHGroupItem *item = [self.groups objectAtIndex:indexPath.section];
    CGFloat height;
    if (item.cellVH > 0) {
        //当第一次加载时，二级tableViewCell高度无法获取到
        height = item.cellVH;
    }else{
        JHTagGroupItem *tag = item.data[0];
        if (indexPath.section == 0) {
            height = item.data.count * 45;
        }else{
            height = tag.dpCellH;
        }
    }
    return height + 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 120) return nil;
    return _headerViewArray[section];
}
-(void)createHeaderView{
    _headerViewArray = [NSMutableArray new];
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"JHPatrolResources" ofType:@"bundle"];
    _resourceBundle = [NSBundle bundleWithPath:bundlePath];
    for (int section = 0; section < 3; section++) {
        //
        YZGroupHeaderView *headerView = [[_resourceBundle loadNibNamed:@"PatrolHeaderView" owner:nil options:nil] firstObject];
        switch (section) {
            case 0:
                headerView.groupLabel.text = @"主体业态";
                break;
            case 1:
                headerView.groupLabel.text = @"选择分局";
                headerView.headerLineLabel.hidden = NO;
                break;
            case 2:
                headerView.groupLabel.text = @"检查情况";
                headerView.headerLineLabel.hidden = NO;
                break;
            default:
                break;
        }
        headerView.backgroundColor = [UIColor whiteColor];
        headerView.delegate = self;
        headerView.section = section;
        [_headerViewArray addObject:headerView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == 120) return 1;
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableCellViewInCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RootTableCellView" forIndexPath:indexPath];
    cell.RefreshTableViewBlock = ^{
        [_ibTableView reloadData];
    };
    if (indexPath.section > 0) {
        cell.singleSection = YES;
    }else{
        cell.singleSection = NO;
    }
    if (self.groups.count > 2) {
        JHGroupItem *group = self.groups[indexPath.section];
        group.sectionStyle = indexPath.section;
        cell.tagGroup = group;
    }
    return cell;
}

#pragma mark - delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 120) {
    }
}
#pragma mark 拉去数据



-(void)parseFilterStoreTypeData:(NSArray *)allTypeArr{
    //解析单元
    JHGroupItem *section = [JHGroupItem new];
    section.name = @"主体业态";
    NSArray *topArr = [self parseModel:allTypeArr ToItemBy:@"00000000-0000-0000-0000-000000000000"];
//    for (StoreAllTypeModel *groupType in topArr) {
//        //解析单元格
//        JHTagGroupItem *groupItem = [JHTagGroupItem new];
//        JHTagItem *all = [JHTagItem new];
//        all.name = @"全部";
//        all.cellid = groupType.Id;
//        all.level = @"1";
//        all.isSelected = YES;
//        [groupItem.data addObject:all];
//        groupItem.name = groupType.Name;
//        NSArray *itemArr = [self parseModel:allTypeArr ToItemBy:groupType.Id];
//        for (StoreAllTypeModel *model in itemArr) {
//            JHTagItem *item = [JHTagItem new];
//            item.name = model.Name;
//            item.cellid = model.Id;
//            item.level = @"2";
//            [groupItem.data addObject:item];
//        }
//        [section.data addObject:groupItem];
//    }
    //主体业态
    [self.groups addObject:section];
}
-(NSArray *)parseModel:(NSArray *)sourceArr ToItemBy:(NSString *)parentId{
    NSString *predicateStr = [NSString stringWithFormat:@"ParentId contains [cd] '%@'",parentId];
    NSPredicate *topPredicate = [NSPredicate predicateWithFormat:predicateStr];
    NSArray *topArr = [sourceArr filteredArrayUsingPredicate:topPredicate];
    return topArr;
}
-(void)parseFilterStoreLocationData:(NSArray *)itemArr
{
    //解析单元
    JHGroupItem *section = [JHGroupItem new];
    //解析单元格
    JHTagGroupItem *groupItem = [JHTagGroupItem new];
    groupItem.isOpened = YES;
    JHTagItem *all = [JHTagItem new];
    all.name = @"全部";
    all.cellid = @"";
    all.isSelected = YES;
    [groupItem.data addObject:all];
    for (StoreLocationModel *model in itemArr) {
        JHTagItem *item = [JHTagItem new];
        item.name = model.Name;
        item.cellid = model.Code;
        item.level = model.Level;
        [groupItem.data addObject:item];
    }
    [section.data addObject:groupItem];
    //选择分局
    [self.groups addObject:section];
}

-(void)parseFilterStoreStatus{
    //解析单元
    JHGroupItem *section = [JHGroupItem new];
    //解析单元格
    JHTagGroupItem *groupItem = [JHTagGroupItem new];
    groupItem.isOpened = YES;
    JHTagItem *item = [JHTagItem new];
    item.name = @"全部";
    item.isSelected = YES;
    item.cellid = @"2";
    [groupItem.data addObject:item];
    JHTagItem *item2 = [JHTagItem new];
    item2.name = @"已检查";
    item2.cellid = @"0";
    [groupItem.data addObject:item2];
    JHTagItem *item3 = [JHTagItem new];
    item3.name = @"未检查";
    item3.cellid = @"1";
    [groupItem.data addObject:item3];
    [section.data addObject:groupItem];
    //检查状态
    [self.groups addObject:section];
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGFloat kx = [gestureRecognizer locationInView:self].x;
    BOOL yB = (kx < 50);
    if (yB) {
        return true;
    }
    return false;
}

-(void)loadDataList:(dispatch_group_t)group{
    //    [Utility showProgressDialogText:@"正在加载..."];
    if (!group) {
        return;
    }
//    dispatch_group_enter(group);
//    [[ReqFilterServer shared] reqStoreTypeHandler:^(NSArray<StoreAllTypeModel *> *listModel) {
//        //主体业态
//        [self parseFilterStoreTypeData:listModel];
//        dispatch_group_leave(group);
//    }];
//    dispatch_group_enter(group);
//    [[ReqFilterServer shared] reqStoreLocationHandler:^(NSArray<StoreLocationModel *> *listModel) {
//        //分局地址
//        [self parseFilterStoreLocationData:listModel];
//        ///先加载已经指定的检查情况
//        dispatch_group_leave(group);
//    }];
}

-(void)showListView
{
    [UIView animateWithDuration:.2 animations:^{
        _ibTableViewToLeftViewConut.constant = _isHiddenFilterView?[UIScreen mainScreen].bounds.size.width:0;
    } completion:^(BOOL finished) {
        if (!_isHiddenFilterView) {
            [_ibTableView reloadData];
        }
        _isHiddenFilterView = !_isHiddenFilterView;
    }];
}

#pragma mark - getter / setter
- (NSArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}
@end
