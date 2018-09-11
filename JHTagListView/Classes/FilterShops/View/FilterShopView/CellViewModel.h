//
//  CellViewModel.h
//  YGPatrol
//
//  Created by admin on 2018/5/18.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellViewModel : NSObject
@property (nonatomic, strong) NSArray *tagGroup;
@property (nonatomic, assign) BOOL singleSection; //一个单元，隐藏头部
@property (assign, nonatomic) float tableViewH;
@end
