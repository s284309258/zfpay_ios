//
//  MXSimpleDatePickerView.m
//  MoPal_Developer
//
//  Created by aken on 15/3/20.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MXSimpleDatePickerView.h"
#import "MyCalendarUtil.h"
#import "DatePickerToolView.h"

#define kDatePickerHeight 287
#define kDatePickerTopBar 44

#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define ANIMATE_DURATION                        0.35f


// 单个日期控制
@interface MXSimpleDatePickerView ()

@property (strong, nonatomic) UIView *backgroundView;


@end

@implementation MXSimpleDatePickerView


- (id)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = WINDOW_COLOR;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
        [self addGestureRecognizer:tapGesture];
        
        
        self.backgroundView=[[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.backgroundView.backgroundColor=[UIColor moBackground];
        [self addSubview:self.backgroundView];
                                
        //special by lhy topView 统一由DatePickerToolView管理 2015年11月10日17
        DatePickerToolView *toolView=[[DatePickerToolView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kDatePickerTopBar)];
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
        
        
        // datepicker
        self.simpleDatePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(toolView.frame) - 20, [UIScreen mainScreen].bounds.size.width, kDatePickerHeight - kDatePickerTopBar)];
        // [ self.simpleDatePicker   setTimeZone:[NSTimeZone defaultTimeZone]];
        self.simpleDatePicker.datePickerMode=UIDatePickerModeDate;
        NSDate* tmpDate = [MyCalendarUtil addNSDate:[NSDate date] type:MyCalendarUtilDateTypeYear number:-18];
        self.simpleDatePicker.date = tmpDate;
        tmpDate = [MyCalendarUtil addNSDate:[NSDate date] type:MyCalendarUtilDateTypeYear number:-100];
        self.simpleDatePicker.minimumDate =  tmpDate;
        self.simpleDatePicker.maximumDate = [NSDate date];
        [self.backgroundView addSubview:self.simpleDatePicker];
        [self.backgroundView addSubview:toolView];
        
        NSLocale * locale=nil;
        
        locale=[[NSLocale alloc] initWithLocaleIdentifier:@"Chinese"];
        self.simpleDatePicker.locale=locale;

        // 设置可见高度
        [UIView animateWithDuration:ANIMATE_DURATION animations:^{
            
            [self.backgroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-kDatePickerHeight, [UIScreen mainScreen].bounds.size.width, kDatePickerHeight)];
            
            
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
