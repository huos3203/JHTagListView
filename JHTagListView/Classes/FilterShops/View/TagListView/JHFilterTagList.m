//
//  JHFilterTagList.m
//  JHTagListView_Example
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import "JHFilterTagList.h"
#import "JHTagModel.h"
#import "UIColor+HexString.h"


@implementation JHFilterTagList
{
    NSMutableArray *_tagArr;
}
-(instancetype)init
{
    if (self = [super init]) {
        // 高度可以设置为0，会自动跟随标题计算
        self.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 0);
        self.tagBackgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        self.tagFont = [UIFont systemFontOfSize:15];
        self.tagButtonMargin = 10;
        self.tagCornerRadius = 8;
        self.tagMargin = 20;
        self.tagColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
    }
    return self;
}

-(void)addTags:(NSArray<JHTagModel *> *)tagModels
{
    if (self.frame.size.width == 0) {
        @throw [NSException exceptionWithName:@"YZError" reason:@"先设置标签列表的frame" userInfo:nil];
    }
    if (!_tagArr) {
        _tagArr = [NSMutableArray new];
    }
    [_tagArr addObjectsFromArray:tagModels];
    for (JHTagModel *model in tagModels) {
        [self addTag:model.title];
    }
}

///重写点击方法
- (void)clickTag:(UIButton *)button
{
    JHTagModel *model = _tagArr[button.tag];
    if (button.tag == 0) {
        model.isSelected = YES;
        for (int i = 1; i < _tagArr.count; i++) {
            [self resetTagStatus:i];
        }
    }else{
        [self resetTagStatus:0];
       model.isSelected = model.isSelected?NO:YES;
    }
    
    if (model.isSelected) {
        [button setBackgroundColor:[UIColor colorWithHexString:@"4287ff"]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [button setTitleColor:self.tagColor forState:UIControlStateNormal];
        [button setBackgroundColor:self.tagBackgroundColor];
    }
}

//重置指定的索引的状态
-(void)resetTagStatus:(NSInteger)index
{
    JHTagModel *model2 = _tagArr[index];
    model2.isSelected = NO;
    UIButton *tagBtn = self.tagButtons[index];
    [tagBtn setTitleColor:self.tagColor forState:UIControlStateNormal];
    [tagBtn setBackgroundColor:self.tagBackgroundColor];
}
@end
