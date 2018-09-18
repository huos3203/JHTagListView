//
//  JHGroupItem.m
//  YGPatrol
//
//  Created by VH on 2018/1/25.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "JHGroupItem.h"
#import "JHTagGroupItem.h"

@implementation JHGroupItem

+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    JHGroupItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}

-(NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray new];
    }
    return _data;
}

- (void)setData:(NSMutableArray *)data
{
    NSMutableArray *datas = [NSMutableArray array];
    
    for (NSDictionary *dict in data) {
        JHTagGroupItem *tagGroup = [JHTagGroupItem tagGroupWithDict:dict];
        [datas addObject:tagGroup];
    }
    
    _data = datas;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
