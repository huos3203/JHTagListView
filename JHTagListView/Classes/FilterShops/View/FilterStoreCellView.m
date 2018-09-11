//
//  FilterTableCellView.m
//  JHPatrolSDK
//
//  Created by admin on 2018/5/30.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "FilterStoreCellView.h"
#import "RestStoreListModel.h"
#import "SearchShopsViewController.h"
#import "UIColor+HexString.h"
@interface FilterStoreCellView()
@property (strong, nonatomic) IBOutlet UILabel *ibTitleLabel;
@property (strong, nonatomic) IBOutlet RoundLabel *ibStatusLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ibStatusImgView;
@property (strong, nonatomic) IBOutlet UILabel *ibAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *ibZhengLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ibTitleConstraint;


@end

@implementation FilterStoreCellView


-(void)setStoreModel:(RestStoreListModel *)storeModel
{
    _ibTitleLabel.text = storeModel.Name;
    _ibTitleConstraint.constant = [UIScreen mainScreen].bounds.size.width - 120;
    [self statusLabelView:storeModel.StoreStatus];
    NSString *imgName = @"";
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"JHPatrolResources" withExtension:@"bundle"]];

    if (storeModel.InspectStatus == 1) {
        imgName = @"dpweijiancha";
    }else{
        imgName = @"dpyijiancha";
    }
    UIImage *img = [UIImage imageNamed:imgName inBundle:bundle compatibleWithTraitCollection:nil];
    [_ibStatusImgView setImage:img];
    _ibAddressLabel.text = storeModel.Address;
    NSString *year = @"";
    if (storeModel.LicenseExpire.length > 0) {
        year = [storeModel.LicenseExpire substringToIndex:4];
    }
    NSString *zheng = @"";
    if (storeModel.LicenceCode.length > 0) {
        zheng = storeModel.LicenceCode;
    }
    _ibZhengLabel.text = [NSString stringWithFormat:@"%@(至%@年有效)",zheng,year];
}
-(void)statusLabelView:(NSInteger)status
{
    NSString *title;
    NSString *color;
    switch (status) {
        case 0:
            title = @"正常";
            color = @"76BD3D";
            break;
        case 1:
            title = @"异常";
            color = @"F26363";
            break;
        case 2:
            title = @"关闭";
            color = @"999999";
            break;
        default:
            break;
    }
    _ibStatusLabel.text = title;
    _ibStatusLabel.textColor = [UIColor colorWithHexString:color];
    _ibStatusLabel.borderColor = [UIColor colorWithHexString:color];
}
@end
