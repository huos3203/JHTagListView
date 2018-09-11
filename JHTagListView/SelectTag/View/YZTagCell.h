//
//  YZTagCell.h
//  YZTagListDemo
//
//  Created by yz on 16/8/16.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHTagItem;
@interface YZTagCell : UICollectionViewCell
@property (nonatomic, strong) JHTagItem *item;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ibCheckedImgView;

@end
