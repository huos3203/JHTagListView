//
//  YiBanCellView.m
//  JHTagListView_Example
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import "YiBanCellView.h"
#import "JHTagBanliModel.h"
@implementation YiBanCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setYbModel:(JHTagBanliModel *)ybModel
{
    self.model = ybModel;
    _ibZhifaResultLabel.text = ybModel.zhfResult;
    _ibZhifaPeopleLabel.text = ybModel.zhfPeople;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
