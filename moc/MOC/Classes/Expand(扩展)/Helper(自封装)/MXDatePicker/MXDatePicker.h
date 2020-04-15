//
//  MXDatePicker.h
//  MoPal_Developer
//
//  日期选择控件
//  Created by aken on 15/2/3.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

// 单个日期的回调
typedef void(^SimpleDatePickerBlock)(long long timeInterval,NSDate *date);

// 两个日期的回调
typedef void(^DoubleDatePickerBlock)(NSInteger startSecs,NSDate *startDate,NSInteger endSecs,NSDate *endDate);

// 24小时
typedef void(^HourMinPickerBlock)(NSArray *hourMin);

@interface MXDatePicker : NSObject


// 显示简单的日期控件
+(void)showDatePickerInView:(UIView*)showView completion:(SimpleDatePickerBlock)completion;
+(void)showDatePickerInView:(UIView *)showView date:(NSDate*)date completion:(SimpleDatePickerBlock)completion;

// 显示双个日期控件
+(void)showDoubleDatePickerInView:(UIView*)showView completion:(DoubleDatePickerBlock)completion;

// 24 小时选择
+ (void)show24HourMinPickerInView:(UIView*)showView selectedHourMinList:(NSArray*)selectedList completion:(HourMinPickerBlock)completion;
//special by lhy
+(void)showDateAndTimePickerInView:(UIView *)showView currentDate:(NSDate*)aCurrentDate maxDate:(NSDate *)aMaxDate minDate:(NSDate *)aMinDate completion:(SimpleDatePickerBlock)completion;
//end
@end
