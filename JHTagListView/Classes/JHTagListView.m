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
#import "StoreAllTypeModel.h"
#import "JHFilterStoreTypeCell.h"
#import "JHFilterPatrolTimeCell.h"

//#import "ReqFilterServer.h"

#import "StoreLocationModel.h"
#import "YZTagList.h"

@interface JHTagListView()
@property (strong, nonatomic) IBOutlet UITableView *ibTableView;
//动画
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ibTableViewToLeftViewConut;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ibShadeToFilterViewConut;
@property (nonatomic, strong) NSMutableArray *groups; //主体业态collection/区域选择taglist/检查时间

@property (strong, nonatomic) YZTagList *storeLocTagList;
@property (strong, nonatomic) YZTagList *storeStatusTagList;
@end

@implementation JHTagListView
{
    BOOL _isHiddenFilterView;
}


-(void)setupFilterView:(NSArray *)dataArray{
    // 添加余下组

    _ibTableView.estimatedRowHeight = 50;
    //默认隐藏过滤Table
    _ibTableViewToLeftViewConut.constant = [UIScreen mainScreen].bounds.size.width;
    if ([[UIScreen mainScreen] currentMode].size.width > 640) {
        _ibShadeToFilterViewConut.constant = 100;
    }
}

#pragma mark - table dataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) return self.storeLocTagList.frame.size.height;
    if (indexPath.section == 3) return self.storeStatusTagList.frame.size.height;
    return UITableViewAutomaticDimension;
//    JHGroupItem *item = [self.groups objectAtIndex:indexPath.section];
//    CGFloat height;
//    if (item.cellVH > 0) {
//        //当第一次加载时，二级tableViewCell高度无法获取到
//        height = item.cellVH;
//    }else{
//        JHTagGroupItem *tag = item.data[0];
//        if (indexPath.section == 0) {
//            height = item.data.count * 45;
//        }else{
//            height = tag.dpCellH;
//        }
//    }
//    return height + 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    JHGroupItem *sec = self.groups[section];
    label.text = sec.name;
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        JHGroupItem *sec = self.groups[section];
        return sec.data.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JHFilterStoreLocCell"];
    switch (indexPath.section) {
        case 0:
        {
            JHFilterStoreTypeCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"JHFilterStoreTypeCell"];
            JHGroupItem *sec = self.groups[indexPath.section];
            JHTagGroupItem *tagGroupItem = sec.data[indexPath.row];
            cell1.typeName = tagGroupItem.name;
            cell1.tagArr = [tagGroupItem.data copy];
            cell = cell1;
        }
            break;
        case 1:
        {
            [cell.contentView addSubview: self.storeLocTagList];
        }
            break;
        case 2:
        {
            JHFilterPatrolTimeCell *timeCell = [tableView dequeueReusableCellWithIdentifier:@"JHFilterPatrolTimeCell"];
            cell = timeCell;
        }
            break;
        case 3:
        {
            [cell.contentView addSubview:self.storeStatusTagList];
        }
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark 拉去数据
-(void)parseFilterStoreTypeData:(NSArray *)allTypeArr{
    //解析单元
    JHGroupItem *section = [JHGroupItem new];
    section.name = @"主体业态";
    JHTagGroupItem *groupItem1 = [self testData];
    groupItem1.name = @"大众餐饮";
    JHTagGroupItem *groupItem2 = [self testData];
    groupItem2.name = @"集体配餐";
    [section.data addObjectsFromArray:@[groupItem1,groupItem2]];
    //主体业态
    [self.groups addObject:section];
}

-(JHTagGroupItem *)testData{
    //解析单元格
    JHTagGroupItem *groupItem = [JHTagGroupItem new];
    JHTagItem *all = [JHTagItem new];
    all.name = @"全部";
    all.cellid = @"";
    all.level = @"1";
    all.isSelected = YES;
    [groupItem.data addObject:all];
    for (int i =0; i<7;i++) {
        JHTagItem *item = [JHTagItem new];
        item.name = @"校内食堂";
        item.cellid = @"ddddddd1232";
        item.level = @"2";
        [groupItem.data addObject:item];
    }
    return groupItem;
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
    section.name = @"区域选择";
    //解析单元格
    JHTagGroupItem *groupItem = [self testData];
    [section.data addObject:groupItem];
    //选择分局
    [self.groups addObject:section];
}
-(void)parsePatrolTimeData
{
    JHGroupItem *section = [JHGroupItem new];
    section.name = @"检查时间";
    //检查状态
    [self.groups addObject:section];
}
-(void)parseFilterStoreStatus{
    NSArray *statusArr = @[@"全部",@"已检查",@"未检查"];
    //解析单元
    JHGroupItem *section = [JHGroupItem new];
    section.name = @"执法状态";
    //解析单元格
    JHTagGroupItem *groupItem = [JHTagGroupItem new];
    groupItem.isOpened = YES;
    JHTagItem *item = [JHTagItem new];
    item.name = statusArr[0];
    item.isSelected = YES;
    item.cellid = @"2";
    [groupItem.data addObject:item];
    JHTagItem *item2 = [JHTagItem new];
    item2.name = statusArr[1];
    item2.cellid = @"0";
    [groupItem.data addObject:item2];
    JHTagItem *item3 = [JHTagItem new];
    item3.name = statusArr[2];
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
    ///test
    [self parseFilterStoreTypeData:nil];
    [self parseFilterStoreLocationData:nil];
    [self parsePatrolTimeData];
    [self parseFilterStoreStatus];
    ///endtest
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

-(YZTagList *)storeLocTagList
{
    if (!_storeLocTagList) {
        // 创建标签列表
        _storeLocTagList = [[YZTagList alloc] init];
        //    tagList.backgroundColor = [UIColor brownColor];
        // 高度可以设置为0，会自动跟随标题计算
        _storeLocTagList.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 0);
        _storeLocTagList.tagBackgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        _storeLocTagList.tagFont = [UIFont systemFontOfSize:15];
        _storeLocTagList.tagButtonMargin = 10;
        _storeLocTagList.tagCornerRadius = 8;
        _storeLocTagList.tagMargin = 20;
        _storeLocTagList.tagColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
        // 点击标签，就会调用,点击标签，删除标签
        __weak typeof(self) weakSelf = self;
        _storeLocTagList.clickTagBlock = ^(NSString *tag){
            [weakSelf onClickTag:tag];
        };
        //test
        [_storeLocTagList addTags:@[@"123呃呃呃呃呃",@"321",@"231",@"123水电费水电费"]];
    }
    return _storeLocTagList;
}
-(YZTagList *)storeStatusTagList
{
    if (!_storeStatusTagList) {
        // 创建标签列表
        _storeStatusTagList = [[YZTagList alloc] init];
        //    tagList.backgroundColor = [UIColor brownColor];
        // 高度可以设置为0，会自动跟随标题计算
        _storeStatusTagList.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 0);
        _storeStatusTagList.tagBackgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        _storeStatusTagList.tagFont = [UIFont systemFontOfSize:15];
        _storeStatusTagList.tagButtonMargin = 10;
        _storeStatusTagList.tagCornerRadius = 8;
        _storeStatusTagList.tagMargin = 20;
        _storeStatusTagList.tagColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
        // 点击标签，就会调用,点击标签，删除标签
        __weak typeof(self) weakSelf = self;
        _storeStatusTagList.clickTagBlock = ^(NSString *tag){
            [weakSelf onClickTag:tag];
        };
        NSArray *statusArr = @[@"全部",@"已检查",@"未检查"];
        [_storeStatusTagList addTags:statusArr];
    }
    return _storeStatusTagList;
}
-(void)onClickTag:(NSString *)tag{
    
}
@end
