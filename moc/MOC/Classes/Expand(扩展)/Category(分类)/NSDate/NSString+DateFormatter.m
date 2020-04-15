//
//  NSString+DateFormatter.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/9/1.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "NSString+DateFormatter.h"
#import "NSDate+Utilities.h"
#import "MyCalendarUtil.h"
#import "NSDateFormatter+Category.h"

@implementation NSString (DateFormatter)

- (NSString *)chineseFormatter:(NSString *)chinese otherFormatter:(NSString *)other
{
    if ([StringUtil isEmpty:self]) {
        return @"";
    }
    
    NSString *formatter;
    //if ([[LanguageManager sharedManager] isChinese]) {
        formatter = chinese;
    //} else {
        //formatter = other;
    //}
    
    NSDateFormatter *dateFormatter;
    NSDate *dd = [self UTCDate];
    
    if ([formatter isEqualToString:@"yyyy-MM-dd HH:mm"]) {
        dateFormatter = [NSDateFormatter formatterYYMMDDHHMM];
    } else if ([formatter isEqualToString:@"MM-dd HH:mm:ss"]) {
        dateFormatter = [NSDateFormatter formatterMMDDHHMMSS];
    } else if ([formatter isEqualToString:@"yyyy-MM-dd"]) {
        dateFormatter = [NSDateFormatter formatterYYMMDD];
    } else if ([formatter isEqualToString:@"yyyy-MM-dd HH:mm:ss"]) {
        dateFormatter = [NSDateFormatter formatterYYMMDDHHMMSS];
    }
    
    NSString *time = [dateFormatter stringFromDate:dd];
    
    return time;
}

#pragma mark - 时间标准时间
- (NSDate *)UTCDate {
    NSDateFormatter *dateFormatter = [NSDateFormatter formatterServer];
    NSDate *dd = [dateFormatter dateFromString:self];
    return dd;
}

- (NSString *)yyyyMMddHHmm
{
    if ([StringUtil isEmpty:self]) {
        return @"";
    }
    
    return [self chineseFormatter:@"yyyy-MM-dd HH:mm" otherFormatter:@"HH:mm MM-dd-yyyy"];
}

- (NSString *)MMddHHmmss
{
    if ([StringUtil isEmpty:self]) {
        return @"";
    }
    
    return [self chineseFormatter:@"MM-dd HH:mm:ss" otherFormatter:@"HH:mm:ss MM-dd"];
}

- (NSString *)yyyyMMddHHmmss
{
    if ([StringUtil isEmpty:self]) {
        return @"";
    }
    
    return [self chineseFormatter:@"yyyy-MM-dd HH:mm:ss" otherFormatter:@"HH:mm:ss MM-dd-yyyy"];
}

- (NSString *)todayOrYesterdayOrTime
{
    NSDate *date = [self UTCDate];
    NSString *time;
    if ([date isToday]) {
        time = [date stringWithFormat:@"HH:mm"];
    } else if ([date isYesterday]) {
        time = [date stringWithFormat:[NSString stringWithFormat:@"%@ HH:mm",@"昨天"]];
    } else if ([date isThisYear]) {
        time = [date stringWithFormat:@"MM-dd HH:mm"];
    }  else {
        time = [date stringWithFormat:@"yyyy-MM-dd HH:mm"];
    }
    
    return time;
}

- (NSString *)yyyyMMdd
{
    if ([StringUtil isEmpty:self]) {
        return @"";
    }
    
    return [self chineseFormatter:@"yyyy-MM-dd" otherFormatter:@"MM-dd-yyyy"];
}

+ (BOOL)compareTimeStrToCurrentTimeStr:(NSString *)timeStr {
    NSString *currentTimeS = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    NSString *currentTimeStr = [MyCalendarUtil timeIntervalToString:currentTimeS setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    if ([StringUtil isEmpty:timeStr]) {
        return NO;
    }
    
    switch ([timeStr compare:currentTimeStr]) {
        case NSOrderedDescending:  //前面时间比后面大,即还在促销
            return YES;
        default:
            return NO;
    }
}

@end
