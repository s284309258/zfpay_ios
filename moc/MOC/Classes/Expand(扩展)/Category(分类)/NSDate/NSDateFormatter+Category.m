/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "NSDateFormatter+Category.h"

@implementation NSDateFormatter (Category)

+ (NSDateFormatter *)formatterYYMMDDHHMMSS {
    static NSDateFormatter *dateYYMMDDHHMMSS = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        NSTimeZone *GTMzone = [NSTimeZone systemTimeZone];
        dateYYMMDDHHMMSS = [[NSDateFormatter alloc] init];
        [dateYYMMDDHHMMSS setTimeZone:GTMzone];
        [dateYYMMDDHHMMSS setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
//        dateYYMMDDHHMMSS = [[NSDateFormatter alloc] init];
//        [dateYYMMDDHHMMSS setFormatterBehavior:NSDateFormatterBehavior10_4];
//        [dateYYMMDDHHMMSS setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
//        [dateYYMMDDHHMMSS setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        [dateYYMMDDHHMMSS setTimeZone:[NSTimeZone systemTimeZone]];
    });
    
    return dateYYMMDDHHMMSS;
}

+ (NSDateFormatter *)formatterYYMMDD {
    static NSDateFormatter *dateYYMMDD = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        NSTimeZone *GTMzone = [NSTimeZone systemTimeZone];
        dateYYMMDD = [[NSDateFormatter alloc] init];
        [dateYYMMDD setTimeZone:GTMzone];
        [dateYYMMDD setDateFormat:@"yyyy-MM-dd"];
        
//        dateYYMMDD = [[NSDateFormatter alloc] init];
//        [dateYYMMDD setFormatterBehavior:NSDateFormatterBehavior10_4];
//        [dateYYMMDD setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
//        [dateYYMMDD setDateFormat:@"yyyy-MM-dd"];
//        [dateYYMMDD setTimeZone:[NSTimeZone systemTimeZone]];
    });
    
    return dateYYMMDD;
}

+ (NSDateFormatter *)formatterYYMMDDHHMM {
    static NSDateFormatter *dateYYMMDDHHMM = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        NSTimeZone *GTMzone = [NSTimeZone systemTimeZone];
        dateYYMMDDHHMM = [[NSDateFormatter alloc] init];
        [dateYYMMDDHHMM setTimeZone:GTMzone];
        [dateYYMMDDHHMM setDateFormat:@"yyyy-MM-dd HH:mm"];
        
//        dateYYMMDDHHMM = [[NSDateFormatter alloc] init];
//        [dateYYMMDDHHMM setFormatterBehavior:NSDateFormatterBehavior10_4];
//        [dateYYMMDDHHMM setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
//        [dateYYMMDDHHMM setDateFormat:@"yyyy-MM-dd HH:mm"];
//        [dateYYMMDDHHMM setTimeZone:[NSTimeZone systemTimeZone]];
    });
    
    return dateYYMMDDHHMM;
}

+ (NSDateFormatter *)formatterMMDDHHMMSS {
    static NSDateFormatter *dateMMDDHHMMSS = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        NSTimeZone *GTMzone = [NSTimeZone systemTimeZone];
        dateMMDDHHMMSS = [[NSDateFormatter alloc] init];
        [dateMMDDHHMMSS setTimeZone:GTMzone];
        [dateMMDDHHMMSS setDateFormat:@"MM-dd HH:mm:ss"];
        
//        dateMMDDHHMMSS = [[NSDateFormatter alloc] init];
//        [dateMMDDHHMMSS setFormatterBehavior:NSDateFormatterBehavior10_4];
//        [dateMMDDHHMMSS setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
//        [dateMMDDHHMMSS setDateFormat:@"MM-dd HH:mm:ss"];
//        [dateMMDDHHMMSS setTimeZone:[NSTimeZone systemTimeZone]];
    });
    
    return dateMMDDHHMMSS;
}

+ (NSDateFormatter *)formatterServer {
    static NSDateFormatter *dateServer = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        NSTimeZone *GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        dateServer = [[NSDateFormatter alloc] init];
        [dateServer setTimeZone:GTMzone];
        [dateServer setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    });
    
    return dateServer;
}

@end
