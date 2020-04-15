//
//  MXHttpCallBackConfig.h
//  MoPal_Developer
//
//  网络请求回调全部在这里定义
//  Created by aken on 15/2/5.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#ifndef MoPal_Developer_MXHttpCallBackConfig_h
#define MoPal_Developer_MXHttpCallBackConfig_h

typedef void(^MXHttpRequestLoginCallBack)(BOOL success,NSString *error,NSString *errorCode);
typedef void(^MXHttpRequestCallBack)(BOOL success,NSString *error);
typedef void(^MXHttpRequestListCallBack)(id array,NSString *error);
typedef void(^MXHttpRequestObjectCallBack)(id object,NSString *error);
typedef void(^MXHttpRequestResultObjectCallBack)(BOOL success,id object,NSString *error);




#endif
