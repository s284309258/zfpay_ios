//
//  AppAgentConfig.m
//  MoPal_Developer
//
//  Created by fly on 15/11/30.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import "AppAgentConfig.h"
#import "GVUserDefaults+Properties.h"
#import "MXRemotePush.h"
#import "MXMapConfig.h"
#import "AFNetworkActivityIndicatorManager.h"
#ifdef OpenDebugVC
#import "Xtrace.h"
#import "AppDelegate.h"
//#import "LoginManager.h"
//#import "LoginAccountHelper.h"
//#import "LoginVC.h"

//systemChecking使用
#ifdef DEBUG
#import <AlipaySDK/AlipaySDK.h>
#import <AMapSearchKit/AMapSearchVersion.h>
#import <AMapLocationKit/AMapLocationVersion.h>
#import "GeTuiSdk.h"
#import <MOBFoundation/MOBFoundation.h>
#import "MXShareManager.h"
#endif


#endif

@implementation AppAgentConfig

+ (void)configApplicationForCapacity{
    // 初始化 定位
//    [[MXLocationManager shareManager] startUpdatingLocation:nil];
    // 注册推送通知
//    [[MXRemotePush sharedInstance] registerRemoteNotification];
    //语音权限
    //[[MXDeviceManager sharedInstance] audioSessionAmbient];
    
}

+ (void)configApplicationForThirdLibrary{
    
#ifdef OpenDebugVC
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"serverType"]) {
        [GVUserDefaults standardUserDefaults].serverType = MXMoXianServerDomainTest;
    }

    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"debugLocation"]) {
        [GVUserDefaults standardUserDefaults].debugLocation = DebugLocationCurrent;
    }

#else
//    [GVUserDefaults standardUserDefaults].serverType = MXMoXianServerDomainOnline;
#endif
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"systemStatusIsValid"]) {
        [GVUserDefaults standardUserDefaults].systemStatusIsValid = YES;
    }

    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
//    [MXShareManager initShareSDK];    // 初始化对应平台的key的相关信息
    
    [[MXRemotePush sharedInstance] start];    // 初始化个推推送SDK
    
    
    [self configureImageUrlDomain];
}

#pragma mark - 支付
+ (void)paySetup {
//#ifdef OpenDebugVC
//    [MXPay initWeChatPay:@"wxf45936464a0d288a"];
//    [MXPay initAliPayAppId:@"2088521066096083"];
//#else
//    [MXPay initWeChatPay:@"wx4b8017b1d004ca04"];
//    [MXPay initAliPayAppId:@"2016111502850799"];
//#endif
}

#pragma mark - 配置图片域名
+ (void)configureImageUrlDomain {
    MLog(@"配置图片域名");
//    NSString *domain = [NSString stringWithFormat:@"http://image%@",[[MXNetworkConfig sharedInstance] getBaseRoot]];
//    [UIImageView configureGlobalDomain:domain];
}

#pragma mark - 类方法调用追踪打印
#ifdef OpenDebugVC
+ (void)mx_xtrace {
#ifdef DEBUG
    [Xtrace describeValues:NO];
    [Xtrace showCaller:YES];
    [Xtrace showActual:YES];
    [Xtrace showArguments:YES];
    [Xtrace showReturns:NO];
    [AppDelegate xtrace];
    [LoginVC xtrace];
    [LoginManager xtrace];
#endif
}
#endif

+ (void)configApplicationForDefaultSetting{   
    // add by yang.xiangbao 2015/10/8
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName : [UIColor blackColor],
                                                           NSFontAttributeName : [UIFont font19]
                                                           }];
    [GVUserDefaults standardUserDefaults].lastCheckAppVersion = 0;
}

/**
 *  检测APP更新了版本后，是否需要修改本地的一些配置或者缓存
 *
 *  @return Yes表示已做更新 NO表示还
 */
+ (BOOL)checkApplicationNeedModifyConfig{
    NSString* oldVersion = [GVUserDefaults standardUserDefaults].lastAppVersion;
    if ( oldVersion && [oldVersion compare:APPSHORTVERSION] != NSOrderedAscending) {
        return NO;
    }
    return YES;
}

+ (void)systemChecking{
#ifdef DEBUG
    NSMutableString *result = [NSMutableString string];
    [result appendString:@"\n-------------Checking Begin--------------\n"];
    
//    [result appendFormat:@"支付宝         --->当前版本：%@\n",[[AlipaySDK defaultService] currentVersion]];
//    [result appendFormat:@"高德Search     --->版本：%d\n",AMapSearchVersionNumber];
//    [result appendFormat:@"高德Foundation --->版本：%d\n",AMapFoundationVersionNumber];
//    [result appendFormat:@"高德Location   --->版本：%d\n",AMapLocationVersionNumber];
//    [result appendFormat:@"个推           --->版本：%@\n",[GeTuiSdk version]];
//    [result appendFormat:@"听云           --->版本：%@\n",@"2.5.0"];
//    [result appendFormat:@"ShareSDK      --->版本：%@\n",@"未知"];
    [result appendString:@"-------------Checking   End--------------\n"];
    
    MLog(@"%@",result);
#endif
}

@end
