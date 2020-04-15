//
//  NSString+Ext.m
//  Lcwl
//
//  Created by mac on 2018/12/24.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "NSString+Ext.h"

@implementation NSString (Ext)

- (NSString *)removeSpaceAndNewline {
    NSString *temp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    //temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

@end
