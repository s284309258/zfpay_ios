//
//  MXDoubleDatePickerView.h
//  MoPal_Developer
//
//  双个日期控件
//  Created by aken on 15/3/20.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MXDoubleDatePickerViewDelegate;

@interface MXDoubleDatePickerView : UIView


@property (strong, nonatomic) UIDatePicker *simpleDatePicker1;

@property (strong, nonatomic) UIDatePicker *simpleDatePicker2;

@property (weak, nonatomic) id<MXDoubleDatePickerViewDelegate>delegate;

// 显示
- (void)showToView:(UIView*)view;

@end

@protocol MXDoubleDatePickerViewDelegate <NSObject>

- (void)didFinishToChooseDate:(NSInteger)startSecs startDate:(NSDate*)starDate endSecs:(NSInteger)endSecs endDate:(NSDate*)endDate;

@end
