//
//  NSObject+LoginHelper.m
//  RatelBrother
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "NSObject+LoginHelper.h"
//#import "PwdLoginVC.h"
#import "UserModel.h"

@implementation NSObject (LoginHelper)

- (void)createImgCode:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/common/imgCode/createImgCode",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                completion(tempDic[@"data"],nil);
            }else{
                completion(nil,tempDic[@"msg"]);
                [NotifyHelper showMessageWithMakeText:tempDic[@"msg"]];
            }
        }).failure(^(id error){
            completion(nil,error);
        })
        .execute();
    }];
}

- (void)send_code:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/common/smsCode/sendSmsCodeOnly",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).useEncrypt()
        .params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
            
            //[NotifyHelper showMessageWithMakeText:error];
        })
        .execute();
    }];
}
/*
 {
 code = "code_999999";
 data =     {
 "sys_user_account" = Hao;
 token = "25486|XOZHIEBJM3SKLOU3H7CBRZQ2638TU6WB";
 };
 msg = "\U64cd\U4f5c\U6210\U529f";
 success = 1;
 }*/
- (void)register:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSMutableDictionary* muParam = [[NSMutableDictionary alloc] initWithDictionary:param];
    [muParam setObject:@"iPhone" forKey:@"device_no"];
    [muParam setObject:[NSString stringWithFormat:@"iOS%@",[[UIDevice currentDevice] systemVersion]] forKey:@"device_type"];
    [muParam setObject:APPSHORTVERSION forKey:@"version_no"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/user/login/userRegister",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).useEncrypt().params(muParam)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dataDict = dict[@"data"];
                completion(dataDict,nil);
            }else{
                completion(nil,nil);
                
                [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

/*
 {
 code = "code_999999";
 data =     {
 "head_photo" = "defaultAvatar.png";
 "nick_name" = Who;
 "pay_password" = "";
 "qiniu_domain" = "http://cdn.rxhcn.com";
 "qr_code_url" = "http://www.proecosystem.com/html/rst.html?account=Who";
 "register_type" = 1;
 "sys_time" = 1562575524038;
 "sys_user_account" = Who;
 token = "25485|1EFFFTRQO4ZUVYY6XDEYH4JK0D8VMSG9";
 "user_email" = "";
 "user_id" = 25485;
 "user_tel" = 15818614416;
 };
 msg = "\U64cd\U4f5c\U6210\U529f";
 success = 1;
 }
 */
- (void)login:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSMutableDictionary* muParam = [[NSMutableDictionary alloc] initWithDictionary:param];
    [muParam setObject:[NSString stringWithFormat:@"iOS%@",[[UIDevice currentDevice] systemVersion]] forKey:@"device_no"];
    [muParam setObject:@"iOS" forKey:@"device_type"];
    [muParam setObject:APPSHORTVERSION forKey:@"version_no"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/user/login/userLogin",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).useEncrypt().params(muParam)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dataDict = dict[@"data"];
                UserModel * model = [UserModel modelParseWithDict:dataDict];
                
                #ifdef OPEN_DISTRIBUTION
                [[NSUserDefaults standardUserDefaults] setInteger:[[dataDict valueForKey:@"open_distribution"] integerValue] forKey:@"open_distribution"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                #endif
                
                NSString* login_type = param[@"login_type"];
                if ([login_type isEqualToString:@"account"]) {
                    model.password = param[@"login_password"];
                }else{
                    model.password = AppUserModel.password;
                }
                
                [AppDelegate updateAppUserModel:model];
                [MoApp updateDeviceToken];
                completion(dataDict,nil);
            }else{
                completion(nil,nil);
                [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)socialLogin:(NSDictionary*)param superView:(UIView *)superView completion:(MXHttpRequestCallBack)completion {
    NSMutableDictionary* muParam = [[NSMutableDictionary alloc] initWithDictionary:param];
//    [muParam setValue:[NSString stringWithFormat:@"iOS%@",[[UIDevice currentDevice] systemVersion]] forKey:@"device_no"];
//    [muParam setValue:@"iOS" forKey:@"device_type"];
//    [muParam setValue:APPSHORTVERSION forKey:@"version_no"];
    
    NSString *url = [NSString stringWithFormat:@"%@/login/login_do",@"https://native.gmcoinclub.com"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).useEncrypt().params(muParam).useHud(superView)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"status"] integerValue] == 0) {
                //[MoApp resetKickOffState];
                NSDictionary* dataDict = dict[@"data"];
                //UserModel * model = [UserModel modelParseWithDict:dataDict];
                [NotifyHelper showHUDAddedTo:MoApp.window animated:YES];
                [self createUserToken:@{@"user_id":[dataDict valueForKey:@"id"],
                         @"sys_user_account":[dataDict valueForKey:@"account"],
                         @"head_photo":[dataDict valueForKey:@"pic"],
                         @"register_type":@"1",
                         @"user_tel":[dataDict valueForKey:@"mobile"],
                         //@"user_email":self.user_email,
                         @"system_type":@"BiHuo"
                } superView:superView completion:^(BOOL success, id object, NSString *error) {
                    [NotifyHelper hideHUDForView:MoApp.window animated:YES];
                    if(success) {
                        //[AppDelegate updateAppUserModel:model];
//                        model.webscoket_path = [object valueForKeyPath:@"data.websocket_path"];
                        AppUserModel.circle_back_img = [object valueForKeyPath:@"data.circle_back_img"];
                        AppUserModel.chatToken = [object valueForKeyPath:@"data.chat_token"];
                        AppUserModel.chatUser_id = [[@"data.chat_token" componentsSeparatedByString:@"|"] firstObject];
                        //[[LcwlChat shareInstance] chatLogin:model];
                        //[[NSNotificationCenter defaultCenter]postNotificationName:LanguageChangedNotification object:nil];
                        
                        completion(dataDict,nil);
                    }
                }];
            }else{
                completion(nil,nil);
                [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
//                 dispatch_async(dispatch_get_main_queue(), ^{
//                     if ([MoApp respondsToSelector:NSSelectorFromString(@"loginOutLogic")]) {
//                         [MoApp performSelector:NSSelectorFromString(@"loginOutLogic") withObject:nil afterDelay:0];
//                     }
//                 });
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)createUserToken:(NSDictionary*)param superView:(UIView *)superView completion:(MXHttpRequestResultObjectCallBack)completion{
    NSMutableDictionary* muParam = [[NSMutableDictionary alloc] initWithDictionary:param];
    [muParam setValue:[NSString stringWithFormat:@"iOS%@",[[UIDevice currentDevice] systemVersion]] forKey:@"device_no"];
    [muParam setValue:@"iOS" forKey:@"device_type"];
    [muParam setValue:APPSHORTVERSION forKey:@"version_no"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/user/info/createUserToken",LcwlServerRoot2];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).useEncrypt().params(muParam).useHud(superView)
        .finish(^(id data) {
            completion([data[@"success"] boolValue],data,nil);
        }).failure(^(id error) {
            completion(NO,nil,nil);
        })
        .execute();
    }];
}

///发送短信验证码接口（二：RSA加密方式+token验证）
- (void)sendSmsCodeToken:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/common/smsCode/sendSmsCodeToken",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.useEncrypt()
        .apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
            
            //[NotifyHelper showMessageWithMakeText:error];
        })
        .execute();
    }];
}

- (void)userForgetPass:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/user/login/userForgetPass",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).useEncrypt().params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(dict[@"code"],nil);
            }else{
                completion(nil,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)userResetPass:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/user/login/userResetPass",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).useEncrypt().params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(@"success",nil);
            }else{
                completion(nil,nil);
            }
            
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)userLogOut:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/api/user/login/userLogOut",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)updateUserDeviceToken:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/api/user/login/updateUserDeviceToken",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}


-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}
@end
