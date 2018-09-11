//
//  StoreAllTypeModel.h
//  YGPatrol
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface StoreAllTypeModel : NSObject
/// 门店类型id
@property (strong, nonatomic) NSString *Id;
/// 门店类型名称
@property (strong, nonatomic) NSString *Name;
/// 门店类型父级id
@property (strong, nonatomic) NSString *ParentId;
@end
