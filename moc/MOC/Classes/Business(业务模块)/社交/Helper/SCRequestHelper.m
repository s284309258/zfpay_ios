//
//  SCRequestHelper.m
//  Lcwl
//
//  Created by mac on 2018/12/25.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "SCRequestHelper.h"
#import "FriendsManager.h"
#import "FriendModel.h"
//#import "ChatSendHelper.h"
#import "WBStatusHelper.h"
//#import "LcwlChat.h"

@implementation SCRequestHelper

+ (void)circleAddNew:(NSDictionary *)param completion:(CompletionBlock)block {
    NSMutableDictionary *muParam = [NSMutableDictionary dictionaryWithDictionary:param];
    [muParam setValue:@"add" forKey:@"op_type"];
    if(![[muParam allKeys] containsObject:@"send_type"]) {
        [muParam setValue:@"00" forKey:@"send_type"];
    }
    [self circleOperation:muParam completion:block];
}

+ (void)circleDelete:(NSDictionary *)param completion:(CompletionBlock)block {
    NSMutableDictionary *muParam = [NSMutableDictionary dictionaryWithDictionary:param];
    [muParam setValue:@"del" forKey:@"op_type"];
    [self circleOperation:muParam completion:block];
}

+ (void)circleForward:(NSDictionary *)param completion:(CompletionBlock)block {
    NSMutableDictionary *muParam = [NSMutableDictionary dictionaryWithDictionary:param];
    [muParam setValue:@"add" forKey:@"op_type"];
    [muParam setValue:@"01" forKey:@"send_type"];
    [self circleOperation:muParam completion:block];
}

+ (void)circleOperation:(NSMutableDictionary *)param completion:(CompletionBlock)block {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/circle/circle"];
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data) {
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                [NotifyHelper showMessageWithMakeText:([[param valueForKey:@"op_type"] isEqualToString:@"add"] ? @"发布成功" : @"删除成功")];
                Block_Exec(block,tempDic);
            } else {
                Block_Exec(block,tempDic);
            }
        }).failure(^(id error){
            Block_Exec(block,nil);
            [NotifyHelper showMessageWithMakeText:[error description]];
        })
        .execute();
    }];
}

+ (void)circleRecommandList:(NSDictionary *)param completion:(CompletionBlock)block {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/circle/getRecommendCircleList"];
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data) {
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                Block_Exec(block,tempDic);
            } else {
                Block_Exec(block,nil);
            }
        }).failure(^(id error){
            Block_Exec(block,nil);
            [NotifyHelper showMessageWithMakeText:[error description]];
        })
        .execute();
    }];
}

+ (void)circleCareList:(NSDictionary *)param completion:(CompletionBlock)block {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/circle/getFriendCircleList"];
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data) {
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                Block_Exec(block,tempDic);
            } else {
                Block_Exec(block,nil);
            }
        }).failure(^(id error){
            Block_Exec(block,nil);
            [NotifyHelper showMessageWithMakeText:[error description]];
        })
        .execute();
    }];
}

+ (void)circlePersonalList:(NSDictionary *)param completion:(CompletionBlock)block {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/circle/getPersonalDataCircleList"];
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data) {
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                
                Block_Exec(block,tempDic);
            }
        }).failure(^(id error){
            Block_Exec(block,nil);
            [NotifyHelper showMessageWithMakeText:[error description]];
        })
        .execute();
    }];
}

+ (void)getCircleYesterdayRankList:(NSDictionary *)param completion:(CompletionBlock)block {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/circle/getCircleYesterdayRankList"];
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data) {
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                Block_Exec(block,tempDic);
            } else {
                Block_Exec(block,nil);
            }
        }).failure(^(id error){
            Block_Exec(block,nil);
            [NotifyHelper showMessageWithMakeText:[error description]];
        })
        .execute();
    }];
}

#pragma mark - 点赞、取消点赞
+ (void)circlePraise:(NSDictionary *)param completion:(CompletionBlock)block {
    NSMutableDictionary *muParam = [NSMutableDictionary dictionaryWithDictionary:param];
    [muParam setValue:@"add" forKey:@"op_type"];
    [self praise:muParam completion:block];
}

+ (void)circleUnPraise:(NSDictionary *)param completion:(CompletionBlock)block {
    NSMutableDictionary *muParam = [NSMutableDictionary dictionaryWithDictionary:param];
    [muParam setValue:@"del" forKey:@"op_type"];
    [self praise:muParam completion:block];
}

+ (void)praise:(NSDictionary *)param completion:(CompletionBlock)block {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/circle/praise"];
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data) {
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                
                Block_Exec(block,tempDic);
            }
        }).failure(^(id error){
            Block_Exec(block,nil);
            [NotifyHelper showMessageWithMakeText:[error description]];
        })
        .execute();
    }];
}

+ (void)circleReward:(NSDictionary *)param completion:(CompletionBlock)block {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/circle/reward"];
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data) {
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                
                Block_Exec(block,tempDic);
            }else{
                [NotifyHelper showMessageWithMakeText:tempDic[@"msg"]];
            }
        }).failure(^(id error){
            Block_Exec(block,nil);
            [NotifyHelper showMessageWithMakeText:[error description]];
        })
        .execute();
    }];
}

+ (void)commentCircle:(NSString * _Nullable)optype
              content:(NSString * _Nullable)content
             circleId:(NSString * _Nullable)circleId
            commentId:(NSString * _Nullable)commentId
        commentUserId:(NSString * _Nullable)commentUserId
            extraInfo:(NSDictionary *)param
           completion:(CompletionBlock)block {
    
//    if(![WBStatusHelper hasPermission:nil]) {
//        return;
//    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/circle/comment"];
    
    NSMutableDictionary *muParam = [NSMutableDictionary dictionaryWithDictionary:param];
    [muParam setValue:optype forKey:@"op_type"];
    [muParam setValue:content forKey:@"content"];
    [muParam setValue:circleId forKey:@"circle_id"];
    [muParam setValue:commentId forKey:@"comment_id"];
    [muParam setValue:commentUserId forKey:@"comment_user_id"];
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(muParam)
        .finish(^(id data) {
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                Block_Exec(block,tempDic);
            } else {
                if([[data valueForKey:@"code"] integerValue] == 99) {
                    [WBStatusHelper showDisableAlert:nil];
                    return;
                }
                Block_Exec(block,nil);
            }
        }).failure(^(id error){
            Block_Exec(block,nil);
            [NotifyHelper showMessageWithMakeText:[error description]];
        })
        .execute();
    }];
}

///朋友圈详情，转发列表、评论列表、赞列表
+ (void)getCommentList:(NSString * _Nullable)circleId page:(NSString *)page completion:(CompletionBlock)block {
    [self detailList:circleId page:page type:1 completion:block];
}

+ (void)getPraiseInfoList:(NSString * _Nullable)circleId page:(NSString *)page completion:(CompletionBlock)block {
    [self detailList:circleId page:page type:2 completion:block];
}

+ (void)getTransCircleInfoList:(NSString * _Nullable)circleId page:(NSString *)page completion:(CompletionBlock)block {
    [self detailList:circleId page:page type:0 completion:block];
}

+(void)detailList:(NSString * _Nullable)circleId page:(NSString *)page type:(NSInteger)type completion:(CompletionBlock)block {
    NSString *url = nil;
    switch (type) {
        case 0:
        {
            url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/circle/getTransCircleInfoList"];
        }
        break;
        case 1:
        {
            url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/circle/getCommentInfoList"];
        }
        break;
        case 2:
        {
            url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/circle/getPraiseInfoList"];
        }
        break;
        default:
            break;
    }
    
    if(!url) {
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
    [param setValue:page forKey:@"page"];
    [param setValue:circleId forKey:@"circle_id"];
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data) {
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                
                Block_Exec(block,tempDic);
            }
        }).failure(^(id error){
            Block_Exec(block,nil);
            [NotifyHelper showMessageWithMakeText:[error description]];
        })
        .execute();
    }];
}

+ (void)circleCare:(NSString * _Nullable)circleId completion:(CompletionBlock)block {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/circle/care"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
    [param setValue:circleId forKey:@"circle_id"];
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data) {
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                
                Block_Exec(block,tempDic);
            }
        }).failure(^(id error){
            Block_Exec(block,nil);
            [NotifyHelper showMessageWithMakeText:[error description]];
        })
        .execute();
    }];
}

+ (void)circleComplain:(NSString * _Nullable)circleId content:(NSString *)content completion:(CompletionBlock)block {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/circle/complain"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
    [param setValue:circleId forKey:@"circle_id"];
    [param setValue:content forKey:@"content"];
    [param setValue:@"1" forKey:@"type"];
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data) {
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                
                Block_Exec(block,tempDic);
            }
        }).failure(^(id error){
            Block_Exec(block,nil);
            //[NotifyHelper showMessageWithMakeText:[error description]];
        })
        .execute();
    }];
}

+ (void)circleComplain2:(NSString * _Nullable)circleId content:(NSString *)content completion:(CompletionBlock)block {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/circle/complain"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
    [param setValue:circleId forKey:@"circle_id"];
    [param setValue:@"2,3" forKey:@"content"];
    [param setValue:@"2" forKey:@"type"];
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data) {
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                
                Block_Exec(block,tempDic);
            }
        }).failure(^(id error){
            Block_Exec(block,nil);
            //[NotifyHelper showMessageWithMakeText:[error description]];
        })
        .execute();
    }];
}

///添加好友
+ (void)addFriend:(uint64_t)userid {
    FriendModel *friend = [[FriendModel alloc] init];
    friend.userid = [NSString stringWithFormat:@"%llu",userid];
    [FriendsManager addFriend:@{@"acceId":friend.userid,@"addType":@"1"} completion:^(id object, NSString *error) {
        if (object) {
            NSDictionary* dict = (NSDictionary*)object;
            NSInteger status = [dict[@"status"]integerValue];
            friend.followState = status;
            if (status == MoRelationshipTypeStranger) {
                NSInteger isverify = [dict[@"isverify"]integerValue];
                if (isverify == 1) {
                    [MXRouter openURL:@"lcwl://VerifyFriendVC" parameters:@{@"model":friend}];
                }
            }else if(status == MoRelationshipTypeMyFriend){
//                [[LcwlChat shareInstance].chatManager insertFriends:@[friend]];
                //已经是好友了
                
                NSString* tip = [NSString stringWithFormat:@"您已添加了%@，可以开始聊天了",friend.name];
//                [ChatSendHelper sendChat:tip from:friend.userid messageType:kMxmessageTypeCustom type:eConversationTypeChat];
            }
        }
    }];
}

+ (void)getCircleDetail:(NSString * _Nullable)circleId completion:(CompletionBlock)block {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot2,@"api/chat/circle/getCircleDetail"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
    [param setValue:circleId forKey:@"circle_id"];
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data) {
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                Block_Exec(block,tempDic);
            }
        }).failure(^(id error){
            Block_Exec(block,nil);
            [NotifyHelper showMessageWithMakeText:[error description]];
        })
        .execute();
    }];
}
@end
