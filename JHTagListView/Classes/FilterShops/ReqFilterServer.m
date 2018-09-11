//
//  ReqFilterServer.m
//  YGPatrol
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "ReqFilterServer.h"
#import "JHURLRequest.h"
#import "CommonModel.h"
#import "ReqFilterStoreModel.h"
#import "RestStoreListModel.h"
#import "StoreAllTypeModel.h"
#import "StoreLocationModel.h"

#define ReqStoreFilter @"rips.iuoooo.com/Jinher.AMP.RIP.SV.InspectAssistantSV.svc/StoreFilterNew"
#define GetStoreAllType @"rips.iuoooo.com/Jinher.AMP.RIP.SV.InspectAssistantSV.svc/GetStoreAllType"
#define GetAllLocations @"rips.iuoooo.com/Jinher.AMP.RIP.SV.InspectAssistantSV.svc/GetAllLocations"
@implementation ReqFilterServer

+(id)shared {
    static ReqFilterServer *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (JHURLRequest *)request {
    
    if (!_request) {
        _request = [[JHURLRequest alloc] init];
    }
    return _request;
}

-(void)reqStoreList:(ReqFilterStoreModel *)model Handler:(void (^)(NSArray<RestStoreListModel *> *))handler{
    if (model.pageNo == 0) {
        model.pageNo = 1;
    }
    NSMutableDictionary * param = [[model toDictionary] mutableCopy];
//    if (!model.time || [model.time isKindOfClass:[NSNull class]]) {
//        [param removeObjectForKey:@"time"];
//    }
    [param removeObjectForKey:@"time"];
    [self.request startPOSTRequestWithUrl:ReqStoreFilter
                               parameters:@{@"commonParam":param}
                                resHander:^(NSDictionary *resData) {
                                    BOOL isSuccess = [[resData objectForKey:@"IsSuccess"] boolValue];
                                    NSString *timestr = [resData objectForKey:@"Data"];
                                    if (![timestr isKindOfClass:[NSNull class]]) {
                                        model.time = timestr;
                                    }
                                    NSArray *arry = [resData objectForKey:@"Content"];
                                    if (isSuccess && ![arry isEqual:[NSNull null]] && arry.count > 0) {
                                        model.pageNo+=1;
                                        NSArray* models = [RestStoreListModel arrayOfModelsFromDictionaries:arry];
                                        handler(models);
                                    }else{
                                        handler(nil);
                                    }
                                    
                                } resError:^(NSString *error) {
                                    NSLog(@"%@",error);
                                    handler(nil);
                                }];
}

-(void)reqStoreTypeHandler:(void (^)(NSArray<StoreAllTypeModel *> *))handler
{
    NSDictionary * param = [[CommonModel new] toDictionary];
    [self.request startPOSTRequestWithUrl:GetStoreAllType
                               parameters:@{@"commonParam":param}
                                resHander:^(NSDictionary *resData) {
                                    BOOL isSuccess = [[resData objectForKey:@"IsSuccess"] boolValue];
                                    NSArray *arry = [resData objectForKey:@"Content"];
                                    if (isSuccess && ![arry isEqual:[NSNull null]]) {
                                        NSArray* models = [StoreAllTypeModel arrayOfModelsFromDictionaries:arry];
                                        handler(models);
                                    }
                                } resError:^(NSString *error) {
                                    NSLog(@"%@",error);
                                    handler(nil);
                                }];
}

-(void)reqStoreLocationHandler:(void (^)(NSArray<StoreLocationModel *> *))handler
{
    NSDictionary * param = [[CommonModel new] toDictionary];
    [self.request startPOSTRequestWithUrl:GetAllLocations
                               parameters:@{@"commonParam":param}
                                resHander:^(NSDictionary *resData) {
                                    BOOL isSuccess = [[resData objectForKey:@"IsSuccess"] boolValue];
                                    NSArray *arry = [resData objectForKey:@"Content"];
                                    if (isSuccess && ![arry isEqual:[NSNull null]]) {
                                        NSArray* models = [StoreLocationModel arrayOfModelsFromDictionaries:arry];
                                        handler(models);
                                    }
                                } resError:^(NSString *error) {
                                    NSLog(@"%@",error);
                                    handler(nil);
                                }];
}
@end
