//
//  NSObject+Mine.h
//  BOB
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 AlphaGo. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Mine)

//1初级认证获取短信验证码、2修改登录密码、3交易密码、4修改手机号旧手机验证码、5修改手机号新手机验证码
- (void)setup_get_code:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//修改手机号
- (void)setup_edit_mobile:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//修改交易密码、登录密码
- (void)setup_set_password:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//修改个人信息
- (void)setup_edit_userinfo:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;

- (void)modifyUserInfo:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;

- (void)modifyUserInfo:(NSDictionary*)param showMsg:(BOOL)showMsg completion:(MXHttpRequestCallBack)completion;

//初级认证
- (void)setup_get_realname:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;

- (void)setup_my_info:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;

@end

NS_ASSUME_NONNULL_END
