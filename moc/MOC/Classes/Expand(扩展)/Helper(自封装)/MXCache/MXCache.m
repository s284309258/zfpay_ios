//
//  MXCache.m
//  MoPal_Developer
//
//  Created by xgh on 15/11/14.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import "MXCache.h"
#import <YYKit/YYCache.h>
#import <YYKit/YYMemoryCache.h>
//#import "MXLogManager.h"

@implementation MXCache

+ (YYCache *)yyCache {
    static dispatch_once_t onceToken;
    static YYCache *cache = nil;
    dispatch_once(&onceToken, ^{
        cache = [[YYCache alloc] initWithName:@"mxcache"];
    });
    
    return cache;
}

+ (void)setValue:(id)obj forKey:(NSString *)key
{
    if (!obj || !key) {
        return;
    }
    
    [[self yyCache] setObject:obj forKey:key];
}

+ (id)valueForKey:(NSString *)key
{
    if (!key) {
        return nil;
    }
    
    return [[self yyCache] objectForKey:key];
}

+ (id)memoryValueForKey:(NSString *)key {
    if (!key) {
        return nil;
    }
    
    return [[[self yyCache] memoryCache] objectForKey:key];
}

+ (void)setMemoryValue:(id)obj forKey:(NSString *)key {
    if (!key || !obj) {
        return;
    }
    
    [[[self yyCache] memoryCache] setObject:obj forKey:key];
}

+ (void)removeValueForKey:(NSString *)key {
    if (!key) {
        return;
    }
    
    [[self yyCache] removeObjectForKey:key];
}

+ (void)clearAll
{
    [[self yyCache] removeAllObjects];
    
    //清除日志缓存
    //[MXLogManager clearLog];
}

@end
