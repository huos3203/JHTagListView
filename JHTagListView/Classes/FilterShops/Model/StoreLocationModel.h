//
//  AllLocationModel.h
//  YGPatrol
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface StoreLocationModel : NSObject

/// 街道或者区域编码
@property (strong, nonatomic) NSString *Code;
/// 门店名称
@property (strong, nonatomic) NSString *Name;
/// 区域级别
@property (strong, nonatomic) NSString *Level;

@end
