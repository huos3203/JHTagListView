//
//  FilterStoreModel.h
//  YGPatrol
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "CommonModel.h"
typedef enum : NSUInteger {
    DefaultALLNone,
    HaveInspected,
    NotInspected,
} InspectedStatus;
@interface ReqFilterStoreModel : CommonModel
/// 街道id或者区域编码
@property (strong, nonatomic) NSString *locationId;
/// 街道级别：省1市2区3街道4社区5
@property (assign, nonatomic) NSInteger locationLevel;
///餐饮类型
@property (strong, nonatomic) NSString *storeTypeId;
/// 餐饮级别：一级1 二级2
@property (assign, nonatomic) NSInteger storeTypeLevel;
/// 门店检查情况
@property (assign, nonatomic) InspectedStatus inspectEnum;
/// 搜索关键字
@property (strong, nonatomic) NSString *keywords;
/// 门店个数
@property (assign, nonatomic) NSInteger count;
/// 时间戳-根据添加时间过滤
@property (strong, nonatomic) NSString *time;
@property (assign, nonatomic) NSInteger pageNo;
@end
