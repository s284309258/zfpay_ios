//
//  MXRequest.m
//  YTKDemo
//
//  Created by aken on 16/10/13.
//  Copyright © 2016年 aken. All rights reserved.
//

#import "MXRequest.h"

@implementation MXRequest

- (YTKRequestMethod)requestMethod {
    
    MXRequestMethod method = [self requestMXMethod];
    
    if (method == MXRequestMethodGet) {
        return YTKRequestMethodGET;
    }else if (method == MXRequestMethodPost) {
        return YTKRequestMethodPOST;
    }else if (method == MXRequestMethodDelete) {
        return YTKRequestMethodDELETE;
    }else if (method == MXRequestMethodHead) {
        return YTKRequestMethodHEAD;
    }else if (method == MXRequestMethodPut) {
        return YTKRequestMethodPUT;
    }else if (method == MXRequestMethodPatch) {
        return YTKRequestMethodPATCH;
    }
    
    return YTKRequestMethodGET;
}

- (MXRequestMethod)requestMXMethod {
    return MXRequestMethodPost;
}

- (YTKRequestSerializerType)requestSerializerType {
    
    MXRequestSerializerType type = [self requestMXSerializerType];
    
    if (type == MXRequestSerializerTypeHTTP) {
        return YTKRequestSerializerTypeHTTP;
    }
    
    return YTKRequestSerializerTypeJSON;
}

- (MXRequestSerializerType)requestMXSerializerType {
    return MXRequestSerializerTypeJSON;
}

- (NSString*)requestServerErrorString {
    

    return @"网络不给力，请再试试啦～";
}

- (NSString*)requestNetWorkErrorString {
    
    
    return @"网络不给力，请再试试啦~";
    
    
}

@end
