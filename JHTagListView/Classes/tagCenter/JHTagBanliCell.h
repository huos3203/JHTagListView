//
//  JHTagBanliCell.h
//  JHTagListView_Example
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHTagBanliModel;
@interface JHTagBanliCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *ibTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *ibStatusLabel;
@property (strong, nonatomic) IBOutlet UILabel *ibAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *ibTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *PatrolPeopleLabel;
@property (strong, nonatomic) JHTagBanliModel *model;
@end
