//
//  NSObject+YYModelExt.m
//  Lcwl
//
//  Created by mac on 2018/12/19.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "NSObject+YYModelExt.h"
#import <YYKit/NSObject+YYModel.h>

@implementation NSObject (YYModelExt)
+ (NSArray *)modelsArrayWithClass:(Class)cls array:(NSArray *)arr {
    if (!cls || !arr) return nil;
    NSMutableArray *result = [NSMutableArray new];
    for (NSDictionary *dic in arr) {
        if (![dic isKindOfClass:[NSDictionary class]]) continue;
        NSObject *obj = [cls modelWithDictionary:dic];
        if (obj) [result addObject:obj];
    }
    return result;
}
@end
