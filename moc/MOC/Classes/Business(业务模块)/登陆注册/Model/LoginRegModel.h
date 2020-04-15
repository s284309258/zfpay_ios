//
//  LoginRegModel.h
//  AdvertisingMaster
//
//  Created by mac on 2019/4/6.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, LoginType) {
    RegisterPhoneType,
    RegisterEmailType,
    LoginPhoneType,     // 手机登陆
    LoginEmailType,     // 邮箱登陆
    ForgetPhoneType,
    ForgetEmailType
};

@interface LoginRegModel : NSObject
//推荐人手机号
@property (nonatomic,strong) NSString *inviteCode;
//手机号码
@property (nonatomic,strong) NSString *phoneNo;
//登录密码（6-16位数字、字母组合）
@property (nonatomic,strong) NSString *password;
//确认密码
@property (nonatomic,strong) NSString *rePassword;
//支付密码（6位数字）
@property (nonatomic,strong) NSString *pay_password;
//图形验证码
@property (nonatomic,strong) NSString *picCode;
//验证码
@property (nonatomic,strong) NSString *captcha;
//登陆类型
@property (nonatomic) LoginType type;
//图形验证码
@property (nonatomic,strong) NSString *img_id;
//图形验证码
@property (nonatomic,strong) NSString *img_io;


- (UIImage*)ioImage;
@end


NS_ASSUME_NONNULL_END
