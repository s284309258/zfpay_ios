//
//  MXPushCIDApi.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/4/10.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MXPushCIDApi.h"

@interface MXPushCIDApi ()


@end

@implementation MXPushCIDApi

- (id)initWithParameter:(NSDictionary*)dictionary {
    self = [super init];
    if (self) {
        self.paramDictionary = [dictionary mutableCopy];
    }
    return self;
}

- (MXRequestMethod)requestMXMethod
{
    return MXRequestMethodPut;
}

- (MXRequestSerializerType)requestSerializerType {
    return MXRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return push_cid;
}

- (id)requestArgument {
    return self.paramDictionary;
}


@end
