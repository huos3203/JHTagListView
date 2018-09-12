//
//  FilterTableCellView.m
//  JHPatrolSDK
//
//  Created by admin on 2018/5/30.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "DaiBanCellView.h"
#import "DaiBanCellModel.h"
//#import "UIColor+HexString.h"
@interface DaiBanCellView()
@property (strong, nonatomic) IBOutlet UILabel *ibTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *ibStatusLabel;
@property (strong, nonatomic) IBOutlet UIButton *ibCheckButton;
@property (strong, nonatomic) IBOutlet UILabel *ibAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *ibTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *PatrolResultLabel;
@property (strong, nonatomic) IBOutlet UILabel *PatrolPeopleLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ibTitleConstraint;

@end

@implementation DaiBanCellView


-(void)setModel:(DaiBanCellModel *)model
{
    _ibTitleLabel.text = model.Name;
    _ibTitleConstraint.constant = [UIScreen mainScreen].bounds.size.width - 90;
    _ibAddressLabel.text = model.Address;
}
@end
