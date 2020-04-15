//
//  AppDelegate+Helper.h
//  Lcwl
//
//  Created by 王刚  on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Helper)

/**
 *  App 初始化
 */
- (void)appInit;

/**
 *  App 初始化第三方库,Window
 */
- (BOOL)applicationFinishLaunching;

- (void)applicationWillEnterForeground;

/**
 *  App 进入后台
 */
- (void)applicationDidEnterBackground;

- (void)applicationReceiveLocalNotification:(UILocalNotification *)notification;

- (void)applicationDidBecomeActive;

@end

NS_ASSUME_NONNULL_END
