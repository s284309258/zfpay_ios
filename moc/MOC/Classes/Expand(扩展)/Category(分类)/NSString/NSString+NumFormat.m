//
//  NSString+NumFormat.m
//  MoPal_Developer
//
//  Created by Fly on 15/8/12.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "NSString+NumFormat.h"

#define kMaxShowNumber  9999

@implementation NSString (NumFormat)

+ (NSString*)getFormatTotalString:(NSInteger)count{
    if (count <= kMaxShowNumber) {
        return [NSString stringWithFormat:@"共%ld条",(long)count];
    }
    return [NSString stringWithFormat:@"共%d+",kMaxShowNumber];
}

+ (NSString*)getFormatBrowseCount:(NSInteger)count{
    if (count <= 1000) {
        return [NSString stringWithFormat:@"%ld",(long)count];
    }
    return [NSString stringWithFormat:@"%ldk",(long)(count/1000)];
}


- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (NSString *)showNoUnitFormatPrice{
    if (![self isKindOfClass:[NSString class]]) {
        return self;
    }
    //过滤货币符号
    NSString *resultString = [self copy];
    for (int i = 0; i < [resultString length]; i++) {
        if ([resultString characterAtIndex:i] < '0' ||
            [resultString characterAtIndex:i] > '9') {
            continue;
        } else {
            if (i == 0) break;
            resultString = [resultString substringFromIndex:i];
            break;
        }
    }
    return resultString;
}

- (NSString *)showIntFormatPrice:(BOOL)needUnit{
    if (![self isKindOfClass:[NSString class]]) {
        return self;
    }
    NSString *resultString = [self copy];
    if (!needUnit) {
        resultString = [self showNoUnitFormatPrice];
    }
    if ([resultString rangeOfString:@"."].location != NSNotFound) {
        return [[resultString componentsSeparatedByString:@"."] firstObject];
    }
    return resultString;
}

- (NSString *)formatterMoney {
    
    if ([self rangeOfString:@"."].location != NSNotFound) {
        NSString *left = [[self componentsSeparatedByString:@"."] firstObject];
        NSString *right = [[self componentsSeparatedByString:@"."] lastObject];
        if(right.length >= 2) {
            
            if(![[right substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"0"]) {
                right = [right substringToIndex:2];
            } else if(![[right substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
                right = [right substringToIndex:1];
            } else {
                right = nil;
            }
            
            if(right) {
                return $str(@"%@.%@",left,right);
            } else {
                return left;
            }
        } else if ([right isEqualToString:@"0"]) {
            return left;
        }
        
    } else {
        return self;
    }
    return self;
}

+ (NSString *)deductionPointTranferCash:(double)point {
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:[@(point) description]];
    NSDecimalNumber *cash = [number decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"1"] withBehavior:handler];
    return cash.stringValue;
}

- (NSString *)starReplace {
    if(self.length > 0) {
        NSInteger count = self.length;
        NSString *str = self;
        NSString *resultStr = nil;
        for(NSInteger i = count/4; i < count/2; i++) {
            resultStr = [str stringByReplacingCharactersInRange:NSMakeRange(i+1,1) withString:@"*"];
            str = resultStr;
        }
        return resultStr ?: self;
    }
    return nil;
}

- (NSString *)dateAddDot {
    if(self.length > 0) {
        NSInteger count = self.length;
        NSString *day = [self substringFromIndex:count-2];
        NSString *month = [self substringWithRange:NSMakeRange(count-4, 2)];
        NSString *year = [self substringToIndex:count-4];
        return [NSString stringWithFormat:@"%@.%@.%@",year,month,day];
    }
    return self;
}
@end
