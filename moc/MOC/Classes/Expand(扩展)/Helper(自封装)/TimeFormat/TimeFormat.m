//
//  TimeFormat.m
//  MoPromo_Develop
//
//  Created by yangjiale on 13/10/15.
//  Copyright (c) 2015年 MoPromo. All rights reserved.
//

#import "TimeFormat.h"

@implementation TimeFormat

+(NSString *)timeStringWithTime:(NSString *)time
{
    //处理时区差的问题
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *date = [formatter dateFromString:time];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    return [self timeStringWithTime:time format:@"yyyy-MM-dd HH:mm:ss"];
}
+(NSTimeInterval )getDateWithTime:(NSString *)time{
    //处理时区差的问题
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:time];
    return [self getLocalDate:date];
}
+(NSTimeInterval )getLocalDate:(NSDate*)date{
    //处理时区差的问题
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    return [localDate timeIntervalSince1970];
}

+(NSTimeInterval)getLocalDiffDate:(NSString*) date{
    NSTimeInterval orignTime = [TimeFormat getLocalDate:[NSDate date]];
    NSTimeInterval time = [TimeFormat getDateWithTime:date];
    return time-orignTime;
}

//将传入的秒数转换为当前时区时间seconds之后的时间
+ (NSString *)timeStringWithSeconds:(NSString *)seconds {
    NSString *remainingTime = seconds;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];;
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *remainingDate = [NSDate dateWithTimeIntervalSinceNow:[remainingTime integerValue]];
    NSInteger interval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:remainingDate];
    remainingDate = [remainingDate dateByAddingTimeInterval:interval];
    remainingTime = [dateFormatter stringFromDate:remainingDate];
    return remainingTime;
}

+(NSString *)timeStringWithTime:(NSString *)time format:(NSString *)formate{
    //处理时区差的问题
    if (!time) {
        return nil;
    }
    if (!formate || [formate isEqualToString:@""]) {
        formate = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:time];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    [formatter setDateFormat:formate];
    NSString *useTime = [formatter stringFromDate:localDate];
    return useTime;
}

// 转成东八区
+ (NSString *)timeStringWith8Zone:(NSString *)time
{
    NSDateFormatter *formatter = nil;
    NSTimeZone *GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:GTMzone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *transferDate = [formatter dateFromString:time];
    transferDate = [transferDate dateByAddingTimeInterval:60*60*8];
    NSString *useTime = [formatter stringFromDate:transferDate];
    return useTime;
}

+ (NSString *)currentDate {
    NSString *date = [[NSDate dateWithTimeIntervalSince1970:[TimeFormat getLocalDate:[NSDate date]]] description];
    return [[date componentsSeparatedByString:@" "] firstObject];
}

+ (NSString *)getDateString:(NSDate *)date {
    NSString *dateStr = [[NSDate dateWithTimeIntervalSince1970:[TimeFormat getLocalDate:date]] description];
    return [[dateStr componentsSeparatedByString:@" "] firstObject];
}

+ (NSString *)currentDateForyyyyMMdd {
    return [[self currentDate] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}
@end
