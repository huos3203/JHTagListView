//
//  CollectionInTableCellView.h
//  YGPatrol
//
//  Created by admin on 2018/5/17.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHTagGroupItem;
@interface CollectionInTableCellView : UITableViewCell<UICollectionViewDelegate>

@property (nonatomic, strong) JHTagGroupItem *tagCollection;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end
