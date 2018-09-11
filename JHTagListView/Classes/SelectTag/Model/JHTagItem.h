//
//  JHTagItem.h
//  YGPatrol
//
//  Created by VH on 2018/1/25.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHTagItem : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *cellid;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, assign) BOOL isSelected;
+ (instancetype)tagWithDict:(NSDictionary *)dict;

@end
