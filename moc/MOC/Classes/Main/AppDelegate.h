//
//  AppDelegate.h
//  AdvertisingMaster
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXRouter.h"
#import "MainViewController.h"
#import "BaseNavigationController.h"
//#import "StartPageVC.h"1
#import "UserModel.h"
// 打开日志,上线的时候要关闭
//#define Open_Log_Debug 1

// 上线的时候要关闭
//#define OpenDebugLcwl 1

//#define OPEN_DISTRIBUTION @"open_distribution"
//#define OPEN_DISTRIBUTION @"appstore_online_distribution"
#define OPEN_DISTRIBUTION @"appstore_test_distribution"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) MXRouter *router;
@property (nonatomic, strong) MainViewController *mainVC;

// 全局共用一个用户model
@property (nonatomic,strong,readonly) UserModel  *currentAppUserInfosModel;

+ (void)updateAppUserModel:(UserModel *)model;

- (void)updateDeviceToken;

+ (BOOL)isTestDistribution;

@end

