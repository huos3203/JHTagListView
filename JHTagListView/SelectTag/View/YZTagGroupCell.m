//
//  YZTagCell.m
//  YZTagListDemo
//
//  Created by yz on 16/8/16.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "YZTagGroupCell.h"
#import "YZTagCell.h"
#import "JHTagGroupItem.h"
#import "JHTagItem.h"
#import "YZGroupHeaderView.h"


extern CGFloat const itemH;
static NSString * const tagCell = @"tagCell";
@interface YZTagGroupCell ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *tagGroupLabel;

@end

@implementation YZTagGroupCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    UICollectionViewFlowLayout *layout = self.collectionView.collectionViewLayout;
//    CGFloat margin = 0;
//    CGFloat cols = 2;
//    CGFloat itemW = (self.collectionView.frame.size.width - (cols + 1) * margin) / cols;
//    layout.itemSize = CGSizeMake(itemW, itemH);
//    layout.minimumInteritemSpacing = margin;
//    layout.minimumLineSpacing = 10;
    
//    // 设置collectionView
//    self.collectionView.dataSource = self;
//    self.collectionView.scrollEnabled = NO;
//    self.collectionView.backgroundColor = [UIColor whiteColor];
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"JHPatrolResources" ofType:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PatrolTagCell" bundle:resourceBundle] forCellWithReuseIdentifier:@"PatrolTagCell"];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = self.collectionView.collectionViewLayout;
    CGFloat margin = 10;
    CGFloat cols = 2;
    CGFloat itemW = (self.contentView.frame.size.width - (cols + 1) * margin) / cols;
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = 10;
}

- (void)setTagGroup:(JHTagGroupItem *)tagGroup
{
    _tagGroup = tagGroup;
    if (_tagGroupLabel) {
        _tagGroupLabel.text = tagGroup.name;
    }
    if (_ibCellHeaderView) {
        _ibCellHeaderView.groupLabel.text = tagGroup.name;
    }
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _tagGroup.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YZTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PatrolTagCell" forIndexPath:indexPath];
    JHTagItem *item = _tagGroup.data[indexPath.row];
    cell.item = item;

    return cell;
}
@end
