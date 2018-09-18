//
//  YZTagGroupItem.h
//  YZTagListDemo
//
//  Created by yz on 16/8/15.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHGroupItem.h"
#import <UIKit/UIKit.h>
@interface YZTagGroupItem : JHGroupItem

+ (instancetype)tagGroupWithDict:(NSDictionary *)dict;

- (CGFloat)cellH;

@end
