//
//  NSArray+SafeAccess.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/7/29.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "NSArray+SafeAccess.h"

@implementation NSArray (SafeAccess)

- (id)safeObjectAtIndex:(NSInteger)index
{
    if ( index < 0 ) {
        return nil;
    }
    
    if ( index >= self.count ) {
        return nil;
    }
    
    return [self objectAtIndex:index];
}

@end

@implementation NSMutableArray (SafeAccess)

- (void)safeAddObj:(id)obj
{
    if (obj && [self isKindOfClass:[NSMutableArray class]]) {
        [self addObject:obj];
    }
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index
{
    if (index < 0 || index >= [self count]) {
        return;
    }
    [self removeObjectAtIndex:index];
}

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
//    if (![self isKindOfClass:[NSMutableArray class]]) {
//        NSLog(@"self->%@ 不是NSMutableArray类型",self);
//        return;
//    }
//    if (!anObject) {
//        NSLog(@"anObject 为空");
//        return;
//    }
//    if (index > [self count]) {
//        NSLog(@"数组越界 index > %@",@([self count]));
//        return;
//    }
    
    [self replaceObjectAtIndex:index withObject:anObject];
}

@end
