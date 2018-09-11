//
//  TableCellViewInCell.m
//  YGPatrol
//
//  Created by admin on 2018/5/17.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "TableCellViewInCell.h"
#import "JHTagGroupItem.h"
#import "JHGroupItem.h"
#import "JHTagItem.h"
#import "YZGroupHeaderView.h"
#import "CollectionInTableCellView.h"

@interface TableCellViewInCell()<UITableViewDelegate,FoldSectionHeaderViewDelegate>

@end

@implementation TableCellViewInCell
{
    NSMutableDictionary *_foldInfoDic;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _foldInfoDic = [NSMutableDictionary new];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setTagGroup:(JHGroupItem *)tagGroup{
    _tagGroup = tagGroup;
//    JHTagGroupItem *item = tagGroup.data[0];
//    if (item.cellVH == 0 && !_singleSection) {
//        item.isOpened = YES;
//    }
    [_ibTableView reloadData];
//    [self reloadSuperTableView];
}

#pragma mark - table dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JHTagGroupItem *item = self.tagGroup.data[indexPath.section];
    return item.dpCellH;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(_singleSection)
        return nil;
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"JHPatrolResources" ofType:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    YZGroupHeaderView *headerView = [[resourceBundle loadNibNamed:@"PatrolHeaderView" owner:nil options:nil] firstObject];
    headerView.headViewTopConstraint.constant = 0;
    JHTagGroupItem *item = self.tagGroup.data[section];
    NSString *img = @"dpxiala1";
    if (item.isOpened) {
        img = @"dpxuanzhong";
        headerView.groupLabel.textColor = [UIColor colorWithRed:15.0/225.0 green:175.0/225.0 blue:28.0/225.0 alpha:1.0];
        headerView.backgroundColor = [UIColor colorWithRed:206.0/225.0 green:239.0/225.0 blue:210.0/225.0 alpha:1.0];
    }
    headerView.groupLabel.text = item.name;
    [headerView.ibFoldButton setImage:[UIImage imageNamed:img inBundle:resourceBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    headerView.layer.cornerRadius = 8;
    headerView.delegate = self;
    headerView.section = section;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_singleSection) {
        return 0.01;
    }
    return 30;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_singleSection) {
        return 1;
    }
    return self.tagGroup.data.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    JHTagGroupItem *item = self.tagGroup.data[section];
    if (_singleSection) {
        return 1;
    }
    return item.isOpened?1:0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CollectionInTableCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"InCellTableViewCell"];
    JHTagGroupItem *item = self.tagGroup.data[indexPath.section];
    item.sectionStyle = self.tagGroup.sectionStyle;
    cell.tagCollection = item;
    return cell;
}

#pragma mark - view event
//点击主体业态header 隐藏子cell
- (void)foldHeaderInSection:(NSInteger)section {
    JHTagGroupItem *item = self.tagGroup.data[section];
    if (item.isOpened) return;
    for (int i = 0; i < self.tagGroup.data.count; i++) {
        JHTagGroupItem *item = self.tagGroup.data[i];
        if (item.isOpened) {
            //当即将关闭时，重置，并设置第一个为选中状态
            for (int j = 0; j <item.data.count; j++) {
                JHTagItem *tag = item.data[j];
                if (j == 0) {
                    tag.isSelected = YES;
                    continue;
                }
                if (tag.isSelected) {
                    tag.isSelected = NO;
                    break;
                }
            }
        }
        if (i == section) {
            item.isOpened = !item.isOpened;
        }else{
            item.isOpened = NO;
        }
    }
    [self reloadSuperTableView];
}
-(void)reloadSuperTableView
{
    [_ibTableView reloadData];
    //[self performSelector:@selector(reloadSuperTableView) withObject:self afterDelay:2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _tagGroup.cellVH = _ibTableView.contentSize.height;
        _RefreshTableViewBlock();
    });
}
@end
