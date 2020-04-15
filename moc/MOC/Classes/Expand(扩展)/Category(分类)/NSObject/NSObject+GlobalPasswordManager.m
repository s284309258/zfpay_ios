//
//  NSObject+GlobalPasswordManager.m
//  MoPal_Developer
//
//  Created by xgh on 16/6/17.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import "NSObject+GlobalPasswordManager.h"
#import "UIView+FindViewController.h"
//#import "UIViewController+ForgotPasswd.h"
#import "NSDateFormatter+Category.h"
#import "BaseNavigationController.h"
#import "NSDate+Utilities.h"
//#import "CommonDefine.h"
//#import "MoNetTask.h"
#import "MXCache.h"
#import "PXAlertView.h"
#import "NSDate+String.h"
#import "TimeFormat.h"
#import "NSString+DateFormatter.h"
#import "NSDate+Formatter.h"

static id CurrentAlert = nil;
#define TimeZone8Seconds 60*60*8

@implementation NSObject (GlobalPasswordManager)
- (void)setExpiredTime:(NSDictionary *)expiredTimeInfo {
    NSString *expiredTime = [expiredTimeInfo valueForKey:@"expriaTime"];
    if([expiredTimeInfo isKindOfClass:[NSDictionary class]] && ![StringUtil isEmpty:expiredTime]) {
        [MXCache setValue:expiredTimeInfo forKey:[self cacheKey]];
    }
}

//判断当前用户密码是否被锁
- (void)passwordIsLocked:(PassIsLockedBlock)callBack {
    
//    NSDictionary *expiredTimeInfo = [MXCache valueForKey:[self cacheKey]];
//    if(!expiredTimeInfo) {
//        Block_Exec(callBack,NO);
//        return;
//    }
//
//    [self getServerTime:^(MXRequest *request, id responseData) {
//        NSString *expiredTime = [expiredTimeInfo objectForKey:@"expriaTime"];
//        NSString *serverTime = [responseData objectForKey:@"serverTime"];
//
//        if([StringUtil isEmpty:expiredTime]) {
//            Block_Exec(callBack,NO);
//            return;
//        }
//
//        //判断密码是否被锁，应该用过期时间和服务器的时间来对比，而不应该用过期时间和本地时间对比
//        NSDate *expiredDate = [expiredTime UTCDate];
//        NSDate *serverDate = [self transferDateTime:serverTime];
//        if([serverDate earlierDate:expiredDate] == serverDate) {
//            [self showLockAlert:serverTime];
//            Block_Exec(callBack,YES);
//        } else {
//            [MXCache removeValueForKey:[self cacheKey]];
//            Block_Exec(callBack,NO);
//        }
//    }];
}

- (void)showLockAlert:(NSString *)serverTime {
    @synchronized (self) {
        //如果已经弹出alert则不再弹出
        if(CurrentAlert) return;
        
        NSString *relativeTime = [self transferRelativeTime:serverTime];
        if([StringUtil isEmpty:relativeTime])
            return;
        
        UIViewController *topController = [UIView getTopViewControllerInNavigationStackFromWindow];
        CurrentAlert = [PXAlertView showAlertWithTitle:@"对不起,你已输错密码超过五次请十分钟后再试" endTime:relativeTime cancelTitle:@"忘记密码" otherTitle:@"确认" completion:^(BOOL cancelled, NSInteger buttonIndex) {
            if (cancelled) {
                //[topController forgotPasswd];
            }
            CurrentAlert = nil;
        }];
    }
}

//通过过期时间和服务器的时间的差值，计算出相对于本地的到期时间
- (NSString *)transferRelativeTime:(NSString *)serverTime {
    if([StringUtil isEmpty:serverTime]) return nil;
    
    NSDictionary *expiredTimeInfo = [MXCache valueForKey:[self cacheKey]];
    NSString *expiredTime = [expiredTimeInfo objectForKey:@"expriaTime"];

    NSDate *expiredDate = [expiredTime UTCDate];
    NSDate *serverDate = [self transferDateTime:serverTime];
    NSInteger secondValue = [expiredDate timeIntervalSinceDate:serverDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *curDate = [[NSDate date] dateByAddingTimeInterval:secondValue];
    return [curDate dateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

////获取服务器时间
//- (void)getServerTime:(MXClientSuccCallBack)success {
//    MoNetTask *task = [MoNetTask taskWithAutoLoadingView:nil];
//    task.needAutoErrorMessage = NO;
//    [task getRequest:talk_server_time withSuccess:^(MXRequest *request, id responseData) {
//        Block_Exec(success,request,responseData);
//    }];
//}

- (NSDate *)transferDateTime:(NSString *)dateString {
    NSDate *transferDate = [dateString UTCDate];
    transferDate = [transferDate dateByAddingTimeInterval:TimeZone8Seconds];
    return transferDate;
}

- (NSString *)cacheKey {
    return @"";//[NSString stringWithFormat:@"%@_passwordExpiredTime", AppUserModel.userId];
}

@end
