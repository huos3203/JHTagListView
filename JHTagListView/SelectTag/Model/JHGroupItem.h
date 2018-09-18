//
//  JHGroupItem.h
//  YGPatrol
//
//  Created by VH on 2018/1/25.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHGroupItem : NSObject
{
    @protected NSMutableArray *_data;
}
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) float cellVH;
@property (nonatomic, assign) NSInteger sectionStyle;  //0:主体业态 1:选择分局 2:检查情况
+ (instancetype)groupWithDict:(NSDictionary *)dict;
@end
