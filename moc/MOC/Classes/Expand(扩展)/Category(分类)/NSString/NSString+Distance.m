//
//  NSString+Distance.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/11/25.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import "NSString+Distance.h"

@implementation NSString (Distance)

- (NSString *)distance
{
    if (![self isKindOfClass:[NSString class]]) {
        return @"";
    }
    
    if ([self hasSuffix:@"m"]) {
        return self;
    }
    
    if ([self floatValue] < 1000) {
        return [NSString stringWithFormat:@"%.0fm",[self floatValue]];
    }
    
    CGFloat distance = [self floatValue] * 0.001;
    if(distance >= 100.0) {
        return [NSString stringWithFormat:@"%@km",[self notRounding:distance afterPoint:0]];
    } else {
        return [NSString stringWithFormat:@"%@km",[self notRounding:distance afterPoint:1]];
    }
    
    return @"";
}

//yangjiale
//四舍五入
- (NSString *)notRounding:(CGFloat)price afterPoint:(NSInteger)position {
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}
//end

@end
