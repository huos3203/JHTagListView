//
//  HistoryRecordViewController.h
//  YGPatrol
//
//  Created by admin on 2018/5/23.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SearchText)(NSString *);
@interface HistoryRecordViewController : UIViewController
@property (strong, nonatomic) NSString *fromVCName;
@property (strong, nonatomic)SearchText searchText;
@end
