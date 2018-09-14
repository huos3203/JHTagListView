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
#import "JHFilterTagList.h"
#import "JHTagModel.h"
//#import "ReqFilterServer.h"
#import "StoreLocationModel.h"

@interface JHTagListView()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *ibTableView;
//动画
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ibTableViewToLeftViewConut;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ibShadeToFilterViewConut;
@property (nonatomic, strong) NSMutableArray *groups; //主体业态collection/区域选择taglist/检查时间

@property (strong, nonatomic) JHFilterTagList *storeLocTagList;
@property (strong, nonatomic) JHFilterTagList *storeStatusTagList;
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
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    JHGroupItem *sec = self.groups[section];
    return sec.name;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"headerColor1"]];
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
    [footer.textLabel setTextColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"headerTitleColor"]]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
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

-(void)parseFilterStoreLocationData:(NSArray *)itemArr
{
    //解析单元
    JHGroupItem *section = [JHGroupItem new];
    section.name = @"区域选择";
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
    //解析单元
    JHGroupItem *section = [JHGroupItem new];
    section.name = @"执法状态";
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
    if (self.groups.count == 0) {
        [self parseFilterStoreTypeData:nil];
        [self parseFilterStoreLocationData:nil];
        [self parsePatrolTimeData];
        [self parseFilterStoreStatus];
    }
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

-(JHFilterTagList *)storeLocTagList
{
    if (!_storeLocTagList) {
        // 创建标签列表
        _storeLocTagList = [[JHFilterTagList alloc] init];
        //test
        JHTagModel *model = [JHTagModel new];
        model.title = @"全部";
        JHTagModel *model2 = [JHTagModel new];
        model2.title = @"已检查";
        JHTagModel *model3 = [JHTagModel new];
        model3.title = @"未检查";
        JHTagModel *model4 = [JHTagModel new];
        model4.title = @"通过";
        [_storeLocTagList addTags:@[model,model2,model3,model4]];
    }
    return _storeLocTagList;
}
-(JHFilterTagList *)storeStatusTagList
{
    if (!_storeStatusTagList) {
        // 创建标签列表
        _storeStatusTagList = [[JHFilterTagList alloc] init];
        JHTagModel *model = [JHTagModel new];
        model.title = @"全部";
        JHTagModel *model2 = [JHTagModel new];
        model2.title = @"已检查";
        JHTagModel *model3 = [JHTagModel new];
        model3.title = @"未检查";
        JHTagModel *model4 = [JHTagModel new];
        model4.title = @"通过";
        NSArray *statusArr = @[model,model2,model3,model4];
        [_storeStatusTagList addTags:statusArr];
    }
    return _storeStatusTagList;
}
-(void)onClickTag:(NSString *)tag{
    
}
@end
