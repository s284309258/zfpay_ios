//
//  MXCache.h
//  MoPal_Developer
//
//  Created by xgh on 15/11/14.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXCache : NSObject

+ (void)setValue:(id)obj forKey:(NSString *)key;

+ (id)valueForKey:(NSString *)key;

+ (void)removeValueForKey:(NSString *)key;

+ (id)memoryValueForKey:(NSString *)key;

+ (void)setMemoryValue:(id)obj forKey:(NSString *)key;

/**
 *  清除所有的缓存，包括Disk和Memory
 */
+ (void)clearAll;

@end
