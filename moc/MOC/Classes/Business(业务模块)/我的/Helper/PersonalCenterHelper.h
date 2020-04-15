//
//  PersonalCenterHelper.h
//  MOC
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalCenterHelper : NSObject

//用户修改手机号接第一步
+ (void)modifyTelFirst:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//用户修改手机号接第二步
+ (void)modifyTelSecond:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;

+ (void)userInfoModify:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion;


+ (void)feedback:(UIView *)view completion:(MXHttpRequestResultObjectCallBack)completion;

+ (void)userInfoUpdate:(UIView *)view param:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion;

+ (void)modifyLoginPass:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion ;

+ (void)modifyPayPass:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion ;

+ (void)modifyUserInfo:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion ;
    
+(NSString* )getAuthStatus:(NSString*)auth_status;

+ (void)getUserAuthStatus:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion ;

+ (void)submitUserAuthInfo:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion ;
//通知列表
+ (void)getMessageRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion ;
//查询公告列表
+ (void)getNoticeList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion ;
//通知详情
+ (void)getMessageRecordDetail:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion ;
//查询公告详情
+ (void)getNoticeDetail:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion ;

@end

NS_ASSUME_NONNULL_END
