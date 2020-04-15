//
//  DeviceManager.m
//  MoPal_Developer
//
//  Created by 王 刚 on 14/12/29.
//  Copyright (c)
//

#import "DeviceManager.h"
#import "sys/utsname.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#define iphone5_size 320
#define iphone6_size 375
#define iphone6plus_size 414

@implementation DeviceManager

#pragma mark - 获取系统版本
+ (float)getIOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

#pragma mark -  app名称
+ (NSString* )getAppName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

#pragma mark -  app版本
+ (NSString* )getAppShortVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}


#pragma mark - app build版本
+ (NSString* )getAppBundleVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

#pragma mark - 获取设备的类型
+(NSString* )getDeviceModel{
    return [[UIDevice currentDevice] model];
}

+ (NSString* )getSystemVersion{
    
    return [[UIDevice currentDevice]systemVersion];
}


// 暂时注释掉
+ (NSString* )getMobileInfo{
    return @"";
}


#pragma mark - 各机型的实际大小
+ (CGFloat)caculateDeviceSizeByType:(CGFloat)size {
    CGFloat tempSize=size;
    if (SCREEN_WIDTH==iphone5_size) {
        tempSize = floor(size/1.5);
    }
    return tempSize;
}

// add by yang.xiangbao

#pragma mark - 计算iPhone 6 以上屏的尺寸
+ (CGFloat)caculateiPhone6UPDeviceSizeByType:(CGFloat)size {
    CGFloat tempSize=size;
    if (SCREEN_WIDTH > iphone6_size) {
        tempSize = floor(size * 1.5);
    }
    return tempSize;
}

+ (CGFloat)caculateiPhone6UPFontSize:(CGFloat)size {
    CGFloat tempSize=size;
    if (SCREEN_WIDTH > iphone6_size) {
        tempSize = floor(size * 1.2);
    }
    return tempSize;
}

+ (CGFloat)caculateFontSize:(CGFloat)size
{
    CGFloat tempSize=size;
    if (SCREEN_WIDTH == iphone5_size) {
        tempSize = floor(size / 1.2);
    }
    return tempSize;
}
// the end

// 获取设备类型
+ (MXDeviceScreenType)deviceType {
    
    MXDeviceScreenType type=MXDeviceScreenUnknown;
    
    CGSize currentSize=[UIScreen mainScreen].bounds.size;
    
    //
    if (CGSizeEqualToSize(CGSizeMake(320, 480),currentSize)) {
       
        if (isRetina) {
            type=MXDeviceScreenIphone4;
        }else{
            type=MXDeviceScreenIphone3;
        }
        
    }else if (CGSizeEqualToSize(CGSizeMake(320, 568),currentSize)) {
        type=MXDeviceScreenIphone5;
        
    }else if (CGSizeEqualToSize(CGSizeMake(375, 667),currentSize)) {
        type=MXDeviceScreenIphone6;
    }else if (CGSizeEqualToSize(CGSizeMake(414, 736),currentSize)) {
        type=MXDeviceScreenIphone6Plus;
    }else{
        type=MXDeviceScreenUnknown;
    }
    
    return type;
}

#pragma mark - 获取设备字符串
+ (NSString*)deviceString
{

    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    MLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}
@end
