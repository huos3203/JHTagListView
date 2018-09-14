//
//  JHFilterStoreTypeCell.m
//  JHTagListView_Example
//
//  Created by admin on 2018/9/13.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import "JHFilterStoreTypeCell.h"
#import "YZTagCell.h"
#import "JHTagItem.h"

@interface JHFilterStoreTypeCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *ibTypeLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation JHFilterStoreTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = self.collectionView.collectionViewLayout;
    CGFloat margin = 10;
//    CGFloat cols = 2;
    CGFloat itemW = 80;
    layout.itemSize = CGSizeMake(itemW, 30);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = 10;
}
-(void)setTypeName:(NSString *)typeName
{
    _ibTypeLabel.text = typeName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tagArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JHTagItem *item = self.tagArr[indexPath.row];
    NSString *cellId = @"CellIsDefault";
    if (item.isSelected) {
        cellId = @"CellIsSelected";
        [_collectionView selectItemAtIndexPath:indexPath
                                      animated:NO
                                scrollPosition:UICollectionViewScrollPositionNone];
    }
    YZTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.item = item;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JHTagItem *item = self.tagArr[indexPath.row];
    if (indexPath.row == 0) {
        item.isSelected = YES;
        [self resetItemStatus];
    }else{
         JHTagItem *firstItem = self.tagArr[0];
        firstItem.isSelected = NO;
        item.isSelected = item.isSelected?NO:YES;
    }
    [collectionView reloadData];
}

//取消选择
-(void)resetItemStatus
{
    for (int i = 1; i < self.tagArr.count; i++) {
        JHTagItem *item = self.tagArr[i];
        item.isSelected = NO;
    }
}

@end
