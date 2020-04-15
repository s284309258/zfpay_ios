//
//  AppDelegate.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/15.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Helper.h"
#import "VersionCheck.h"
#import "NSObject+LoginHelper.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()

@property (nonatomic,strong,readwrite) UserModel *currentAppUserInfosModel;

@property (nonatomic,copy) NSString *deviceToken;

@end

@implementation AppDelegate

- (id)init {
    if (self = [super init]) {
       
    }
    return self;
}

+ (void)updateAppUserModel:(UserModel *)model {
    if (![StringUtil isEmpty:model.token]) {
        AppUserModel = model;
        [model saveModelToCache];
    }
    if (model == nil) {
        AppUserModel = nil;
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    for (NSString *fontfamilyname in [UIFont familyNames])
//    {
//        NSLog(@"family:'%@'",fontfamilyname);
//        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
//        {
//            NSLog(@"\tfontName:'%@'",fontName);
//        }
//        NSLog(@"-------------");
//    }
    
    
   [self appInit];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error)
         {
             if( !error )
             {
                 [[UIApplication sharedApplication] registerForRemoteNotifications]; // required to get the app to do anything at all about push notifications
                 NSLog( @"Push registration success." );
             }
             else
             {
                 NSLog( @"Push registration FAILED" );
                 NSLog( @"ERROR: %@ - %@", error.localizedFailureReason, error.localizedDescription );
                 NSLog( @"SUGGESTIONS: %@ - %@", error.localizedRecoveryOptions, error.localizedRecoverySuggestion );
             }
         }];
    }

    return [self applicationFinishLaunching];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    NSMutableString *deviceTokenString = [NSMutableString string];
    const char *bytes = deviceToken.bytes;
    NSInteger count = deviceToken.length;
    for (int i = 0; i < count; i++) {
        [deviceTokenString appendFormat:@"%02x", bytes[i]&0x000000FF];
    }
    self.deviceToken = deviceTokenString;
    [self updateDeviceToken];
    NSLog(@"deviceToken: %@", deviceTokenString);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [VersionCheck checkNewVersion];
    
    //在这个方法里输入如下清除方法
    [application setApplicationIconBadgeNumber:0]; //清除角标
    [[UIApplication sharedApplication] cancelAllLocalNotifications];//清除APP所有通知消息
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)updateDeviceToken {
    @synchronized (self) {
        if(![StringUtil isEmpty:self.deviceToken] && ![StringUtil isEmpty:AppUserModel.user_id]) {
            [self updateUserDeviceToken:@{@"user_id": AppUserModel.user_id,@"device_token": self.deviceToken} completion:^(BOOL success, NSString *error) {
                
            }];
        }
    }
}

+ (BOOL)isTestDistribution {
    #ifdef OPEN_DISTRIBUTION
        return [[NSUserDefaults standardUserDefaults] integerForKey:@"open_distribution"];
    #else
        return NO;
    #endif
}
@end

