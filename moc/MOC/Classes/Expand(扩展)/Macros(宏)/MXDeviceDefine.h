//
//  MXDeviceDefine.h
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/12/18.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#ifndef MXDeviceDefine_h
#define MXDeviceDefine_h

// 当前经纬度
#define AppCurrentLocation [MXLocationManager shareManager].location
// 当前地址
#define AppCurrentAddress  [MXLocationManager shareManager].currentAddress
// 当前城市
#define AppCurrentCity     [MXLocationManager shareManager].currentCity

// 设备版本
#define IOS6_Later ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IOS7_Later	([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS8_Later ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS9_Later ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS10_Later ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS11_Later ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

#define kCurrentCityNameKey @"kCurrentCityNameKey"
#define kCurrentCityNameValue [MXCache valueForKey:kCurrentCityNameKey]

// 商城模块
#define kCurrentCityCodeKey @"kCurrentCityCodeKey"
#define kCurrentCountryCodeKey @"CurrentCountryCode"
#define kCurrentCityCodeValue [MXCache valueForKey:kCurrentCityCodeKey]
#define kSelectedCountryCode @"kSelectCountryCode"

#endif /* MXDeviceDefine_h */
