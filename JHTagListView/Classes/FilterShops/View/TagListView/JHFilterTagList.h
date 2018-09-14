//
//  JHFilterTagList.h
//  JHTagListView_Example
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import "YZTagList.h"
@class JHTagModel;
@interface JHFilterTagList : YZTagList
/**
 *  添加多个标签
 *
 *  @param tagModel 标签数组，数组存放（JHTagModel *）
 */
-(void)addTags:(NSArray<JHTagModel *> *)tagModels;
@end
