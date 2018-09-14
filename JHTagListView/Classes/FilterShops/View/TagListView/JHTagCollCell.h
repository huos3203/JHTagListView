//
//  JHTagCollCell.h
//  JHTagListView_Example
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHTagItem;
@interface JHTagCollCell : UICollectionViewCell
@property (nonatomic, strong) JHTagItem *item;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@end
