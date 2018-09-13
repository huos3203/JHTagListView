//
//  DateAlertController.h
//  datePicker
//
//  Created by VH on 2017/11/21.
//  Copyright © 2017年 Jinhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DateAlertPickerDelegate <NSObject>
- (void)dateAlertControllerChoosedDate:(NSDate *)date;
- (void)dateAlertControllerCancelChoosedDate;
@end

@interface DateAlertPickerController : UIAlertController

@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, assign) id<DateAlertPickerDelegate> delegate;

- (void)insertDatePicker:(UIDatePicker *)picker;

@end
