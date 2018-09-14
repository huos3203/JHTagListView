//
//  JHTagCollCell.m
//  JHTagListView_Example
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import "JHTagCollCell.h"
#import "JHTagItem.h"
#import "UIColor+HexString.h"

@implementation JHTagCollCell
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.layer.borderWidth = .5;
    [self.layer setCornerRadius:8.0];
}

- (void)setItem:(JHTagItem *)item
{
    _item = item;
    self.tagLabel.text = item.name;
    self.layer.borderColor = item.isSelected?[UIColor colorWithHexString:@"8ABB4F"].CGColor:[UIColor colorWithHexString:@"BDBDBD"].CGColor;
}
@end
