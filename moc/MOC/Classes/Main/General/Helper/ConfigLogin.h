//
//  ConfigLogin.h
//  MoPal_Developer
//
//  Created by yangjiale on 30/3/16.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#ifndef ConfigLogin_h
#define ConfigLogin_h

#define Login_Line_Background_Color RGBA(217, 217, 217, 0.7)

typedef NS_ENUM(NSUInteger, ThirdLoginType){
    ThirdLoginWeiXin       = 0,//微信
    ThirdLoginWeiBo        = 1,//微博
    ThirdLoginQQ           = 2,//QQ
};

/*************************************************启动页end************************************************************/

#define start_page_get_list MOXIAN_URL_STR_NEW(@"ad",@"/mo_ad/m2/initpage/moxian")


/*************************************************注册登录begin************************************************************/

//重新设置密码
#define send_reset_pwd MOXIAN_URL_HTTPS(@"sso",@"/mo_common_sso/m2/forget/resetpassword")

//验证 手机/邮箱 验证码 http://wiki2.moxian.com/index.php?title=手机验证验证码
#define verify_verification_code MOXIAN_URL_HTTPS(@"sso",@"/mo_common_sso/m2/forget/checkcaptcha")

// 手机找回密码发送验证码 http://wiki2.moxian.com/index.php?title=手机找回密码发送验证码
#define request_verification_code MOXIAN_URL_HTTPS(@"sso",@"/mo_common_sso/m2/forget/sendforgetcaptcha")


#define user_login_m2 MOXIAN_URL_HTTPS(MOXIAN_LOGIN_PREX,@"/mo_common_login/m2/auth/login")

#define user_thirdLogin_m2  MOXIAN_URL_HTTPS(MOXIAN_LOGIN_PREX,@"/mo_common_login/m2/auth/thirdLogin")

#define user_thirdUpdateLogin_m2  MOXIAN_URL_HTTPS(@"sso",@"/mo_common_sso/m2/thirdParty")

#define user_thirdAdd_m2  MOXIAN_URL_STR_NEW(@"setting",@"/mo_common_appsetting/m2/thirdParty")

#define register_reg_user_m2 MOXIAN_URL_HTTPS(@"sso",@"/mo_common_sso/m2/reg/moxian")

#define register_encryreg_user_m2 MOXIAN_URL_HTTPS(@"sso",@"/mo_common_sso/m2/encryreg/moxian")

#define register_sms_code_m2 MOXIAN_URL_HTTPS(@"sso",@"/mo_common_sso/m2/reg/checkphoneno")

#define register_submit_vercode_m2  MOXIAN_URL_HTTPS(@"sso",@"/mo_common_sso/m2/reg/checkcaptcha")

#define work_url  MOXIAN_URL_HTTPS(@"sso",@"/mo_common_sso/m2/job/joblist")

#define ImproveInfo_user_m2 MOXIAN_URL_STR_NEW(@"moxian",@"/mo_moxian/m2/userprofile")

#define register_judge_phonenumber_m2  MOXIAN_URL_HTTPS(@"sso",@"/mo_common_sso/m2/reg/phoneNo")

// 验证token是否失效
#define user_login_valid_token MOXIAN_URL_HTTPS(MOXIAN_LOGIN_PREX,@"/mo_common_login/m2/auth/valid")

//验证密码
#define setting_safety_VerfityPwd MOXIAN_URL_HTTPS(MOXIAN_LOGIN_PREX,@"/mo_common_login/m2/auth/password/validation")



#endif /* ConfigLogin_h */
