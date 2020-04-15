//
//  MXDatePicker.m
//  MoPal_Developer
//
//  Created by aken on 15/2/3.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MXDatePicker.h"
#import "MXSimpleDatePickerView.h"
#import "MXDoubleDatePickerView.h"
#import "MX24HourPicker.h"
//sepcial by lhy
#import "MXSimpleDateAndTimePickerView.h"
//end

@interface MXDatePicker()<MXSimpleDatePickerViewDelegate,MXDoubleDatePickerViewDelegate,MXSimpleDateAndTimePickerViewDelegate>

+ (MXDatePicker*)sharedInstance;

@property (nonatomic, strong) SimpleDatePickerBlock myBlock;
@property (nonatomic, strong) DoubleDatePickerBlock myDoubleBlock;

@end

@implementation MXDatePicker

+ (MXDatePicker*)sharedInstance {
    
    static id sharedInstanceNH;
    static dispatch_once_t onceNH;
    dispatch_once(&onceNH, ^{
        sharedInstanceNH = [[[self class] alloc] init];
    });
    return sharedInstanceNH;
}

#pragma mark - 示简单的日期控件
- (void)showDatePickerInView:(UIView*)showView completion:(SimpleDatePickerBlock)completion {
    
    MXSimpleDatePickerView *datePickerView=[[MXSimpleDatePickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    datePickerView.delegate=self;
    [datePickerView showToView:showView];
    
    self.myBlock=completion;
}
- (void)showDatePickerInView:(UIView*)showView date:(NSDate*)date completion:(SimpleDatePickerBlock)completion {
    
    MXSimpleDatePickerView *datePickerView=[[MXSimpleDatePickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (date != nil) {
        
        datePickerView.simpleDatePicker.date = date;
    }
    datePickerView.delegate=self;
    [datePickerView showToView:showView];
    
    self.myBlock=completion;
}

//special by lhy
- (void)showDateAndTimePickerInView:(UIView*)showView currentDate:(NSDate*)aCurrentDate maxDate:(NSDate *)aMaxDate minDate:(NSDate *)aMinDate completion:(SimpleDatePickerBlock)completion {
    
    MXSimpleDateAndTimePickerView *datePickerView=[[MXSimpleDateAndTimePickerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) withCurrentDate:aCurrentDate withMaxDate:aMaxDate withMinDate:aMinDate];
    datePickerView.delegate=self;
    [datePickerView showToView:showView];
    
    self.myBlock=completion;
}
//end

#pragma mark - 显示双个日期控件
- (void)showDoubleDatePickerInView:(UIView*)showView completion:(DoubleDatePickerBlock)completion {
    
    MXDoubleDatePickerView *datePickerView=[[MXDoubleDatePickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    datePickerView.delegate=self;
    [datePickerView showToView:showView];
    
    self.myDoubleBlock=completion;
}

#pragma mark - 24小时时间选择
- (void)show24HourMinPickerInView:(UIView*)showView selectedHourMinList:(NSArray*)selectedList  completion:(HourMinPickerBlock)completion
{
    MX24HourPicker *hourPicker = [[MX24HourPicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    hourPicker.selectTime = ^(NSArray *hourMin) {
        completion(hourMin);
    };
    for (int i = 0 ; i < [selectedList count]; i++) {
        [hourPicker pickerSelectRow:[selectedList[i] integerValue] inComponent:i];
    }
    [hourPicker showToView:showView];
}

#pragma mark - MXSimpleDatePickerView delegate
- (void)didFinishToChooseDate:(NSInteger)timeInterval date:(NSDate *)date {
    
    if (self.myBlock) {
        self.myBlock(timeInterval,date);
    }
}

#pragma mark - MXDoubleDatePickerView delegate
- (void)didFinishToChooseDate:(NSInteger)startSecs startDate:(NSDate *)starDate endSecs:(NSInteger)endSecs endDate:(NSDate *)endDate {
    if (self.myDoubleBlock) {
        self.myDoubleBlock(startSecs,starDate,endSecs,endDate);
    }
}

/*****************************************显示简单的日期控件*********************************************/
+ (void)showDatePickerInView:(UIView*)showView completion:(SimpleDatePickerBlock)completion {
    
    [[self sharedInstance] showDatePickerInView:showView completion:completion];
}

+ (void)showDatePickerInView:(UIView *)showView date:(NSDate*)date completion:(SimpleDatePickerBlock)completion
{
    [[self sharedInstance] showDatePickerInView:showView date:date completion:completion];
}

/*****************************************显示双个日期控件*********************************************/
+(void)showDoubleDatePickerInView:(UIView*)showView completion:(DoubleDatePickerBlock)completion {
    [[self sharedInstance] showDoubleDatePickerInView:showView completion:completion];
}

/*****************************************24小时时间选择*********************************************/
+ (void)show24HourMinPickerInView:(UIView*)showView selectedHourMinList:(NSArray*)selectedList completion:(HourMinPickerBlock)completion {
    [[self sharedInstance] show24HourMinPickerInView:showView selectedHourMinList:selectedList completion:completion];
}

//special by lhy
/*****************************************日期+时间*********************************************/
+(void)showDateAndTimePickerInView:(UIView *)showView currentDate:(NSDate*)aCurrentDate maxDate:(NSDate *)aMaxDate minDate:(NSDate *)aMinDate completion:(SimpleDatePickerBlock)completion{
    [[self sharedInstance] showDateAndTimePickerInView:showView currentDate:(NSDate*)aCurrentDate maxDate:(NSDate *)aMaxDate minDate:aMinDate completion:completion];
}
//end
@end
