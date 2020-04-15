//
//  MXSimpleDateAndTimePickerView.h
//  MoPal_Developer
//
//  Created by lhy on 15/8/10.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//  时间控件  带年月日，小时，分钟 UIDatePickerModeDateAndTime

#import <UIKit/UIKit.h>

@protocol MXSimpleDateAndTimePickerViewDelegate;
@interface MXSimpleDateAndTimePickerView : UIView
@property (strong, nonatomic) UIDatePicker *simpleDatePicker;
@property (nonatomic,weak) id<MXSimpleDateAndTimePickerViewDelegate>delegate;
//日期控件的当前日期
@property (nonatomic)NSDate *currentDate;
//日期控件的最大日期
@property (nonatomic)NSDate *maximumDate;
@property (nonatomic)NSDate *minimumDate;
- (id)initWithFrame:(CGRect)frame withCurrentDate:(NSDate *)aCurrentDate withMaxDate:(NSDate *)aMaximumDate withMinDate:(NSDate *)aMinimumDate;
// 显示
- (void)showToView:(UIView*)view;
@end

@protocol MXSimpleDateAndTimePickerViewDelegate <NSObject>
- (void)didFinishToChooseDate:(NSInteger)timeInterval date:(NSDate*)date;
@end
