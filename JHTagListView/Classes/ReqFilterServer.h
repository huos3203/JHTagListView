//
//  ReqFilterServer.h
//  YGPatrol
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JHURLRequest;
@class CommonModel;
@class ReqFilterStoreModel;
@class RestStoreListModel;
@class StoreAllTypeModel;
@class StoreLocationModel;
@interface ReqFilterServer : NSObject
+(id)shared;
@property (nonatomic, strong) JHURLRequest * request;
-(void)reqStoreList:(ReqFilterStoreModel *)model Handler:(void(^)(NSArray<RestStoreListModel *> *listModel))handler;
-(void)reqStoreTypeHandler:(void(^)(NSArray<StoreAllTypeModel *> *listModel))handler;
-(void)reqStoreLocationHandler:(void(^)(NSArray<StoreLocationModel *> *listModel))handler;
@end
