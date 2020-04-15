//
//  NSString+HandleCityName.m
//  MoPal_Developer
//
//  Created by fly on 16/1/14.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import "NSString+HandleCityName.h"

@implementation NSString (HandleCityName)

static NSArray *staticSuffixNames;

- (NSString *)handleSuffixString{
    staticSuffixNames = @[
                         @"特別行政區",
                         @"特別行政区",
                         ];
    NSString *result = [self copy];
    for (NSString *suffixString in staticSuffixNames) {
        if ([self hasSuffix:suffixString]) {
            result = [result substringToIndex:[result length] - [suffixString length]];
            break;
        }
    }
    result = [result handleSpecialString];
    return result;
}

static NSDictionary *staticSpecialCity;


- (NSString *)handleSpecialString{
    
    staticSpecialCity = @{
                           @"香港":@"香港",
                           @"澳門":@"澳门",
                           @"台湾省":@"台湾",
                           };
    NSString *result = [self copy];
    for (NSString *cityName in [staticSpecialCity allKeys]) {
        if ([self hasSuffix:cityName]) {
            result = [staticSpecialCity valueForKey:cityName];
            break;
        }
    }
    return result;
}

@end
