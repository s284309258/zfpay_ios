//
//  NSObject+Mine.m
//  BOB
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "NSObject+Mine.h"


@implementation NSObject (Mine)

- (void)setup_get_code:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/setup/get_code",LcwlServerRoot];
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


- (void)setup_edit_mobile:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/setup/edit_mobile",LcwlServerRoot];
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


- (void)setup_set_password:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/setup/set_password",LcwlServerRoot];
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


///火币模块更新个人信息
/*
 type    Y    0    int    1修改头像 2修改昵称 3修改性别 4修改个性签名 5设置地区
 pic    N    -    string    修改头像
 nickname    N    -    string    修改昵称
 sex    N    0    int    1男 2女
 sign_name    N    -    string    个性签名
 area    N    -    string    地区
*/
- (void)setup_edit_userinfo:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/setup/edit_userinfo",LcwlServerRoot];
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url)
        .useEncrypt().params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                Block_Exec(completion,YES,nil);
            }else{
                Block_Exec(completion,NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            Block_Exec(completion,NO,nil);

            //[NotifyHelper showMessageWithMakeText:error];
        })
        .execute();
    }];
    
    ///同时通知聊天模块
    [self modifyUserInfo:param completion:nil];
}

///聊天模块更新个人信息
- (void)modifyUserInfo:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion {
    [self modifyUserInfo:param showMsg:YES completion:completion];
}

- (void)modifyUserInfo:(NSDictionary*)param showMsg:(BOOL)showMsg completion:(MXHttpRequestCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/api/user/info/modifyUserInfo",LcwlServerRoot2];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url)
        .params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                Block_Exec(completion,YES,nil);
            }else{
                Block_Exec(completion,NO,nil);
            }
            if(showMsg) {
                [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
            }
        }).failure(^(id error){
            Block_Exec(completion,NO,nil);

            //[NotifyHelper showMessageWithMakeText:error];
        })
        .execute();
    }];
}

- (void)setup_get_realname:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/setup/get_realname",LcwlServerRoot];
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


- (void)setup_my_info:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/setup/my_info",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).useEncrypt()
        .params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSString* tmp = [dict valueForKeyPath:@"data.is_sign"];
                tmp = [NSString stringWithFormat:@"%@",tmp];
                if (tmp) {
                    //AppUserModel.auth = tmp;
                }
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
        }).failure(^(id error){
            completion(NO,nil);

            //[NotifyHelper showMessageWithMakeText:error];
        })
        .execute();
    }];
}
@end
