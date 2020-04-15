//
//  SCRequestHelper.h
//  Lcwl
//
//  Created by mac on 2018/12/25.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCRequestHelper : NSObject
///用户发朋友圈、删除朋友
+ (void)circleAddNew:(NSDictionary *)param completion:(CompletionBlock)block;
+ (void)circleDelete:(NSDictionary *)param completion:(CompletionBlock)block;
+ (void)circleForward:(NSDictionary *)param completion:(CompletionBlock)block;

///获取推荐列表
+ (void)circleRecommandList:(NSDictionary *)param completion:(CompletionBlock)block;
///获取关注列表
+ (void)circleCareList:(NSDictionary *)param completion:(CompletionBlock)block;
///获取个人列表
+ (void)circlePersonalList:(NSDictionary *)param completion:(CompletionBlock)block;
///查询前一天的人气朋友圈,type: 1-点赞 2-打赏,circle:获取的最后一条朋友圈ID
+ (void)getCircleYesterdayRankList:(NSDictionary *)param completion:(CompletionBlock)block;

///点赞、取消点赞
+ (void)circlePraise:(NSDictionary *)param completion:(CompletionBlock)block;
+ (void)circleUnPraise:(NSDictionary *)param completion:(CompletionBlock)block;

///用户打赏
+ (void)circleReward:(NSDictionary *)param completion:(CompletionBlock)block;

///用户评论、回复评论、删除评论
+ (void)commentCircle:(NSString * _Nullable)optype
              content:(NSString * _Nullable)content
             circleId:(NSString * _Nullable)circleId
            commentId:(NSString * _Nullable)commentId
        commentUserId:(NSString * _Nullable)commentUserId
            extraInfo:(NSDictionary *)param
           completion:(CompletionBlock)block;

+ (void)getCommentList:(NSString * _Nullable)circleId page:(NSString *)page completion:(CompletionBlock)block;
+ (void)getPraiseInfoList:(NSString * _Nullable)circleId page:(NSString *)page completion:(CompletionBlock)block;
+ (void)getTransCircleInfoList:(NSString * _Nullable)circleId page:(NSString *)page completion:(CompletionBlock)block;

+ (void)circleCare:(NSString * _Nullable)circleId completion:(CompletionBlock)block;
+ (void)circleComplain:(NSString * _Nullable)circleId content:(NSString *)content completion:(CompletionBlock)block;
+ (void)circleComplain2:(NSString * _Nullable)circleId content:(NSString *)content completion:(CompletionBlock)block;
+ (void)addFriend:(uint64_t)userid;

+ (void)getCircleDetail:(NSString * _Nullable)circleId completion:(CompletionBlock)block;
@end

NS_ASSUME_NONNULL_END
