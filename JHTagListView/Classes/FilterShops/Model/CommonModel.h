//
//  CommonModel.h
//  YGPatrol
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CommonModel : NSObject

/// 组织id
@property (strong, nonatomic) NSString *orgId;
/// 应用id
@property (strong, nonatomic) NSString *appId;
/// 用户id
@property (strong, nonatomic) NSString *userId;
/// 客户端类型
@property (assign, nonatomic) NSInteger clientType;
@end
