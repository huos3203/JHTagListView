//
//  YZTagCell.h
//  YZTagListDemo
//
//  Created by yz on 16/8/16.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHTagGroupItem;
@class YZGroupHeaderView;
@interface YZTagGroupCell : UITableViewCell

@property (nonatomic, strong) JHTagGroupItem *tagGroup;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ibHeadTitleEqualCell;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ibCellTitleConstraint;
@property (strong, nonatomic) IBOutlet YZGroupHeaderView *ibCellHeaderView;


@end
