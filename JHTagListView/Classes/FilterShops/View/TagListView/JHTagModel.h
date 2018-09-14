//
//  JHFilterTagModel.h
//  JHTagListView_Example
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHTagModel : NSObject
@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL isSelected;
@end
