//
//  YiBanCellView.h
//  JHTagListView_Example
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import "JHTagBanliCell.h"

@interface YiBanCellView : JHTagBanliCell
@property (strong, nonatomic) IBOutlet UILabel *ibZhifaResultLabel;
@property (strong, nonatomic) IBOutlet UILabel *ibZhifaPeopleLabel;
@property (strong, nonatomic) JHTagBanliModel *ybModel;
@end
