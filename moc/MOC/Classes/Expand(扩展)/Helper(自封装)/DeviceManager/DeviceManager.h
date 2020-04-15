//
//  DeviceManager.h
//  MoPal_Developer
//
//  设备相关信息管理
//  Created by 王 刚 on 14/12/29.
//  Copyright 
//

#import <Foundation/Foundation.h>

#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define SimulatorDebug @"Simulator"

// iphone设备分辨率,只获取一代的类型，比较说5和5s，则只获取5
typedef NS_ENUM(NSInteger , MXDeviceScreenType) {
    MXDeviceScreenUnknown,
    MXDeviceScreenIphone3,
    MXDeviceScreenIphone4,
    MXDeviceScreenIphone5,
    MXDeviceScreenIphone6,
    MXDeviceScreenIphone6Plus
};


@interface DeviceManager : NSObject

// 获取系统版本
+ (float)getIOSVersion;
// app名称
+ (NSString* )getAppName;

// app版本
+ (NSString* )getAppShortVersion;

// app build版本
+ (NSString* )getAppBundleVersion;

// 获取设备的类型
+ (NSString* )getDeviceModel;

+ (NSString* )getSystemVersion;

//+ (NSString* )getKey;

/**
 *  iphone6 plus 向下兼容  iphone4s
 *
 *  @param CGFloat size iphone6plus 大小
 *
 *  @return 真实设备大小
 */
+ (CGFloat)caculateDeviceSizeByType:(CGFloat)size;

+ (CGFloat)caculateFontSize:(CGFloat)size;

/**
 *  iphone 6 向上兼容 iphone6 plus
 *
 *  @param size iphone 5 大小
 *
 *  @return iphone6 plus 大小
 */
+ (CGFloat)caculateiPhone6UPDeviceSizeByType:(CGFloat)size;

+ (CGFloat)caculateiPhone6UPFontSize:(CGFloat)size;

// 获取设备分辨率类型
+ (MXDeviceScreenType)deviceType;

// 获取设备字符串
+ (NSString*)deviceString;

@end
