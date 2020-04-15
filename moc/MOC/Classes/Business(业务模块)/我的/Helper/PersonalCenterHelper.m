//
//  PersonalCenterHelper.m
//  MOC
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "PersonalCenterHelper.h"
#import "RealNameModel.h"
#import "MessageRecordModel.h"
#import "NoticeModel.h"
#import "MessageRecordDetailModel.h"
@implementation PersonalCenterHelper
+ (void)modifyUserInfo:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/api/user/info/modifyUserInfo",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,dict,nil);
            }else{
                completion(false,nil,nil);
            }
        }).failure(^(id error){
            completion(NO,nil,nil);
            
            //[NotifyHelper showMessageWithMakeText:error];
        })
        .execute();
    }];
}
+ (void)modifyTelFirst:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/user/info/modifyTelFirst",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).useEncrypt()
        .params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* data = dict[@"data"];
                completion(data[@"valid_flag"],nil);
            }else{
                [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
            
            //[NotifyHelper showMessageWithMakeText:error];
        })
        .execute();
    }];
}

+ (void)modifyTelSecond:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/user/info/modifyTelSecond",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).useEncrypt()
        .params(param)
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
            
            //[NotifyHelper showMessageWithMakeText:error];
        })
        .execute();
    }];
}


+ (void)userInfoModify:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/user/safety/username",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if (![dict[@"code"] boolValue]) {
                completion(YES,dict,nil);
            }else{
                completion(NO,nil,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil,nil);
        })
        .execute();
    }];
}

+ (void)feedback:(UIView *)view completion:(MXHttpRequestResultObjectCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/feedback/save",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(nil)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if (![dict[@"code"] boolValue]) {
                completion(YES,dict,nil);
            }else{
                completion(NO,nil,nil);
            }
        }).failure(^(id error){
            completion(NO,nil,nil);
        })
        .execute();
    }];
}

+ (void)userInfoUpdate:(UIView *)view param:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/user/safety/update",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param).useHud(view)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if (![dict[@"code"] boolValue]) {
                completion(YES,dict,nil);
                [NotifyHelper showMessageWithMakeText:@"修改成功"];
            }else{
                [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
                completion(NO,nil,nil);
            }
        }).failure(^(id error){
            completion(NO,nil,nil);
        })
        .execute();
    }];
}

+ (void)modifyLoginPass:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/api/user/info/modifyLoginPass",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).useEncrypt().params(param).useMsg()
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
        })
        .execute();
    }];
}

///用户修改交易密码 /user/info/modifyPayPass
+ (void)modifyPayPass:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/api/user/info/modifyPayPass",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).useEncrypt().params(param)
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
        })
        .execute();
    }];
}

/*
 00—待认证
 04—待审核
 08—认证失败
 09—认证成功
 */
+(NSString* )getAuthStatus:(NSString*)auth_status{
    NSString * status = @"待认证";
    if ([auth_status isEqualToString:@"00"]) {
        status = @"待认证";
    }else if ([auth_status isEqualToString:@"04"]) {
        status = @"待审核";
    }else if ([auth_status isEqualToString:@"08"]) {
        status = @"认证失败";
    }else if ([auth_status isEqualToString:@"09"]) {
        status = @"认证成功";
    }
    return status;
}

+ (void)getUserAuthStatus:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/api/user/info/getUserAuthStatus",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* data = [dict valueForKeyPath:@"data.userAuthStatus"];
                RealNameModel* model = [RealNameModel modelParseWithDict:data];
                completion(YES,model,nil);
            }else{
                completion(NO,nil,nil);
            }
        }).failure(^(id error){
            completion(NO,nil,nil);
            
            //[NotifyHelper showMessageWithMakeText:error];
        })
        .execute();
    }];
}

+ (void)getMessageRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/message/getMessageRecordList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* messageRecordList = [dict valueForKeyPath:@"data.messageRecordList"];
                NSArray* dataArray = [MessageRecordModel modelListParseWithArray:messageRecordList];
                completion(dataArray,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

+ (void)getNoticeList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/notice/getNoticeList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* noticeInfoList = [dict valueForKeyPath:@"data.noticeInfoList"];
                NSArray * dataArray = [NoticeModel modelListParseWithArray:noticeInfoList];
                completion(dataArray,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

+ (void)getMessageRecordDetail:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/message/getMessageRecordDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* data = [dict valueForKeyPath:@"data.messageRecord"];
                MessageRecordDetailModel* array = [MessageRecordDetailModel modelParseWithDict:data];
                completion(YES,@[array],nil);
            }else{
                completion(NO,nil,nil);
            }
        }).failure(^(id error){
            completion(NO,nil,nil);
            
            //[NotifyHelper showMessageWithMakeText:error];
        })
        .execute();
    }];
}

+ (void)getNoticeDetail:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/notice/getNoticeDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* data = [dict valueForKeyPath:@"data.noticeInfo"];
                NoticeModel* array = [NoticeModel modelParseWithDict:data];
                completion(YES,array,nil);
            }else{
                completion(NO,nil,nil);
            }
        }).failure(^(id error){
            completion(NO,nil,nil);
            
            //[NotifyHelper showMessageWithMakeText:error];
        })
        .execute();
    }];
}


+ (void)submitUserAuthInfo:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/api/user/info/submitUserAuthInfo",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
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
        })
        .execute();
    }];
}

@end
