//
//  JHTagGroupItem.h
//  YGPatrol
//
//  Created by VH on 2018/1/25.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "JHGroupItem.h"

@interface JHTagGroupItem : JHGroupItem

+ (instancetype)tagGroupWithDict:(NSDictionary *)dict;

- (CGFloat)cellH;
- (CGFloat)dpCellH;
@property (assign, nonatomic) BOOL isOpened;
@end
