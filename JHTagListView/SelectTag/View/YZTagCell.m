//
//  YZTagCell.m
//  YZTagListDemo
//
//  Created by yz on 16/8/16.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "YZTagCell.h"
#import "JHTagItem.h"

@interface YZTagCell ()

@end

@implementation YZTagCell

- (void)awakeFromNib {
    // Initialization code
    [self.layer setCornerRadius:8.0];
}

- (void)setItem:(JHTagItem *)item
{
    _item = item;
    
    self.tagLabel.text = item.name;
    
//    _tagLabel.textColor = item.isSelected?[UIColor colorWithRed:39 / 255.0 green:132 / 255.0 blue:235 / 255.0 alpha:1] : [UIColor colorWithRed:136 / 255.0 green:136 / 255.0 blue:136 / 255.0 alpha:1];
}


@end
