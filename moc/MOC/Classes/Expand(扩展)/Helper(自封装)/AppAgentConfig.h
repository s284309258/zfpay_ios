//
//  AppAgentConfig.h
//  MoPal_Developer
//
//  Created by fly on 15/11/30.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppAgentConfig : NSObject

/**
 *  配置程序的一些功能，定位、麦克风、推送
 */

+ (void)configApplicationForCapacity;

/**
 *  配置程序的引入的第三方库
 */

+ (void)configApplicationForThirdLibrary;
/**
 *  APP的一些默认设置，程序控制  UI控制
 */
+ (void)configApplicationForDefaultSetting;

/**
 *  检测APP更新了版本后，是否需要修改本地的一些配置或者缓存
 *
 *  @return Yes表示已做更新 NO表示还
 */
+ (BOOL)checkApplicationNeedModifyConfig;


/// 类方法调用追踪打印
+ (void)mx_xtrace;

/**
 *  分析App的一些数据，打印第三方库版本信息和最新的库，以及其它的信息
 */
+ (void)systemChecking;

@end
