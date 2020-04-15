//
//  MXUnbindCIDApi.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/4/10.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MXUnbindCIDApi.h"

@interface MXUnbindCIDApi ()


@end

@implementation MXUnbindCIDApi

- (id)initWithParameter:(NSDictionary*)dictionary {
    self = [super init];
    if (self) {
        self.paramDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    }
    return self;
}

- (MXRequestMethod)requestMXMethod
{
    return MXRequestMethodDelete;
}

- (MXRequestSerializerType)requestSerializerType {
    return MXRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return @"";
}

- (id)requestArgument {
    return self.paramDictionary;
}

@end
