//
//  MXRequest.h
//  YTKDemo
//
//  用于桥连YTKRequest
//  Created by aken on 16/10/13.
//  Copyright © 2016年 aken. All rights reserved.
//

#import "YTKRequest.h"

// 请求方式
typedef NS_ENUM(NSInteger , MXRequestMethod) {
    MXRequestMethodGet = 0,
    MXRequestMethodPost,
    MXRequestMethodHead,
    MXRequestMethodPut,
    MXRequestMethodDelete,
    MXRequestMethodPatch
};

// 请求参数是否序列化
typedef NS_ENUM(NSInteger , MXRequestSerializerType) {
    MXRequestSerializerTypeHTTP = 0,
    MXRequestSerializerTypeJSON,
};


@interface MXRequest : YTKRequest

- (MXRequestSerializerType)requestMXSerializerType;

- (MXRequestMethod)requestMXMethod;

- (NSString*)requestServerErrorString;

- (NSString*)requestNetWorkErrorString;

@end
