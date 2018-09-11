//
//  FilterTableCellView.h
//  JHPatrolSDK
//
//  Created by admin on 2018/5/30.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RestStoreListModel;
@interface FilterStoreCellView : UITableViewCell
@property (strong, nonatomic) RestStoreListModel *storeModel;
@end
