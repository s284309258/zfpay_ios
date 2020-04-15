//
//  MoClient.h
//  MoPal_Developer
//
//  Created by Fly on 15/11/21.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXRequest.h"
static const NSString *K_Msg    = @"msg";
static const NSString *K_Code   = @"code";
static const NSString *K_Data   = @"data";
static const NSString *K_Result = @"result";

/**
 *  task请求成功的回调block
 *
 *  @param request      当前的网络请求
 *  @param responseData 返回的网络请求数据，可能是NSDictionary NSArray 或其它类型
 */
typedef void (^MXClientSuccCallBack)(MXRequest *request, id responseData);
typedef void (^MXClientFailCallBack)(MXRequest *request, NSString *error);

@interface MoNetTask : NSObject

//default is nil
@property (nonatomic, strong) UIView*  autoLoadingView;
//default is YES
@property (nonatomic, assign) BOOL  needAutoErrorMessage;

+ (instancetype)taskWithAutoLoadingView:(UIView*)view;

//Get
- (MXRequest*)getRequest:(NSString*)requestURL
                 withSuccess:(MXClientSuccCallBack)success;

//Post
- (MXRequest*)postRequest:(NSString*)requestURL
                   withParams:(NSDictionary*)params
                  withSuccess:(MXClientSuccCallBack)success;

//Put
- (MXRequest*)putRequest:(NSString*)requestURL
                  withParams:(NSDictionary*)params
                 withSuccess:(MXClientSuccCallBack)success;

//All Method
- (MXRequest*)startRequest:(NSString*)requestURL
                    withParams:(NSDictionary*)params
               withIgnoreCache:(BOOL)isIgnoreCache
             withRequestMethod:(MXRequestMethod)apiMethod
                   withSuccess:(MXClientSuccCallBack)success
                   withFailure:(MXClientFailCallBack)failure;


@end

