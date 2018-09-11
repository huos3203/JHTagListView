//
//  YZGroupHeaderView.m
//  YZTagListDemo
//
//  Created by yz on 16/8/16.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "YZGroupHeaderView.h"
#import "JHGroupItem.h"
#import "JHTagGroupItem.h"

@interface YZGroupHeaderView ()

@end

@implementation YZGroupHeaderView
{
    BOOL _canFold;/**< 是否可展开 */
}

+ (instancetype)groupHeaderView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [_ibFoldButton.layer setCornerRadius:8.0];
}
- (void)setGroupItem:(JHGroupItem *)groupItem
{
    _groupItem = groupItem;
    _groupLabel.text = groupItem.name;
}

-(void)setTagGroupItem:(JHTagGroupItem *)tagGroupItem
{
    _tagGroupItem = tagGroupItem;
    _groupLabel.text = tagGroupItem.name;
}


//重写fold的set方法， 根据fold的状态， 改变图片形状
- (void)setFold:(BOOL)fold {
    _fold = fold;
    if (fold) {
        [_ibFoldButton setImage:[UIImage imageNamed:@"dpshangla"] forState:UIControlStateNormal];
    } else {
        [_ibFoldButton setImage:[UIImage imageNamed:@"dpxiala1"] forState:UIControlStateNormal];
    }
}

//按钮的点击响应方法，将代理传出
- (IBAction)ibFoldAction:(id)sender{
    if ([self.delegate respondsToSelector:@selector(foldHeaderInSection:)]) {
        [self.delegate foldHeaderInSection:_section];
    }
}
- (IBAction)ibaCellRowAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(foldCellCurrentRow:)]) {
        [self.delegate foldCellCurrentRow:_rowIndexPath];
    }
}

@end
