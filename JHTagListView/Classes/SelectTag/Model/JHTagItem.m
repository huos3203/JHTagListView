//
//  JHTagItem.m
//  YGPatrol
//
//  Created by VH on 2018/1/25.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "JHTagItem.h"

@implementation JHTagItem


+ (instancetype)tagWithDict:(NSDictionary *)dict
{
    JHTagItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
