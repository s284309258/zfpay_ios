//
//  MXNet.h
//  MoPal_Developer
//
//  Created by yang.xiangbao on 16/7/20.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXHandleData.h"

@interface MXNet : NSObject

+ (void)Post:(void(^)(MXNet *net))block;

+ (void)Get:(void(^)(MXNet *net))block;

+ (void)Put:(void(^)(MXNet *net))block;

- (MXNet* (^)(NSString *))apiUrl;

- (MXNet* (^)(void))cache;

///是否显示请求返回说明
- (MXNet* (^)(void))useMsg;

- (MXNet* (^)(id))useHud;

///是否使用加密
- (MXNet* (^)(void))useEncrypt;

/**
 *  返回服务器错误原始数据，默认返回错误码
 */
- (MXNet* (^)(void))errorRamData;

- (MXNet* (^)(NSDictionary *))params;

- (MXNet* (^)(NSInteger))page;

- (MXNet* (^)(NSInteger))pageSize;

- (MXNet* (^)(void(^)(id)))finish;

- (MXNet* (^)(void(^)(id)))failure;

- (MXNet* (^)(void(^)(void)))timeOut;

- (MXNet* (^)(NSTimeInterval))timeoutInterval;

- (MXNet* (^)(id<MXHandleData>))parse;

- (void (^)(void))execute;

- (void (^)(void))cancle;

@end

