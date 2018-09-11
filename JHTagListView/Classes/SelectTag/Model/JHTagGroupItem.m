//
//  JHTagGroupItem.m
//  YGPatrol
//
//  Created by VH on 2018/1/25.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "JHTagGroupItem.h"
#import "JHGroupItem.h"
#import "JHTagItem.h"
CGFloat const itemH = 30;
@implementation JHTagGroupItem
+ (instancetype)tagGroupWithDict:(NSDictionary *)dict
{
    JHTagGroupItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}
- (void)setData:(NSMutableArray *)data
{
    NSMutableArray *datas = [NSMutableArray array];
    for (NSDictionary *dict in data) {
        JHTagItem *tagGroup = [JHTagItem tagWithDict:dict];
        [datas addObject:tagGroup];
    }
    _data = datas;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (CGFloat)cellH
{
    CGFloat originY = 27;
    CGFloat margin = 10;
    
    NSInteger cols = 4;
    NSInteger rows = (self.data.count - 1) / cols + 1;
    return rows * (itemH + margin) + originY;
}
- (CGFloat)dpCellH
{
    CGFloat margin = 10;
    NSInteger cols = 2;
    NSInteger rows = (self.data.count - 1) / cols + 1;
    return rows * (itemH + margin);
}

@end
