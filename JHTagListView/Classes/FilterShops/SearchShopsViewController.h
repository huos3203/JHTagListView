//
//  SearchShopsViewController.h
//  YGPatrol(github地址)
//
//  Created by admin on 2018/5/14.
//Copyright © 2018年 huoshuguang. All rights reserved.
//
#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface RoundLabel:UILabel
@property (nonatomic) IBInspectable UIColor* borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@end

@interface SearchShopsViewController : UIViewController<UIGestureRecognizerDelegate>


@end
