//
//  NSObject+LoginHelper.h
//  RatelBrother
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LoginHelper)
//图形验证码
- (void)createImgCode:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//发送手机验证码
- (void)send_code:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//注册
- (void)register:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//登录
- (void)login:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//退出登录
- (void)userLogOut:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//忘记密码
- (void)userForgetPass:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//重置密码
- (void)userResetPass:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;

- (void)sendSmsCodeToken:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;

- (void)userLogOut:(NSDictionary*)param view:(UIView *)superV completion:(MXHttpRequestCallBack)completion;

-(BOOL)isValidateEmail:(NSString *)email;

- (void)socialLogin:(NSDictionary*)param superView:(UIView *)superView completion:(MXHttpRequestCallBack)completion;

- (void)updateUserDeviceToken:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;

@end

NS_ASSUME_NONNULL_END
