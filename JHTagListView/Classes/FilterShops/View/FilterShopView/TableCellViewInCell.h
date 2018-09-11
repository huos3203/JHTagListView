//
//  TableCellViewInCell.h
//  YGPatrol
//
//  Created by admin on 2018/5/17.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHTagGroupItem;
@class JHGroupItem;
@interface TableCellViewInCell : UITableViewCell

@property (nonatomic, strong) JHGroupItem *tagGroup;
@property (nonatomic, assign) BOOL singleSection; //一个单元，隐藏头部
@property (strong, nonatomic) IBOutlet UITableView *ibTableView;
@property (strong, nonatomic) void(^RefreshTableViewBlock)(void);

@end
