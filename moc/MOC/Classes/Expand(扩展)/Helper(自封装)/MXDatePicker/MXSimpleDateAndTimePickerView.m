//
//  MXSimpleDateAndTimePickerView.m
//  MoPal_Developer
//
//  Created by lhy on 15/8/10.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MXSimpleDateAndTimePickerView.h"
#import "MyCalendarUtil.h"
#import "AmplifyRespondButton.h"
#import "DatePickerToolView.h"

#define kDatePickerHeight 287
#define kDatePickerTopBar 44

#define WINDOW_COLOR       [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define ANIMATE_DURATION   0.35f

@interface MXSimpleDateAndTimePickerView()
@property (strong, nonatomic) UIView *backgroundView;
@end

@implementation MXSimpleDateAndTimePickerView
- (id)initWithFrame:(CGRect)frame withCurrentDate:(NSDate *)aCurrentDate withMaxDate:(NSDate *)aMaximumDate withMinDate:(NSDate *)aMinimumDate{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = WINDOW_COLOR;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
        [self addGestureRecognizer:tapGesture];
        
        self.backgroundView=[[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.backgroundView.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.backgroundView];
        if (aMinimumDate) {
            _minimumDate = aMinimumDate;
        }
        if (aCurrentDate) {
            _currentDate = aCurrentDate;
        }
        if (aMaximumDate) {
            _maximumDate = aMaximumDate;
        }
        //special by lhy toolView 统一由DatePickerToolView管理 方便管理  2015年11月10日17
        DatePickerToolView *toolView = [[DatePickerToolView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kDatePickerTopBar)];
        @weakify(self);
        toolView.cancelBlock =^(){
            @strongify(self);
            [self dismissView];
        };
        
        toolView.okBlock =^(){
            @strongify(self);
            if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishToChooseDate:date:)]) {
                [self.delegate didFinishToChooseDate:[self.simpleDatePicker.date timeIntervalSince1970] date:self.simpleDatePicker.date];
            }
            [self dismissView];
        };
        
        [self.backgroundView addSubview:toolView];
        
        // datepicker
        self.simpleDatePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(toolView.frame), [UIScreen mainScreen].bounds.size.width, kDatePickerHeight - kDatePickerTopBar)];
        self.simpleDatePicker.datePickerMode=UIDatePickerModeDateAndTime;
        //设置最小日期
        if (_minimumDate) {
            _simpleDatePicker.minimumDate = _minimumDate;
        }else{
            _simpleDatePicker.minimumDate = [NSDate date];
        }
        if (_currentDate) {
            _simpleDatePicker.date = _currentDate;
        }
        if (_maximumDate) {
            _simpleDatePicker.maximumDate = _maximumDate;
        }
        [self.backgroundView addSubview:self.simpleDatePicker];
        NSLocale * locale=nil;
        
        locale=[[NSLocale alloc] initWithLocaleIdentifier:@"Chinese"];
        self.simpleDatePicker.locale=locale;
        
        // 设置可见高度
        [UIView animateWithDuration:ANIMATE_DURATION animations:^{
            [self.backgroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-kDatePickerHeight, [UIScreen mainScreen].bounds.size.width, kDatePickerHeight+kDatePickerTopBar)];
        } completion:^(BOOL finished) {
        }];
    }
    return self;
}
#pragma  mark - 显示
- (void)showToView:(UIView*)view {
    [view addSubview:self];
}

#pragma mark - 隐藏View
- (void)dismissView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}
@end
