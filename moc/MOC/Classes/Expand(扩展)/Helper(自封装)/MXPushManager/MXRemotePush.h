//
//  MXRemotePush.h
//  MoPal_Developer
//
//  个推推送统一的入口使用步骤:
//  1. 调用 start 方法
//  2. 调用 registerRemoteNotification 方法
//
//  Created by yang.xiangbao on 15/4/8.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MXPushModel;

@interface MXRemotePush : NSObject

// 单例
+ (MXRemotePush *)sharedInstance;

// 初始化SDK首先要调用
// 在 - (BOOL)application:didFinishLaunchingWithOptions:
// 和
// - (void)applicationDidBecomeActive: 都需要调用一次
- (void)start;

// 注册推送通知
// 在 - (BOOL)application:didFinishLaunchingWithOptions: 中调用
- (void) registerRemoteNotification;

// 停止推送
// 在 - (void)applicationDidEnterBackground: 中调用
- (void)stopSdk;

- (void)resume;

// 向个推服务器注册deviceToken
// 在 application:didRegisterForRemoteNotificationsWithDeviceToken: 中调用
- (void) registerForRemoteNotificationsForGeTuiWithDeviceToken:(NSData*)deviceToken;

// 如果APNS注册失败，通知个推服务器
// 在 application:didFailToRegisterForRemoteNotificationsWithError: 中调用
- (void) registerGeTuiError;

// 接收远程推送的数据
// 在 - (void)application:didReceiveRemoteNotification: 中调用
- (void) didReceiveRemoteNotification:(NSDictionary *)userinfo;

// App 进入后台后，接收远程推送的数据
// 在 - (void)application:didReceiveRemoteNotification:fetchCompletionHandler: 中调用
- (void) didReceiveRemoteNotificationBackground:(NSDictionary *)userInfo;
- (void)didReceiveRemoteNotificationBackground:(NSDictionary *)userInfo application:(UIApplication *)application;

- (NSString *)sendMessage:(NSData *)body error:(NSError **)error;

// 绑定个推id到服务器
- (void)pushClientIDToServer;

// 个推设备解绑
- (void)unbindClientID;

// 当登录成功后，检测本地有没有离线推送的值，如果有，则通知切换界面跳转
- (void)sendNotificationMessage;

//缓存推送消息
+(void)saveCachePushMsg:(MXPushModel*)model;
//删除推送消息
+(void)deleteCachePushMsgWithType:(NSUInteger)type;
//读取缓存消息
+(MXPushModel*)readCachePushMsgWithType:(NSUInteger)type;
@end
