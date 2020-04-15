//
//  GetFriendsManager.m
//  MoPal_Developer
//
//  Created by GreenTreeInn on 15/4/15.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "FriendsManager.h"
#import "MXNet.h"
//#import "ChatSendHelper.h"
//#import "HDTZModel.h"
#import "FriendModel.h"
//#import "LcwlChat.h"

@implementation FriendsManager

//获取好友列表
+ (MXRequest *)getFriendList:(NSDictionary*) param completion:(MXHttpRequestListCallBack)completion {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/frined/getUserFriendList"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                NSArray* arr = [tempDic valueForKeyPath:@"data.userFriendList"];
                if (arr) {
                    NSMutableArray* friends = [[NSMutableArray alloc]initWithCapacity:50];
                    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        FriendModel * model = [FriendModel initFriendModel:obj];
                        model.followState = MoRelationshipTypeMyFriend;
                        [friends addObject:model];
//                        if (friends.count > 300) {
//                            *stop = YES;
//                        }
//                        [[LcwlChat shareInstance].chatManager updateRemarkMap:model.userid remark:model.remark needCheckExist:NO];
                        //更新数据库的remark字段
                        
                    }];
                    if (completion) {
                        completion(friends,nil);
                    }
                }
               
            }
        }).failure(^(id error){
            if (completion) {
                completion(nil,error);
            }
        })
        .execute();
    }];
    return nil;
}

+ (MXRequest *)searchFriendList:(NSString*)userName completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/user/info/searchUserLike"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(@{@"key_word":userName})
        .finish(^(id data){
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                NSArray* arr = [tempDic valueForKeyPath:@"data.userInfoList"];
                NSMutableArray* friends = [[NSMutableArray alloc]initWithCapacity:50];

                [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    FriendModel * model = [FriendModel initFriendModel:obj];
                    model.userid = [@([[obj objectForKey:@"user_id"] integerValue]) description];
                    [friends addObject:model];
                }];
                completion(friends,nil);
            }
        }).failure(^(id error){
               completion(nil,nil);
        })
        .execute();
    }];
    return nil;
}

///50、根据通讯录返回用户信息（聊天好友模块）(MD5验签方式）
+ (MXRequest *)moblieImportBook:(NSMutableArray*) param completion:(MXHttpRequestListCallBack)completion{
//    NSData *data=[NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *user_tels = [param componentsJoinedByString:@","];
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/frined/moblieImportFriend"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(@{@"user_tels":user_tels})
        .finish(^(id data){
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                NSArray* arr = [tempDic valueForKeyPath:@"data.userInfoList"];
                NSMutableArray* friends = [[NSMutableArray alloc]initWithCapacity:50];
                [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary* dict = (NSDictionary*)obj;
                    FriendModel * model = [FriendModel initFriendModel2:dict];
                    //model.userid = [NSString stringWithFormat:@"%@",dict[@"id"]];
                    [friends addObject:model];
                }];
//                [[LcwlChat shareInstance].chatManager insertFriends:friends];
                completion(friends,nil);
                
            }
        }).failure(^(id error){
            
        })
        .execute();
    }];
    return nil;
}

////获取新的好友
//+ (MXRequest *)getFriendMessage:(NSDictionary*) param completion:(MXHttpRequestListCallBack)completion {
//    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"givinggift/userInfo/front/getFriendMessage"];
//    [MXNet Post:^(MXNet *net) {
//        net.apiUrl(url).params(@{})
//        .finish(^(id data){
//            NSDictionary *tempDic = (NSDictionary*)data;
//            if ([tempDic[@"success"] boolValue]) {
//                NSArray* arr = tempDic[@"data"];
//                if (completion)  completion(arr,nil);
//            }
//        }).failure(^(id error){
//            if (completion) {
//                completion(nil,error);
//            }
//        })
//        .execute();
//    }];
//    return nil;
//}


// 添加好友 friendId
+ (MXRequest *)addFriend:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/frined/applyReplyAddFriend"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                completion(tempDic[@"data"],nil);
            }else{
                completion(nil,nil);
                if([[tempDic valueForKey:@"code"] isEqualToString:@"99"] && ![StringUtil isEmpty:[tempDic valueForKey:@"msg"]]) {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[tempDic valueForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
                    NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithData:[[tempDic valueForKey:@"msg"] dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
                    alertMessageStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@",[alertMessageStr.string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]];
                    [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, alertMessageStr.length)];
                    //[alertMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(3, 6)];
                    [alertController setValue:alertMessageStr forKey:@"attributedMessage"];
                    [alertController addAction:okAction];
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
                } else if(![StringUtil isEmpty:[data valueForKey:@"msg"]]) {
                    [NotifyHelper showMessageWithMakeText:tempDic[@"msg"]];
                }
            }
        }).failure(^(id error){
            if (completion) {
                [NotifyHelper showMessageWithMakeText:error];
                completion(nil,error);
            }
        })
        .execute();
    }];
    return nil;
}

//删除好友 friendId
+ (MXRequest *)delFriend:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/frined/delUserFriend"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                completion([tempDic[@"success"] boolValue],nil);
            }
        }).failure(^(id error){
            if (completion) {
                completion(false,error);
            }
        })
        .execute();
    }];
    return nil;
}
//发送好友验证信息接口
/*
 接收方ID
 acceId
 是
 String
 欲加好友的ID
 通知内容
 account
 是
 String
 加好友的通知消息

 */
+ (MXRequest *)sendVerifyMsg:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/frined/sendAddFriendMesg"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                completion([tempDic[@"success"] boolValue],nil);
            } else {
                NSString *msg = [tempDic valueForKey:@"msg"];
                if(msg && msg.length > 0) {
                    [NotifyHelper showMessageWithMakeText:msg];
                }
            }
        }).failure(^(id error){
            if (completion) {
                [NotifyHelper showMessageWithMakeText:error];
                completion(false,error);
            }
        })
        .execute();
    }];
    return nil;
}

//// 修改好友备注
//+ (MXRequest *)setNoteName:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
//    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"givinggift/userFriend/setNoteName"];
//    [MXNet Post:^(MXNet *net) {
//        net.apiUrl(url).params(param)
//        .finish(^(id data){
//            NSDictionary *tempDic = (NSDictionary*)data;
//            if ([tempDic[@"success"] boolValue]) {
//                completion([tempDic[@"success"] boolValue],nil);
//            }
//        }).failure(^(id error){
//            if (completion) {
//                [NotifyHelper showMessageWithMakeText:error];
//                completion(false,error);
//            }
//        })
//        .execute();
//    }];
//    return nil;
//}

+ (MXRequest *)complain:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/frined/userFriendComplain"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            completion(YES,nil);
//            NSDictionary *tempDic = (NSDictionary*)data;
//            if ([tempDic[@"success"] boolValue]) {
//                completion([tempDic[@"success"] boolValue],nil);
//            }
        }).failure(^(id error){
            if (completion) {
                //[NotifyHelper showMessageWithMakeText:error];
                completion(false,error);
            }
        })
        .execute();
    }];
    return nil;
}



// （社交）查询删我好友的人数相关信息
+ (MXRequest *)getRemoveFriendInfo:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/frined/getRemoveFriendInfo"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                completion(tempDic[@"data"],nil);
            }else{
                 [NotifyHelper showMessageWithMakeText:tempDic[@"msg"]];
            }
        }).failure(^(id error){
            if (completion) {
                [NotifyHelper showMessageWithMakeText:error];
                completion(nil,error);
            }
        })
        .execute();
    }];
    return nil;
}

// 10.（社交）一键清空对方删除我的好友
+ (MXRequest *)removeManyFriend:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/frined/removeManyFriend"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                NSDictionary* tempDic1 = [tempDic valueForKeyPath:@"data.delUserList"];
                completion(tempDic1[@"delUserList"],nil);
                [NotifyHelper showMessageWithMakeText:tempDic[@"msg"]];
            }else{
                [NotifyHelper showMessageWithMakeText:tempDic[@"msg"]];
            }
        }).failure(^(id error){
            if (completion) {
                [NotifyHelper showMessageWithMakeText:error];
                completion(nil,error);
            }
        })
        .execute();
    }];
    return nil;
}


////搜索好友
//+ (MXRequest *)SearchFan:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
//    SearchMoment *api = [[SearchMoment alloc]initWithParameter:param];
//    api.ignoreCache=YES;
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//
//        @try {
//
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//
//            NSMutableArray* tmpArray =nil;
//            NSDictionary* dataDic = [responseDict objectForKey:@"data"];
//            if ([dataDic isKindOfClass:[NSDictionary class]]) {
//
//                tmpArray= [[NSMutableArray alloc] initWithCapacity:0];
//                NSMutableArray *dataArray=dataDic[@"friends"];
//                for (NSDictionary* dict in dataArray) {
//                    MoYouModel* model = [MoYouModel dictionaryToModel:dict];
//                    [tmpArray safeAddObj:model];
//                }
//
//
//            }else{
//                MLog(@"this is not a dictionary.");
//            }
//
//            completion(tmpArray,MXLang(errorString, @""));
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//
//
//    } failure:^(MXRequest *request) {
//        completion(nil,[api requestServerErrorString]);
//    }];
//    return api;
//}
//
//// 获取附近的人
//+ (MXRequest *)getNearByList:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion
//{
//    //添加认证
//    NearFriends *api = [[NearFriends alloc] initWithParameter:param AndHeaderDictionary:[GetFriendsManager headerDictionary]];
//
//    //    api.userInfo = dict;//在请求header中添加
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            if (bol) {
//                NSMutableArray *value = [NSMutableArray array];
//                NSMutableArray *noImage = [NSMutableArray array];
//                if ([[responseDict objectForKey:@"data"] isKindOfClass:[NSArray class]])
//                {
//                    NSArray *ary = [responseDict objectForKey:@"data"];
//                    for (NSDictionary *dic in ary)
//                    {
//                        FriendModel *friend = [[FriendModel alloc] initWithNearByDictionary:dic];
////                        if ([StringUtil isEmpty:friend.avatar]) {
////                            [noImage safeAddObj:friend];
////                        } else {
////                            [value safeAddObj:friend];
////                        }
//                        [value safeAddObj:friend];
//                    }
//                }
//
//                [value addObjectsFromArray:noImage];
//                completion(value,MXLang(errorString, @""));
//            } else {
//                completion(nil, nil);
//            }
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(nil,nil);
//    }];
//
//    return api;
//}
//
//// 获取通讯录好友列表
//+ (MXRequest *)getPhoneByList:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion
//{
//    //添加认证
//    PhoneFriends *api = [[PhoneFriends alloc] initWithParameter:param AndHeaderDictionary:[GetFriendsManager headerDictionary]];
////    api.userInfo = dict;//在请求header中添加
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict =(NSDictionary*)request.responseJSONObject; //[MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//            NSArray *ary = [responseDict objectForKey:@"data"];
//            NSMutableArray *value = [NSMutableArray array];
//            for (NSDictionary *dic in ary) {
//                FriendModel *friend = [[FriendModel alloc] initWithDictionary:dic];
//                if ([friend.fans integerValue] == 0) {
//                    [value safeAddObj:friend];
//                }
//            }
//            completion(value,MXLang(errorString, @""));
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//            completion(nil,MXLang(errorString, @""));
//        }
//    } failure:^(MXRequest *request) {
//        completion(nil,[api requestServerErrorString]);
//    }];
//    return api;
//}
//
//// 创建群组
//+ (MXRequest *)addGroup:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion
//{
//    //添加认证
//    AddGroups *api = [[AddGroups alloc] initWithParameter:param AndHeaderDictionary:[GetFriendsManager headerDictionary]];
//
////    api.userInfo = dict;//在请求header中添加
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//            if (!bol) {
//                completion(nil,MXLang(errorString, @""));
//                return ;
//            }
//            NSDictionary *dic = [responseDict objectForKey:@"data"];
//            GroupModel *group = [[GroupModel alloc] initWithDictionary:dic];
//            NSMutableArray *array = [NSMutableArray arrayWithObject:group];
//            completion(array,MXLang(errorString, @""));
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//            completion(nil,MXLang(errorString, @""));
//
//        }
//    } failure:^(MXRequest *request) {
//        completion(nil,[api requestServerErrorString]);
//    }];
//    return api;
//}
//
//// 删除群组
//+ (MXRequest *)removeGroup:(NSDictionary *)param completion:(MXHttpRequestCallBack)completion
//{
//    //添加认证
//    DeleteGroup *api = [[DeleteGroup alloc] initWithParameter:param AndHeaderDictionary:[GetFriendsManager headerDictionary]];
//
////    api.userInfo = dict;//在请求header中添加
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//            completion(bol,MXLang(errorString, @""));
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(NO,[api requestServerErrorString]);
//    }];
//    return api;
//}
//
//// 编辑群名
//+ (MXRequest *)changeGroupName:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion
//{
//    //添加认证
//    changeGroupName *api = [[changeGroupName alloc] initWithParameter:param AndHeaderDictionary:[GetFriendsManager headerDictionary]];
//
////    api.userInfo = dict;//在请求header中添加
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//
//            NSDictionary *dic = [responseDict objectForKey:@"data"];
//
//            GroupModel *group = [[GroupModel alloc] initWithDictionary:dic];
//            NSMutableArray *array = [NSMutableArray arrayWithObject:group];
//
//            completion(array,MXLang(errorString, @""));
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(nil,[api requestServerErrorString]);
//    }];
//    return api;
//}
//
//// 查询组好友列表
//+ (MXRequest *)selectFriendWithGroup:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion
//{
//    //添加认证
//    selectFriendByGroup *api = [[selectFriendByGroup alloc] initWithParameter:param AndHeaderDictionary:[GetFriendsManager headerDictionary]];
//
////    api.userInfo = dict;//在请求header中添加
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//
//            NSMutableArray *ary = [responseDict objectForKey:@"data"];
//            NSMutableArray *array = [NSMutableArray array];
//            for (int i = 0; i<ary.count; i++) {
//                NSDictionary *dic = [ary safeObjectAtIndex:i];
//                GroupFriendModel *group = [[GroupFriendModel alloc] initWithDictionary:dic];
//                [array addObject:group];
//            }
//            completion(array,MXLang(errorString, @""));
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(nil,[api requestServerErrorString]);
//    }];
//    return api;
//}
//
//// 添加成员
//+ (MXRequest *)addFriendInGroup:(NSDictionary *)param completion:(MXHttpRequestCallBack)completion
//{
//    //添加认证
//    addFriendInGroup *api = [[addFriendInGroup alloc] initWithParameter:param AndHeaderDictionary:[GetFriendsManager headerDictionary]];
//
////    api.userInfo = dict;//在请求header中添加
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//            completion(bol,MXLang(errorString, @""));
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(NO,[api requestServerErrorString]);
//    }];
//    return api;
//}
//
//// 删除成员
//+ (MXRequest *)removeFriendInGroup:(NSDictionary *)param completion:(MXHttpRequestCallBack)completion
//{
//    //添加认证
//    deleteFriendInGroup *api = [[deleteFriendInGroup alloc] initWithParameter:param AndHeaderDictionary:[GetFriendsManager headerDictionary]];
//
////    api.userInfo = dict;//在请求header中添加
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//            completion(bol,MXLang(errorString, @""));
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(NO,[api requestServerErrorString]);
//    }];
//    return api;
//}
//
// 群组列表
//+ (MXRequest *)groupList:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion
//{
//    //添加认证
//    GroupList *api = [[GroupList alloc] initWithParameter:param AndHeaderDictionary:[GetFriendsManager headerDictionary]];
//
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//            NSMutableArray *ary = [responseDict objectForKey:@"data"];
//            NSMutableArray *array = [NSMutableArray array];
//            for (int i = 0; i<ary.count; i++) {
//                NSDictionary *dic = [ary safeObjectAtIndex:i];
//                GroupModel *group = [[GroupModel alloc] initWithDictionary:dic];
//                [array addObject:group];
//            }
//            completion(array,MXLang(errorString, @""));
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(nil,[api requestServerErrorString]);
//    }];
//    return api;
//    return nil;
//}
//
//// 未分组好友
//+ (MXRequest *)notinGroupWithFriend:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion
//{
//    //添加认证
//    FriendWithOutGroup *api = [[FriendWithOutGroup alloc] initWithParameter:param AndHeaderDictionary:[GetFriendsManager headerDictionary]];
//
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//            if (bol) {
//                NSMutableArray *ary = [responseDict objectForKey:@"data"];
//                NSMutableArray *array = [NSMutableArray array];
//                for (int i = 0; i<ary.count; i++) {
//                    NSDictionary *dic = [ary safeObjectAtIndex:i];
//                    GroupFriendModel *friend = [[GroupFriendModel alloc] initWithDictionary:dic];
//                    [array addObject:friend];
//                }
//                completion(array,MXLang(errorString, @""));
//            } else {
//                completion(nil,MXLang(errorString, @""));
//            }
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(nil,[api requestServerErrorString]);
//    }];
//    return api;
//}
//
////举报好友
//+ (MXRequest *)reportFriends:(NSDictionary *)param completion:(MXHttpRequestCallBack)completion
//{
//    //添加认证
//    ReportFriend *api = [[ReportFriend alloc] initWithParameter:param AndHeaderDictionary:nil];
//
////    api.userInfo = dict;//在请求header中添加
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//            completion(bol,MXLang(errorString, @""));
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(NO,[api requestServerErrorString]);
//    }];
//    return api;
//}
//
//// 加入黑名单
//+ (MXRequest *)addBlackList:(NSDictionary *)param completion:(MXHttpRequestCallBack)completion
//{
//    //添加认证
//    AddBlackList *api = [[AddBlackList alloc] initWithParameter:param AndHeaderDictionary:[GetFriendsManager headerDictionary]];
//
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//            completion(bol,MXLang(errorString, @""));
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(NO,[api requestServerErrorString]);
//    }];
//    return api;
//}
//
//// 获取黑名单
//+ (MXRequest *)getBlackList:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion
//{
//    //添加认证
//    BlackList *api = [[BlackList alloc] initWithParameter:param AndHeaderDictionary:[GetFriendsManager headerDictionary]];
//
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//            if (bol) {
//                NSMutableArray *ary = [responseDict objectForKey:@"data"];
//                NSMutableArray *array = [NSMutableArray array];
//                for (int i = 0; i<ary.count; i++) {
//                    NSDictionary *dic = [ary safeObjectAtIndex:i];
//                    BlackUserModel *friend = [BlackUserModel modelParseWithDict:dic];
//                    [array addObject:friend];
//                }
//                completion(array,MXLang(errorString, @""));
//            } else {
//                completion(nil,MXLang(errorString, @""));
//            }
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(nil,[api requestServerErrorString]);
//    }];
//    return api;
//}
//
//// 删除黑名单
//+ (MXRequest *)deleteBlackList:(NSDictionary *)param completion:(MXHttpRequestCallBack)completion
//{
////    DeleteBlack *api = [[DeleteBlack alloc] initWithParameter:param AndHeaderDictionary:[GetFriendsManager headerDictionary]];
//
//    DeleteBlack *api = [[DeleteBlack alloc] initWithParameter:param];
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//            completion(bol,MXLang(errorString, @""));
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(NO,[api requestServerErrorString]);
//    }];
//    return api;
//}
//+(NSMutableArray*)searchFriendByKeyword:(NSString*)keyword source:(NSMutableArray*) datasource{
//    NSMutableArray* tmpArray = [[NSMutableArray alloc]initWithCapacity:0];
//    NSString* searchText = [StringUtil chinasesCharToLetter:keyword];
//    for (NSMutableArray*tmp in datasource) {
//        for (id model in tmp) {
//            if ([model isKindOfClass:[MoYouModel class]]) {
//                MoYouModel* friend = (MoYouModel*)model;
//                NSString* searchName = [StringUtil chinasesCharToLetter:friend.name];
//                NSRange titleResult=[searchName rangeOfString:searchText options:NSCaseInsensitiveSearch];
//                if (titleResult.location != NSNotFound) {
//                    [tmpArray addObject:friend];
//                }
//
//            }
//        }
//    }
//    return tmpArray;
//}
//
//
//
//// 关注好友
//+ (MXRequest *)addFriend:(MoYouModel*)moyou completion:(MXHttpRequestCallBack)completion
//{
//    NSString* followID = moyou.chatId;
//    if (![followID isKindOfClass:[NSString class]]) {
//        return nil;
//    }
//    //自己不可以关注自己 20151217 wg
//    if ([moyou.chatId isEqualToString:AppUserModel.userId]) {
//        return nil;
//    }
//    MoYouModel* friend = [[MXChat sharedInstance].chatManager loadFriendByChatId:moyou.chatId];
//    if (friend == nil) {
//        [[MXChat sharedInstance].chatManager insertFriend:moyou];
//    }
//    MXAddFriendApi *addFriendApi = [[MXAddFriendApi alloc] initWithParameter:followID];
//    [addFriendApi startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//
//        NSDictionary *dict = request.responseJSONObject;
//        NSString *errorString=nil;
//        NSString *temp=nil;
//        NSString *followString = [NSString stringWithFormat:@"%@",dict[@"data"]];
//        if (![StringUtil isEmpty:followString]) {
//            NSInteger followState = [self getShipStateByString:followString];
//            MoYouModel* friend = [[MXChat sharedInstance].chatManager loadFriendByChatId:followID];
//            if (friend != nil) {
//                friend.followState = followState;
//                [[MXChat sharedInstance].chatManager insertFriend:friend];
//                [[NSNotificationCenter defaultCenter]postNotificationName:kRefreshFriend object:nil];
//            }
//
//        }
//
//        if ([dict[@"result"] boolValue]) {
//
//        } else {
//            temp=[NSString stringWithFormat:@"ErrorCode_%@",dict[@"code"]];
//            errorString=MXLang(temp, @"缺少服务器多语言资源包");
//        }
//        if([temp isEqualToString:@"ErrorCode_mx1103019"]){
//            friend.followState = MoRelationshipTypeMyFriend;
//            [[MXChat sharedInstance].chatManager insertFriend:friend];
//            [[NSNotificationCenter defaultCenter]postNotificationName:kRefreshFriend object:nil];
//         completion(![dict[@"result"] boolValue],errorString);
//        }else{
//             completion([dict[@"result"] boolValue],errorString);
//        }
//
//
//
//    } failure:^(MXRequest *request) {
//        DDLogCError(@"%@",[addFriendApi requestServerErrorString]);
//        completion(NO,[addFriendApi requestServerErrorString]);
//    }];
//
//    return addFriendApi;
//}
//
//// 获取好友详情
//+ (MXRequest*)fetchMopalDetailInfosWithUsersId:(NSString*)userId completion:(MXHttpRequestListCallBack)completion {
//
//    GetFriendDetailsApi *api = [[GetFriendDetailsApi alloc] initWithParameter:@{@"uid":userId}];
//    api.ignoreCache = YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//
//        NSDictionary *tempDic=(NSDictionary*)request.responseJSONObject;
//        NSString *errorString=@"";
//        NSMutableArray *tempArray=nil;
//        NSString *temp=nil;
//
//        @try {
//
//            if (tempDic) {
//
//                if ([tempDic[@"result"] boolValue]) {
//                    NSDictionary *dataDic=tempDic[@"data"];
//                    if ([dataDic isKindOfClass:[NSDictionary class]]) {
//                        UserModel *user=[[UserModel alloc] init];
//                        [user dictionaryToModel:dataDic];
//                        tempArray=[NSMutableArray array];
//                        [tempArray addObject:user];
//
//                    }
//                }else{
//
//                    temp=[NSString stringWithFormat:@"ErrorCode_%@",tempDic[@"code"]];
//                    errorString=MXLang(temp, @"");
//                }
//            }
//        }
//        @catch (NSException *exception) {
//            completion(nil,exception.name);
//        }
//
//        if ([StringUtil isEmpty:errorString]) {
//            errorString=MXLang(@"ErrorCode_public_00000", @"缺少服务器多语言资源包");
//        }
//
//        completion(tempArray,errorString);
//
//    } failure:^(MXRequest *request) {
//
//        completion(nil,[MXErrorCodeManager requestServerErrorString]);
//
//    }];
//
//    return api;
//}
//
//+ (MXRequest *)fetchReportOption:(MXHttpRequestListCallBack)completion{
//    //添加认证
//    ReportOptionApi *api = [[ReportOptionApi alloc] initWithParameter:nil];
//
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//            if (bol) {
//                completion([responseDict objectForKey:@"data"],MXLang(errorString, @""));
//            } else {
//                completion(nil,MXLang(errorString, @""));
//            }
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(nil,[api requestServerErrorString]);
//    }];
//    return api;
//}
//+ (MXRequest *)addFriendsToMultipleGroups:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;{
//    AddFriendsToGroupApi *api = [[AddFriendsToGroupApi alloc] initWithParameter:param];
//    api.ignoreCache=YES;
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        //返回的字符串
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//            completion(bol,MXLang(errorString, @""));
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//
//
//    } failure:^(MXRequest *request) {
//        completion(NO,[api requestServerErrorString]);
//    }];
//    return api;
//}
//
//+ (MXRequest *)fetchFriendGroups:(NSDictionary*)param completion:(MXHttpRequestListCallBack) completion{
//    //添加认证asdf
//    GetFriendGroupApi *api = [[GetFriendGroupApi alloc]initWithParameter:param];
//
//    //    api.userInfo = dict;//在请求header中添加
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//             errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//            NSMutableArray* tmp = [[NSMutableArray alloc] initWithCapacity:0];
//            NSMutableArray *array = [responseDict objectForKey:@"data"];
//            if (array.count == 0) {
//
//            }else{
//                for (NSDictionary* dict in array) {
//                     GroupModel *group = [[GroupModel alloc] initWithDictionary:dict];
//                    [tmp addObject:group];
//                }
//            }
//            completion(tmp,MXLang(errorString, @""));
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(nil,[api requestServerErrorString]);
//    }];
//    return api;
//}
//
//+ (MXRequest*)searchShopByName:(NSDictionary*)param completion:(MXHttpRequestListCallBack) completion{
//    //添加认证asdf
//    SearchShopApi *api = [[SearchShopApi alloc]initWithParameter:param];
//
//    //    api.userInfo = dict;//在请求header中添加
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString=[NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//            NSMutableArray* tmp = [[NSMutableArray alloc] initWithCapacity:0];
//            NSDictionary *dataDict = [responseDict objectForKey:@"data"];
//            NSMutableArray* listArray = [dataDict objectForKey:@"list"];
//            if (listArray.count == 0) {
//
//            }else{
//                for (NSDictionary *dict in listArray) {
//                    id<IShopInfo> shop = [MXShopListModel yy_modelWithDictionary:dict];
//                    shop.logoUrlStr = dict[@"logoUrl"];
//                    [tmp addObject:shop];
//                }
//            }
//            completion(tmp,MXLang(errorString, @""));
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(nil,[api requestServerErrorString]);
//    }];
//    return api;
//}
//
//+ (MXRequest*)saveFansLocation:(NSDictionary*)param completion:(MXHttpRequestCallBack) completion{
//    if ([StringUtil isEmpty:AppUserModel.token]) {
//        MLog(@"没有用户信息，不进行定位");
//        return nil;
//    }
//    NSMutableDictionary* paramDict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    CLLocationCoordinate2D coord = [MXLocationManager shareManager].location;
//    UserModel* user = AppUserModel;
//    [paramDict setValue:[NSNumber numberWithDouble:coord.longitude] forKey:@"x"];
//    [paramDict setValue:[NSNumber numberWithDouble:coord.latitude] forKey:@"y"];
//    [paramDict setValue:[NSNumber numberWithInt:[user.sex intValue]] forKey:@"gender"];
//    [paramDict setValue:[NSNumber numberWithBool:YES] forKey:@"visibility"];
//
//    FansLocationApi* api = [[FansLocationApi alloc]initWithParameter:paramDict];
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        @autoreleasepool {
//            BOOL bol = false;
//            NSString *responseString = request.responseString;
//            NSString *errorString = @"";
//            NSDictionary *responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            errorString = [NSString stringWithFormat:@"ErrorCode_%@",responseDict[@"code"]];
//
//            if (completion) {
//                completion(bol,MXLang(errorString, @""));
//            }
//
//            request = nil;
//        }
//    } failure:^(MXRequest *request) {
//        if (completion) {
//            completion(NO,[api requestServerErrorString]);
//        }
//
//        request = nil;
//    }];
//    return api;
//}
//
//+ (MXRequest*)getFriendRelation:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack) completion{
//
//    GetFriendRelationApi* api = [[GetFriendRelationApi alloc]initWithParameter:param];
//    api.ignoreCache=YES;
//
//    [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        BOOL bol = false;
//        NSString* responseString = request.responseString;
//        NSString* errorString = @"";
//        @try {
//            NSDictionary* responseDict = [MXJsonParser jsonToDictionary:responseString];
//            bol = [[responseDict objectForKey:@"result"] boolValue];
//            if (bol) {
//
//                completion([responseDict objectForKey:@"data"],[api requestServerErrorString]);
//            }else{
//                completion(nil,[api requestServerErrorString]);
//            }
//        }
//        @catch (NSException *exception) {
//            errorString = [exception name];
//        }
//    } failure:^(MXRequest *request) {
//        completion(nil,[api requestServerErrorString]);
//    }];
//    return api;
//
//
//}
//
//
//+(MoRelationshipType)getShipStateByString:(NSString*)relation{
//    NSString * relationship = relation;
//    int moRelationship = 0;
//    if (![StringUtil isEmpty:relationship]) {
//        if ([relationship isEqualToString:@"none"]) {
//            moRelationship = MoRelationshipTypeStranger;
//        }else if ([relationship isEqualToString:@"follower"]) {
//            moRelationship = MoRelationshipTypeMyFans;
//        }else if ([relationship isEqualToString:@"following"]) {
//            moRelationship = MoRelationshipTypeMyFollowing;
//        }else if ([relationship isEqualToString:@"friend"]) {
//            moRelationship = MoRelationshipTypeMyFriend;
//        }else if ([relationship isEqualToString:@"blacklist"]) {
//            moRelationship = MoRelationshipTypeMyBlackList;
//        }else{
//            moRelationship = MoRelationshipTypeNone;
//        }
//    }else{
//        moRelationship = MoRelationshipTypeNone;
//    }
//    return moRelationship;
//
//}
//
//+ (void)fetchFriendGroups{
//
//}
//
//+ (MXRequest*)grabsShopPoint:(MXHttpRequestObjectCallBack) completion {
//    GrabsPointApi *grab = [[GrabsPointApi alloc] init];
//    [grab startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        NSDictionary* responseDict = request.responseJSONObject;
//        completion([responseDict objectForKey:@"data"],nil);
//    } failure:^(MXRequest *request) {
//        completion(nil,nil);
//    }];
//    return grab;
//}

@end


