//
//  NSDate+String.h
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/4/27.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (String)

+ (NSString*)dateString:(NSDate*)date;
+ (NSString *)dateHourMin;

+ (NSDate *)dateWithString:(NSString*)string
            withDateFormat:(NSString*)dateFormat;
+ (NSString *)endTimeIntervalDesc:(NSDate *)endTime;

+ (NSString*)dateString:(NSDate*)date format:(NSString* )format;

@end
