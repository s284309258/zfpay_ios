//
//  TimeFormat.h
//  MoPromo_Develop
//
//  Created by yangjiale on 13/10/15.
//  Copyright (c) 2015年 MoPromo. All rights reserved.
//

//处理时区差的问题

#import <Foundation/Foundation.h>

@interface TimeFormat : NSObject

+(NSString *)timeStringWithTime:(NSString *)time;
+(NSTimeInterval )getLocalDate:(NSDate*)date;
+(NSTimeInterval)getLocalDiffDate:(NSString*)date;
//将传入的秒数转换为当前时区时间seconds之后的时间
+(NSString *)timeStringWithSeconds:(NSString *)seconds;

+(NSString *)timeStringWithTime:(NSString *)time format:(NSString *)formate;
+(NSString *)timeStringWith8Zone:(NSString *)time;
///yyyy-MM-DD
+(NSString *)currentDate;
///指定日期yyyy-MM-DD
+ (NSString *)getDateString:(NSDate *)date;
///yyyyMMdd
+ (NSString *)currentDateForyyyyMMdd;
//[NSDate date] + 当前时区
+ (NSDate *)getCurTimeZoneDate:(NSDate*)date;
@end
