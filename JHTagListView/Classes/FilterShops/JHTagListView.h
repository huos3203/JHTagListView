//
//  JHTagListView.h
//  JHTagListView_Example
//
//  Created by admin on 2018/9/11.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHTagListView : UIView
-(void)setupFilterView:(NSArray *)dataArray;
-(void)loadDataList:(dispatch_group_t)group;
-(void)showListView;
@end
