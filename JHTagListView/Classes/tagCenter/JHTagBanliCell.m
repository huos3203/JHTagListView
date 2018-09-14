//
//  JHTagBanliCell.m
//  JHTagListView_Example
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import "JHTagBanliCell.h"
#import "JHTagBanliModel.h"
#import "UIColor+HexString.h"

@implementation JHTagBanliCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JHTagBanliModel *)model
{
    _model = model;
    _ibTitleLabel.text = model.Name;
    _ibStatusLabel.backgroundColor = [UIColor colorWithHexString:model.statusColor];
    _ibAddressLabel.text = model.address;
    _ibTimeLabel.text = model.time;
    _PatrolPeopleLabel.text = model.xchaPeople;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
