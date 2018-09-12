//
//  FilterTableCellView.m
//  JHPatrolSDK
//
//  Created by admin on 2018/5/30.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "FilterPatrolStoreCellView.h"
#import "RestStoreListModel.h"
#import "SearchShopsViewController.h"
//#import "UIColor+HexString.h"
@interface FilterPatrolStoreCellView()
@property (strong, nonatomic) IBOutlet UILabel *ibTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *ibStatusLabel;
@property (strong, nonatomic) IBOutlet UIButton *ibCheckButton;
@property (strong, nonatomic) IBOutlet UILabel *ibAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *ibTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *PatrolResultLabel;
@property (strong, nonatomic) IBOutlet UILabel *PatrolPeopleLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ibTitleConstraint;

@end

@implementation FilterPatrolStoreCellView


-(void)setStoreModel:(RestStoreListModel *)storeModel
{
    _ibTitleLabel.text = storeModel.Name;
    _ibTitleConstraint.constant = [UIScreen mainScreen].bounds.size.width - 90;
    _ibAddressLabel.text = storeModel.Address;
}
@end
