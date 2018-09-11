//
//  RestStoreListModel.h
//  YGPatrol
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface RestStoreListModel : NSObject
/// id
@property (strong, nonatomic) NSString *Id;
/// 名称
@property (strong, nonatomic) NSString *Name;
/// 地址
@property (strong, nonatomic) NSString *Address;
/// 许可证
@property (strong, nonatomic) NSString *LicenceCode;
/// 有效期
@property (strong, nonatomic) NSString *LicenseExpire;
/// 门店状态
@property (assign, nonatomic) NSInteger StoreStatus;
///0已检查，1未检查
@property (assign, nonatomic) NSInteger InspectStatus;
@end
