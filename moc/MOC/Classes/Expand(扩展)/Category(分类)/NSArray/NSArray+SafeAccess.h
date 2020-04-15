//
//  NSArray+SafeAccess.h
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/7/29.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SafeAccess)

- (id)safeObjectAtIndex:(NSInteger)index;

@end

@interface NSMutableArray(SafeAccess)

- (void)safeAddObj:(id)obj;
- (void)safeRemoveObjectAtIndex:(NSUInteger)index;
- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end
