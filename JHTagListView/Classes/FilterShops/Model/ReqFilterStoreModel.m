//
//  FilterStoreModel.m
//  YGPatrol
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "ReqFilterStoreModel.h"

@implementation ReqFilterStoreModel

-(NSString *)keywords
{
    if (!_keywords) {
        return @"";
    }
    return _keywords;
}
-(NSString *)locationId
{
    if (!_locationId) {
        return @"";
    }
    return _locationId;
}

-(NSString *)storeTypeId
{
    if (!_storeTypeId) {
        return @"";
    }
    return _storeTypeId;
}


@end
