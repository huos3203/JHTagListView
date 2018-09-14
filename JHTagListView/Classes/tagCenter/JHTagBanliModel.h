//
//  JHTagCellModel.h
//  JHTagListView_Example
//
//  Created by admin on 2018/9/12.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, TagListType) {
    DaiBanType = 1 << 0,
    YiBanType = 1 << 1,
    GuanliType = 1 << 2,
    WeiZchaType = 1 << 2,
    YiZchaType = 1 << 2,
};

@interface JHTagBanliModel : NSObject
@property (assign, nonatomic) TagListType tagType;
/// id
@property (strong, nonatomic) NSString *Id;
/// 名称
@property (strong, nonatomic) NSString *Name;
//
@property (strong, nonatomic) NSString *statusColor;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *xchaPeople;
@property (strong, nonatomic) NSString *zhfPeople;
@property (strong, nonatomic) NSString *zhfResult;
@end
