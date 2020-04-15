//
//  MXDoubleDatePickerView.m
//  MoPal_Developer
//
//  Created by aken on 15/3/20.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MXDoubleDatePickerView.h"
#import "MyCalendarUtil.h"
#import "MXSeparatorLine.h"
#import "DatePickerToolView.h"

#define kDatePickerTotalHeight 360
#define kDatePickerHeight 150

#define kDatePickerTopBar 44

#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define ANIMATE_DURATION                        0.35f


@protocol MXDoubleDatePickerViewDelegate;

// 单个日期控制
@interface MXDoubleDatePickerView()

@property (strong, nonatomic) UIView *backgroundView;

@end

@implementation MXDoubleDatePickerView


- (id)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = WINDOW_COLOR;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
        [self addGestureRecognizer:tapGesture];
        
        
        self.backgroundView=[[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.backgroundView.backgroundColor=[UIColor whiteColor];
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishToChooseDate:startDate:endSecs:endDate:)]) {
                [self.delegate didFinishToChooseDate:[self.simpleDatePicker1.date timeIntervalSince1970] startDate:self.simpleDatePicker1.date endSecs:[self.simpleDatePicker2.date timeIntervalSince1970] endDate:self.simpleDatePicker2.date];
            }
            [self dismissView];
        };
        [self.backgroundView addSubview:toolView];
        
        // datepicker1
        self.simpleDatePicker1=[[UIDatePicker alloc] init];
        self.simpleDatePicker1.frame=CGRectMake(0, CGRectGetMaxY(toolView.frame), [UIScreen mainScreen].bounds.size.width, kDatePickerHeight);
        // [ self.simpleDatePicker   setTimeZone:[NSTimeZone defaultTimeZone]];
        self.simpleDatePicker1.datePickerMode=UIDatePickerModeTime;
        [self.backgroundView addSubview:self.simpleDatePicker1];
        
        // label
        UILabel *tipsLabel1=[[UILabel alloc] initWithFrame:CGRectMake(50, kDatePickerHeight/2 - 21/2 + 7, kDatePickerTopBar, 21)];
        tipsLabel1.backgroundColor=[UIColor clearColor];
        tipsLabel1.text=@"开始";
        tipsLabel1.font=[UIFont font17];
        [self.simpleDatePicker1 addSubview:tipsLabel1];
        
        // 分割线
        MXSeparatorLine*upLine=[MXSeparatorLine initHorizontalLineWidth:[UIScreen mainScreen].bounds.size.width orginX:0 orginY:CGRectGetMaxY(self.simpleDatePicker1.frame)];
        [self.backgroundView addSubview:upLine];
        
        // datepicker2
        self.simpleDatePicker2=[[UIDatePicker alloc] init];
        self.simpleDatePicker2.frame=CGRectMake(0, CGRectGetMaxY(self.simpleDatePicker1.frame), [UIScreen mainScreen].bounds.size.width,kDatePickerHeight);
        self.simpleDatePicker2.datePickerMode=UIDatePickerModeTime;
        [self.backgroundView addSubview:self.simpleDatePicker2];
        
        // label
        UILabel *tipsLabel2=[[UILabel alloc] initWithFrame:CGRectMake(50, kDatePickerHeight/2 - 21/2 + 7, kDatePickerTopBar, 21)];
        tipsLabel2.backgroundColor=[UIColor clearColor];
        tipsLabel2.text=@"结束";
        tipsLabel2.font=[UIFont font17];
        [self.simpleDatePicker2 addSubview:tipsLabel2];
        
        
        NSLocale * locale=nil;
        
        NSInteger lanCode= 0;
        if (lanCode==0) { // 中文
            locale=[[NSLocale alloc] initWithLocaleIdentifier:@"Chinese"];
            self.simpleDatePicker1.locale=locale;
            self.simpleDatePicker2.locale=locale;
        } else { // 马文、英文
            locale=[[NSLocale alloc] initWithLocaleIdentifier:@"US"];
            self.simpleDatePicker1.locale=locale;
            self.simpleDatePicker2.locale=locale;
        }
        
        // 设置可见高度
        [UIView animateWithDuration:ANIMATE_DURATION animations:^{
            [self.backgroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-kDatePickerTotalHeight, [UIScreen mainScreen].bounds.size.width, kDatePickerTotalHeight)];
        } completion:nil]; 
    }
    
    return self;
}
#pragma  mark -
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
