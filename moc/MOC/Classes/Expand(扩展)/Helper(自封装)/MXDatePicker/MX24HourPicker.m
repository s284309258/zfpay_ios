//
//  MX24HourPicker.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/6/11.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MX24HourPicker.h"
#import "MyCalendarUtil.h"
#import "NSDate+String.h"
#import "DatePickerToolView.h"

const NSInteger component0         = 0;
const NSInteger component1         = 1;
const NSInteger component2         = 2;
const NSInteger component3         = 3;
// 动画时间
const CGFloat   animateDuration    = 0.35f;

@interface MX24HourPicker () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView         *backgroundView;
@property (nonatomic, strong) UIPickerView   *topPickerView;
@property (nonatomic, strong) NSMutableArray *leftHour;
@property (nonatomic, strong) NSMutableArray *leftMin;
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation MX24HourPicker

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initUI];
    }
    return self;
}

- (void)pickerSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([self.topPickerView numberOfComponents] > component &&
        [self.topPickerView numberOfRowsInComponent:component] > row) {
        [self.topPickerView selectRow:row inComponent:component animated:NO];
        _data[component] = @(row);
//        [_data addObject:[@([hourMin[0] integerValue]) stringValue]];
//        [_data addObject:[@([hourMin[1] integerValue]) stringValue]];
//        [_data addObject:[@([hourMin[0] integerValue]) stringValue]];
//        [_data addObject:[@([hourMin[1] integerValue]) stringValue]];
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == component0 || component == component2) {
        return self.leftHour.count;
    }
    
    return self.leftMin.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return SCREEN_WIDTH/4.0 - 5;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == component0 || component == component2) {
        return self.leftHour[row];
    }
    
    return self.leftMin[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _data[component] = [self pickerView:pickerView titleForRow:row forComponent:component];
}

#pragma mark - Public Mothod
- (void)showToView:(UIView*)view
{
    [view addSubview:self];
}

#pragma mark - Event 隐藏View
- (void)dismissView
{
    [UIView animateWithDuration:animateDuration animations:^{
        [self.backgroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - Pravite Mothod

- (void)initData
{
    _leftHour = [[NSMutableArray alloc] initWithCapacity:2];
    _leftMin = [[NSMutableArray alloc] initWithCapacity:2];
    _data = [[NSMutableArray alloc] initWithCapacity:4];
    
    for (NSInteger i = 0; i < 24; i++) {
        NSString *hour = [NSString stringWithFormat:@"%@",@(i)];
        _leftHour[i] = hour;
    }
    
    for (NSInteger i = 0; i < 60; i++) {
        NSString *min = [NSString stringWithFormat:@"%@%@",i<10?@"0":@"",@(i)];
        _leftMin[i] = min;
    }
}

#pragma mark - UI
- (void)initUI
{
    NSString *hm = [NSDate dateHourMin];
    NSArray *hourMin = [hm componentsSeparatedByString:@":"];
    [self.topPickerView selectRow:[hourMin[0] integerValue] inComponent:component0 animated:NO];
    [self.topPickerView selectRow:[hourMin[0] integerValue] inComponent:component2 animated:NO];
    [self.topPickerView selectRow:[hourMin[1] integerValue] inComponent:component1 animated:NO];
    [self.topPickerView selectRow:[hourMin[1] integerValue] inComponent:component3 animated:NO];
    [_data addObject:[@([hourMin[0] integerValue]) stringValue]];
    [_data addObject:[@([hourMin[1] integerValue]) stringValue]];
    [_data addObject:[@([hourMin[0] integerValue]) stringValue]];
    [_data addObject:[@([hourMin[1] integerValue]) stringValue]];
    
    [self addSubview:self.backgroundView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
    [self addGestureRecognizer:tapGesture];
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 250, SCREEN_WIDTH, 250)];
        _backgroundView.backgroundColor=[UIColor whiteColor];
        [_backgroundView addSubview:self.topPickerView];
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(_backgroundView.frame)-30, SCREEN_WIDTH, 30)];
        titleView.backgroundColor=[UIColor whiteColor];
        UILabel *sLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 50, 30)];
        sLbl.text = @"开始";
        [titleView addSubview:sLbl];
        
        UILabel *eLbl = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 0, 50, 30)];
        eLbl.text = @"结束";
        [titleView addSubview:eLbl];
        
        //special by lhy topView 统一由DatePickerToolView管理 2015年11月10日17
        DatePickerToolView *topView = [[DatePickerToolView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(titleView.frame)-40, SCREEN_WIDTH, 44)];
        @weakify(self);
        topView.cancelBlock =^(){
            @strongify(self);
            [self dismissView];
        };
        
        topView.okBlock =^(){
            @strongify(self);
            if (self.selectTime) {
                self.selectTime(self.data);
            }
            [self dismissView];
        };
        [self addSubview:topView];

        
        [self addSubview:titleView];
    }
    
    return _backgroundView;
}

- (UIPickerView *)topPickerView
{
    if (!_topPickerView) {
        CGFloat pickerViewHeight = 216;
        _topPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, pickerViewHeight)];
        _topPickerView.backgroundColor=[UIColor whiteColor];
        [_topPickerView.layer setMasksToBounds:YES];
        _topPickerView.dataSource = self;
        _topPickerView.delegate = self;
    }
    
    return _topPickerView;
}

@end
