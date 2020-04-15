//
//  NSDate+String.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/4/27.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "NSDate+String.h"
#import "NSDate+Category.h"

@implementation NSDate (String)

+ (NSString*)dateString:(NSDate*)date format:(NSString* )format
{
    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSString *time = [formatter stringFromDate:date];
    return time;
}

+ (NSString*)dateString:(NSDate*)date
{
    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *time = [formatter stringFromDate:date];
    return time;
}

+ (NSString *)dateHourMin
{
    NSDate *date = [NSDate date];
    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSString *time = [formatter stringFromDate:date];
    return time;
}

+ (NSDate *)dateWithString:(NSString*)string
            withDateFormat:(NSString*)dateFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    NSDate *time = [formatter dateFromString:string];
    return time;
}

+ (NSString *)endTimeIntervalDesc:(NSDate *)endTime{
    
    NSTimeInterval ti = [endTime timeIntervalSinceDate:[NSDate date]];
    if (ti <= 0) {
        return @"";
    }
    NSMutableString *resultString = [NSMutableString string];
    NSInteger day = (NSInteger) (ti / D_DAY);
    ti -= day * D_DAY;
    if (day > 0) {
        [resultString appendFormat:@"%ld天",(long)day];
    }
    
    NSInteger hour = (NSInteger) (ti / D_HOUR);
    ti -= hour * D_HOUR;
    
    [resultString appendFormat:@"%ld时",(long)hour];
    
    NSInteger min = (NSInteger) (ti / D_MINUTE);
    ti -= min * D_MINUTE;
    [resultString appendFormat:@"%ld分",(long)hour];
    
    NSInteger sec = ti;
    [resultString appendFormat:@"%ld秒",(long)sec];
    return resultString;
}

@end
