//
//  BaseObject.m
//  MoPal_Developer
//
//  Created by Fly on 15/8/13.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "BaseObject.h"
#import <YYKit/NSObject+YYModel.h>

@interface BaseObject () <NSCoding , NSCopying>

@end

@implementation BaseObject

+ (instancetype)modelParseWithDict:(NSDictionary *)dict{
    return [self modelWithDictionary:dict];
}

+ (NSArray *)modelListParseWithArray:(NSArray*)dictList{
    return [NSArray modelArrayWithClass:[self class] json:dictList];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    MLog(@"class:%@ setValue:%@,forUndefinedKey:%@",NSStringFromClass([self class]),value,key);
}

- (NSDictionary*)genTaskParams{
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self modelInitWithCoder:aDecoder];
}

- (id)copyWithZone:(NSZone *)zone {
    return [self modelCopy];
}

- (NSUInteger)hash {
    return [self modelHash];
}

- (BOOL)isEqual:(id)object {
    return [self modelIsEqual:object];
}

@end
