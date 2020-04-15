//
//  ProfitHelper.m
//  XZF
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ProfitHelper.h"
#import "UserCardModel.h"

#import "UserCardModel.h"
#import "BankModel.h"
#import "CashInfoModel.h"
#import "CashRecordModel.h"
@implementation ProfitHelper


+ (void)getUserCardList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/user/cardInfo/getUserCardList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* userCardList = [dict valueForKeyPath:@"data.userCardList"];
                NSArray* list = [UserCardModel modelListParseWithArray:userCardList];
                completion(list,nil);
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}


+ (void)searchLikeBank:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/bankInfo/searchLikeBank",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* userCardList = [dict valueForKeyPath:@"data.sysBankList"];
                NSArray* list = [BankModel modelListParseWithArray:userCardList];
                completion(list,nil);
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

+ (void)updateUserCard:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/user/cardInfo/updateUserCard",LcwlServerRoot];
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
            completion(nil,nil);
        })
        .execute();
    }];
}

+ (void)getCashInfo:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/user/cashRecord/getCashInfo",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* cashInfo = [dict valueForKeyPath:@"data.cashInfo"];
                CashInfoModel* model = [CashInfoModel modelParseWithDict:cashInfo];
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

+ (void)applyCash:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/api/user/cashRecord/applyCash",LcwlServerRoot];
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
            completion(nil,nil);
        })
        .execute();
    }];
}


+ (void)getUserValidCardList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/user/cardInfo/getUserValidCardList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* userCardList = [dict valueForKeyPath:@"data.userCardList"];
                NSArray* list = [UserCardModel modelListParseWithArray:userCardList];
                completion(list,nil);
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

+ (void)getCashRecordList:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/api/user/cashRecord/getCashRecordList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* userCardList = [dict valueForKeyPath:@"data.cashRecordList"];
                NSArray* model = [CashRecordModel modelListParseWithArray:userCardList];
                completion(YES,model,nil);
            }else{
                completion(NO,nil,nil);
            }
        }).failure(^(id error){
            completion(NO,nil,nil);
        })
        .execute();
    }];
}

@end
