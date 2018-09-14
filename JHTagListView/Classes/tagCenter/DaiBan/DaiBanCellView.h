//
//  FilterTableCellView.h
//  JHPatrolSDK
//
//  Created by admin on 2018/5/30.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHTagBanliCell.h"

@class DaiBanCellModel;
@interface DaiBanCellView : JHTagBanliCell
@property (strong, nonatomic) DaiBanCellModel *dbModel;
@end
