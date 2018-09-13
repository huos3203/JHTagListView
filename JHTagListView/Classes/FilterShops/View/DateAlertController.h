//
//  DateAlertController.h
//  datePicker
//
//  Created by VH on 2017/11/21.
//  Copyright © 2017年 Jinhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DateAlertDelegate <NSObject>
- (void)dateAlertControllerChoosedDate:(NSDate *)date;
- (void)dateAlertControllerCancelChoosedDate;
@end

@interface DateAlertController : UIAlertController

@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, assign) id<DateAlertDelegate> delegate;

- (void)insertDatePicker:(UIDatePicker *)picker;

@end
