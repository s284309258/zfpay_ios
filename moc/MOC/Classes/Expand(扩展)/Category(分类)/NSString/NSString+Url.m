//
//  NSString+Url.m
//  Lcwl
//
//  Created by mac on 2019/1/15.
//  Copyright © 2019 lichangwanglai. All rights reserved.
//

#import "NSString+Url.h"
#import "QNManager.h"

@implementation NSString (Url)
- (NSArray *)urls {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    for(NSString *str in [self componentsSeparatedByString:@","]) {
        NSString *fullUrl = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,str];
        [arr addObject:fullUrl];
    }
    return [arr copy];
}
@end
