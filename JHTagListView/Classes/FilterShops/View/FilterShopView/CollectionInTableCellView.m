//
//  CollectionInTableCellView.m
//  YGPatrol
//
//  Created by admin on 2018/5/17.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "CollectionInTableCellView.h"
#import "JHTagGroupItem.h"
#import "YZTagCell.h"
#import "JHTagItem.h"
@implementation CollectionInTableCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(void)layoutSubviews{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = self.collectionView.collectionViewLayout;
    CGFloat margin = 10;
    CGFloat cols = 2;
    CGFloat itemW = (self.contentView.frame.size.width - (cols + 1) * margin) / cols;
    layout.itemSize = CGSizeMake(itemW, 30);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = 10;
}

-(void)setTagCollection:(JHTagGroupItem *)tagCollection
{
    _tagCollection = tagCollection;
    [_collectionView reloadData];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _tagCollection.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JHTagItem *item = _tagCollection.data[indexPath.row];
    NSString *cellId = @"PatrolTagCell";
    if (item.isSelected) {
        [_collectionView selectItemAtIndexPath:indexPath
                                      animated:NO
                                scrollPosition:UICollectionViewScrollPositionNone];
    }
    switch (_tagCollection.sectionStyle) {
        case 0:
            cellId = item.isSelected ? @"PatrolTagCell5":@"PatrolTagCell1";
            break;
        case 1:
            cellId = item.isSelected ? @"PatrolTagCell2":@"PatrolTagCell1";
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                    cellId = item.isSelected ? @"PatrolTagCell2":@"PatrolTagCell1";
                    break;
                case 1:
                    cellId = item.isSelected ? @"PatrolTagCell6":@"PatrolTagCell7";
                    break;
                case 2:
                    cellId = item.isSelected ? @"PatrolTagCell4":@"PatrolTagCell3";
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    YZTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.item = item;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //选中时
    JHTagItem *item = _tagCollection.data[indexPath.row];
    item.isSelected = YES;
    [_collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //未选中时
    JHTagItem *item = _tagCollection.data[indexPath.row];
    item.isSelected = NO;
    [_collectionView reloadItemsAtIndexPaths:@[indexPath]];
}
@end
