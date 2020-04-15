//
//  UserModel.h
//  MoPal_Developer
//
//  Created by 王 刚 on 15/2/26.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelProtocol.h"
#import "BaseObject.h"
#import "EnumDefine.h"
#import "RealNameModel.h"
/*
 {
 "auth_status" = 00;
 "head_photo" = "defaultAvatar.png";
 "pay_password" = 99999999999999;
 "qiniu_domain" = "http://cdn.yhswl.com";
 "qr_code_url" = "http://www.proecosystem.com/html/rst.html?account=15818614416";
 "real_name" = "";
 "sys_time" = 1566809702514;
 token = "8|MNNRHJWK0K6C3I1U2L4QGMQLU1ERYEOW";
 "user_id" = 8;
 "user_tel" = 15818614416;
 }
 */
@class MoYouModel;
@class MXWalletInfoModel;

typedef void(^UpdateCompletionBlock)(BOOL success);

#define MoCustomerUserId    @"100001"

@interface UserModel : BaseObject<ModelProtocol>


//@property (nonatomic ,copy) NSString* auth_status;

@property (nonatomic ,copy) NSString* head_photo;
// 用户ID
@property (nonatomic ,copy) NSString* pay_password;
// 邮件
@property (nonatomic ,copy) NSString* qiniu_domain;
// 手机
@property (nonatomic ,copy) NSString* qr_code_url;
// 名称
@property (nonatomic ,copy) NSString* real_name;
// 支付密码
@property (nonatomic ,copy) NSString* sys_time;
// 时间戳
@property (nonatomic ,copy) NSString* token;

@property (nonatomic ,copy) NSString* user_id;
// 用户状态
@property (nonatomic ,copy) NSString* user_tel;
// 用户代数，1表示代理）
@property (nonatomic ,copy) NSString* algebra;

@property (nonatomic ,copy) RealNameModel* real;

@property (nonatomic ,copy) NSString* app_id;

@property (nonatomic ,copy) NSString* password;

@property (nonatomic, copy) NSString* chatUser_id;
@property (nonatomic, copy) NSString* smartName;
@property (nonatomic ,copy) NSString* account;
@property (nonatomic ,copy) NSString* circle_back_img;
@property (nonatomic, copy) NSString* chatToken;

- (void)saveModelToCache;

+ (UserModel*)modelFromCache;

-(NSDictionary*)generateChatParam;
@end
