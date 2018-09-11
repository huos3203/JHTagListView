//
//  PatrolSearchBar.m
//  YGPatrol(github地址)
//
//  Created by admin on 2018/5/11.
//Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "PatrolSearchBar.h"

@implementation PatrolSearchBar

#pragma mark - def

//MARK: override
-(void)prepareForInterfaceBuilder
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 1) {
            if ( [[view.subviews objectAtIndex:1] isKindOfClass:[UITextField class]]) {
                UITextField *searchBarTextField = (UITextField *)[view.subviews objectAtIndex:1];
                [searchBarTextField setBackgroundColor:[UIColor clearColor]];
                [searchBarTextField.layer setMasksToBounds:YES];
                [searchBarTextField.layer setCornerRadius:15.0];
                [searchBarTextField setBackgroundColor:[UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f]];
            }
            break;
        }
    }
    
    [[[[self.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
}
-(void)awakeFromNib
{
    [super awakeFromNib];
//    UIColor * grayColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f];
//    [self.layer setBorderWidth:1];
//    [self.layer setBorderColor:grayColor.CGColor];
//    [self.layer setMasksToBounds:YES];
//    [self.layer setCornerRadius:15.0];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 1) {
            if ( [[view.subviews objectAtIndex:1] isKindOfClass:[UITextField class]]) {
                UITextField *searchBarTextField = (UITextField *)[view.subviews objectAtIndex:1];
                [searchBarTextField setBackgroundColor:[UIColor clearColor]];
                [searchBarTextField.layer setMasksToBounds:YES];
                [searchBarTextField.layer setCornerRadius:15.0];
                [searchBarTextField setBackgroundColor:[UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f]];
            }
            break;
        }
    }
    
    [[[[self.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
}

//-(void)setBorderWidth:(CGFloat)borderWidth
//{
//
//    for (UIView *view in self.subviews) {
//        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 1) {
//            if ( [[view.subviews objectAtIndex:1] isKindOfClass:[UITextField class]]) {
//                UITextField *searchBarTextField = (UITextField *)[view.subviews objectAtIndex:1];
//                [searchBarTextField setBackgroundColor:[UIColor clearColor]];
//                [searchBarTextField.layer setMasksToBounds:YES];
//                [searchBarTextField.layer setCornerRadius:15.0];
//                [searchBarTextField setBackgroundColor:[UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f]];
//            }
//            break;
//        }
//    }
//
//    [[[[self.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
//}

//TODO: - 将要实现

//FIXME: - 待修复

// !!!: it is empty at all here

// ???: why pm 2.5 is so high

#warning >>>>>>>>>>>>>>

//#error <<<<<<<<<<<<<<

#pragma mark - override


#pragma mark - api


#pragma mark - model event


#pragma mark - view event



#pragma mark - private



#pragma mark - getter / setter

@end

