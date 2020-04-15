//
//  YTKNetworkAgent+Swizzling.m
//  YTKDemo
//
//  Created by aken on 16/9/24.
//  Copyright © 2016年 aken. All rights reserved.
//

#import "YTKNetworkAgent+Swizzling.h"
#import "MXCache.h"
#import "Aspects.h"
#import "YTKBaseRequest.h"
#import "GVUserDefaults+Properties.h"
#import "MXNet.h"
#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

// token失效
static const NSInteger mx_statusCode_401 = 401;

static NSString* const mx_statusCode_error = @"mx0000001";
static NSString* const mx_statusCode_server_error = @"mx9999999";


@implementation YTKNetworkAgent (Swizzling)

+ (void)load {
    
    
    [YTKNetworkAgent aspect_hookSelector:NSSelectorFromString(@"requestDidFailWithRequest:error:") withOptions:0 usingBlock:^(id<AspectInfo> info,YTKBaseRequest *request,NSError *error){
        
        // 踢线或token失效时
//        NSDictionary *tempDictionary = (NSDictionary *)request.responseJSONObject;
//        NSString *errorCode = tempDictionary[@"code"];
//        if (request.responseStatusCode == mx_statusCode_401 ||
//            ([errorCode isEqualToString:mx_statusCode_error])) {
//
//            if(![[MXCache valueForKey:@"DidShowKickOffAlert"] isEqualToString:@"YES"]) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:KNOTIFICATION_LOGINCHANGE_Kick_Off];
//                // 踢下线弹出置为1
//                [MXCache setValue:@"YES" forKey:@"DidShowKickOffAlert"];
//            }
//        }
//
//        [self checkServerIsMaintenance:errorCode error:error request:request];
        
        [YTKNetworkAgent showRequestFailDebugLogs:request];
        
    } error:nil];
    
    [YTKNetworkAgent aspect_hookSelector:NSSelectorFromString(@"requestDidSucceedWithRequest:") withOptions:0 usingBlock:^(id<AspectInfo> info,YTKBaseRequest *request){
        
        // 踢线或token失效时
        //NSDictionary *tempDictionary = (NSDictionary *)request.responseJSONObject;
        NSString *errorCode = [request.responseJSONObject valueForKey:@"code"];
        if ([errorCode isEqualToString:@"code_999990"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([MoApp respondsToSelector:NSSelectorFromString(@"loginOutLogic")]) {
                    [NotifyHelper showMessageWithMakeText:@"登录失效"];
                    [MoApp performSelector:NSSelectorFromString(@"loginOutLogic") withObject:nil afterDelay:1];
                }
            });
        }
        
        [YTKNetworkAgent showRequestSuccessDebugLogs:request];
        
    } error:nil];
    
//    [YTKNetworkAgent aspect_hookSelector:@selector(init) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
//
//        AFJSONResponseSerializer *res = (AFJSONResponseSerializer *)[[info instance] valueForKey:@"jsonResponseSerializer"];
//        res.removesKeysWithNullValues = YES;
//        
//    } error:nil];
    
}

// 检验服务器是否在维护
+ (void)checkServerIsMaintenance:(NSString*)errorCode error:(NSError*)error request:(YTKBaseRequest*)request {
    
    // code码为mx9999999时需要直接去检查状态服务器
    if ([errorCode isEqualToString:mx_statusCode_server_error]) {
        return;
    }
    if (request.responseStatusCode == mx_statusCode_401 ||
        ([errorCode isEqualToString:mx_statusCode_error])) {
        return;
    }
    self.errorCount += 1;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:[GVUserDefaults standardUserDefaults] selector:@selector(resetErrorCount) object:nil];
    [[GVUserDefaults standardUserDefaults] performSelector:@selector(resetErrorCount) withObject:nil afterDelay:60];
    
    if (self.errorCount >= 10) {
        NSLog(@"服务器停机维护~--->%@,%@",@(error.code),@(self.errorCount));
        [[GVUserDefaults standardUserDefaults] resetErrorCount];
    }
}

#pragma mark - Private
+ (void)setErrorCount:(NSUInteger)errorCount {
    [GVUserDefaults standardUserDefaults].errorRequestCount = errorCount;
}

+ (NSUInteger)errorCount {
    return [GVUserDefaults standardUserDefaults].errorRequestCount;
}


+ (void)showRequestSuccessDebugLogs:(YTKBaseRequest *)request {
    if ([GVUserDefaults standardUserDefaults].isOpenNetWorkLog) {
        
        MLog(@"\nFinished Request: %@ —— RequestMethod:%ld \
             \nRequestURL:%@         \
             \nRequestArgument:%@    \
             \nResponseDict:%@ "
             ,NSStringFromClass([request class]),(long)request.requestMethod,
             request.requestUrl,
             request.requestArgument?:@"no requestArgument",
             request.responseJSONObject);
    }
}

+ (void)showRequestFailDebugLogs:(YTKBaseRequest *)request {
    if ([GVUserDefaults standardUserDefaults].isOpenNetWorkLog) {
        
        MLog(@"\nRequest %@ failed, \n \
             Status code = %ld,\n      \
             ResponseString:%@",
             NSStringFromClass([request class]),
             (long)request.responseStatusCode,
             request.responseString);
    }
    
}

@end

