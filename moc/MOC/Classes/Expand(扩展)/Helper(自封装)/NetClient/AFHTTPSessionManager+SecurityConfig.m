//
//  AFHTTPSessionManager+SecurityConfig.m
//  JiuJiuEcoregion
//
//  Created by mac on 2019/6/15.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "AFHTTPSessionManager+SecurityConfig.h"
#import <objc/runtime.h>

@implementation AFHTTPSessionManager (SecurityConfig)
//+ (void)load {
//    Method originalMethod = class_getInstanceMethod([AFURLSessionManager class], NSSelectorFromString(@"initWithSessionConfiguration:"));
//    Method swapMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"mxnetSwizzling_initWithSessionConfiguration:"));
//    method_exchangeImplementations(originalMethod, swapMethod);
//}
//
//
/////防止抓包
//- (NSURLSessionConfiguration *)mxnetSwizzling_initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration {
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//#ifndef OpenDebugLcwl
//    config.connectionProxyDictionary = @{};
//#endif
//    return [self mxnetSwizzling_initWithSessionConfiguration:config];
//}
@end
