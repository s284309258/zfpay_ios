//
//  MoClient.m
//  MoPal_Developer
//
//  Created by Fly on 15/11/21.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import "MoNetTask.h"
#import "MXRequest.h"
#import "MBErrorManager.h"
#import "CommonDefine.h"
#import "MXBaseRequestApi.h"

#pragma mark - MoClientApi

@interface MoClientApi : MXBaseRequestApi

@property (nonatomic, readwrite, strong) NSString *apiURL;

@property (nonatomic, readwrite, assign) MXRequestMethod apiMethod;

+ (instancetype)apiWithURL:(NSString*)requestURL withParams:(NSDictionary*)params;

@end


@implementation MoClientApi

+ (instancetype)apiWithURL:(NSString*)requestURL withParams:(NSDictionary*)params
{
    MoClientApi *api = [[MoClientApi alloc] initWithParameter:params];
    api.apiURL = requestURL;
    return api;
}

- (NSString*)requestUrl{
    return self.apiURL?:@"";
}

- (MXRequestMethod)requestMXMethod {
    return self.apiMethod;
}

@end

#pragma mark - MoNetClient

@implementation MoNetTask

- (void)dealloc{
    self.autoLoadingView = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.needAutoErrorMessage = YES;
    }
    return self;
}

+ (instancetype)taskWithAutoLoadingView:(UIView*)view{
    MoNetTask *task = [[MoNetTask alloc] init];
    task.autoLoadingView = view;
    return task;
}

//Get
- (MXRequest*)getRequest:(NSString*)requestURL
                 withSuccess:(MXClientSuccCallBack)success{
    return [self getRequest:requestURL withParams:nil withSuccess:success withFailure:nil];
}

- (MXRequest*)getRequest:(NSString*)requestURL
                  withParams:(NSDictionary*)params
                 withSuccess:(MXClientSuccCallBack)success
                 withFailure:(MXClientFailCallBack)failure{
    return [self startRequest:requestURL withParams:params withIgnoreCache:YES withRequestMethod:MXRequestMethodGet withSuccess:success withFailure:failure];
}

- (MXRequest*)postRequest:(NSString*)requestURL
                   withParams:(NSDictionary*)params
                  withSuccess:(MXClientSuccCallBack)success{
    return [self postRequest:requestURL withParams:params withSuccess:success withFailure:nil];
}

- (MXRequest*)postRequest:(NSString*)requestURL
                   withParams:(NSDictionary*)params
                  withSuccess:(MXClientSuccCallBack)success
                  withFailure:(MXClientFailCallBack)failure{
    return [self startRequest:requestURL withParams:params withIgnoreCache:YES withRequestMethod:MXRequestMethodPost withSuccess:success withFailure:failure];
}


//Put
- (MXRequest*)putRequest:(NSString*)requestURL
                  withParams:(NSDictionary*)params
                 withSuccess:(MXClientSuccCallBack)success{
    return [self startRequest:requestURL withParams:params withIgnoreCache:YES withRequestMethod:MXRequestMethodPut withSuccess:success withFailure:nil];
}


- (MXRequest*)startRequest:(NSString*)requestURL
                    withParams:(NSDictionary*)params
               withIgnoreCache:(BOOL)isIgnoreCache
             withRequestMethod:(MXRequestMethod)apiMethod
                   withSuccess:(MXClientSuccCallBack)success
                   withFailure:(MXClientFailCallBack)failure{
    if ([StringUtil isEmpty:requestURL]) {
        MLog(@"requestURL is isEmpty");
        return nil;
    }
    
    if (apiMethod > MXRequestMethodPatch ||
        apiMethod < MXRequestMethodGet) {
        MLog(@"不支持的网络请求方式");
        return nil;
    }
    MoClientApi *api = [MoClientApi apiWithURL:requestURL withParams:params];
    api.ignoreCache  = isIgnoreCache;
    api.apiMethod    = apiMethod;
    
    if (self.autoLoadingView) {
    }
    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
        if (success) {
            NSDictionary *response = request.responseJSONObject;
            BOOL result = [response[@"result"] boolValue];
            if (!result) {
                NSString *errorInfo = [MBErrorManager showErrorMessageWithCode:response[K_Code]];
                if ([StringUtil isEmpty:errorInfo]) {
                    errorInfo = @"错误";
                }
                [self hideHudWithMessage:errorInfo];
                Block_Exec(failure,request,errorInfo);
            }else{
                [self hideHudWithMessage:nil];
                if (response[K_Data]) {
                    Block_Exec(success,request,response[K_Data]);
                }else{
                    Block_Exec(success,request,nil);
                }
            }
        }
    } failure:^(MXRequest *request) {
        NSString *errorInfo = [request requestServerErrorString];
        [self hideHudWithMessage:errorInfo];
        Block_Exec(failure,request,errorInfo);
    }];
    return api;
}

- (void)hideHudWithMessage:(NSString*)message{
    if (self.autoLoadingView) {
        
    }
    
    if (self.needAutoErrorMessage && message) {
        
    }
}


@end
