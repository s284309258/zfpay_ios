//
//  MXSimpleDatePickerView.h
//  MoPal_Developer
//
// 标准的单个日期控件
//  Created by aken on 15/3/20.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MXSimpleDatePickerViewDelegate;

@interface MXSimpleDatePickerView : UIView


@property (strong, nonatomic) UIDatePicker *simpleDatePicker;

@property (weak, nonatomic) id<MXSimpleDatePickerViewDelegate>delegate;

// 显示
- (void)showToView:(UIView*)view;

@end

@protocol MXSimpleDatePickerViewDelegate <NSObject>

- (void)didFinishToChooseDate:(NSInteger)timeInterval date:(NSDate*)date;

@end
