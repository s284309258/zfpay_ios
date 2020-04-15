//
//  NSString+DateFormatter.h
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/9/1.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DateFormatter)

- (NSString *)chineseFormatter:(NSString *)chinese otherFormatter:(NSString *)other;

- (NSString *)yyyyMMdd;
- (NSString *)yyyyMMddHHmm;
- (NSString *)MMddHHmmss;
- (NSString *)yyyyMMddHHmmss;
- (NSString *)todayOrYesterdayOrTime;
- (NSDate *)UTCDate;

+ (BOOL)compareTimeStrToCurrentTimeStr:(NSString *)timeStr;

@end
