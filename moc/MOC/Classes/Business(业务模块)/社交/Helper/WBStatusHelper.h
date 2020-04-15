//
//  WBFeedHelper.h
//  YYKitExample
//
//  Created by ibireme on 15/9/5.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import "YYKit.h"
#import "WBModel.h"


@class WBStatusLayout;

@interface WBStatusHelper : NSObject

/// 微博图片资源 bundle
+ (NSBundle *)bundle;

/// 微博表情资源 bundle
+ (NSBundle *)emoticonBundle;

/// 微博表情 Array<WBEmotionGroup> (实际应该做成动态更新的)
+ (NSArray<WBEmoticonGroup *> *)emoticonGroups;

/// 微博图片 cache
+ (YYMemoryCache *)imageCache;

/// 从微博 bundle 里获取图片 (有缓存)
+ (UIImage *)imageNamed:(NSString *)name;

/// 从path创建图片 (有缓存)
+ (UIImage *)imageWithPath:(NSString *)path;

/// 圆角头像的 manager
+ (YYWebImageManager *)avatarImageManager;

/// 将 date 格式化成微博的友好显示
+ (NSString *)stringWithTimelineDate:(NSDate *)date;

/// 将微博API提供的图片URL转换成可用的实际URL
+ (NSURL *)defaultURLForImageURL:(id)imageURL;

/// 缩短数量描述，例如 51234 -> 5万
+ (NSString *)shortedNumberDesc:(NSUInteger)number;

/// At正则 例如 @王思聪
+ (NSRegularExpression *)regexAt;

/// 话题正则 例如 #暖暖环游世界#
+ (NSRegularExpression *)regexTopic;

/// 表情正则 例如 [偷笑]
+ (NSRegularExpression *)regexEmoticon;

/// 表情字典 key:[偷笑] value:ImagePath
+ (NSDictionary *)emoticonDic;

+ (WBCommentItem *)commentItem:(NSDictionary *)dic;

///更新点赞数据
+ (void)appendPraise:(WBStatusLayout *)layout dic:(NSDictionary *)dic;
+ (void)removePraise:(WBStatusLayout *)layout praiseId:(NSString *)praiseId;

///更新评论数据
+ (void)appendComment:(WBStatusLayout *)layout dic:(NSDictionary *)dic;
+ (void)removeComment:(WBStatusLayout *)layout dic:(NSDictionary *)dic;

///更新转发数额
+ (void)appendTransfer:(WBStatusLayout *)layout;
+ (void)removeTransfer:(WBStatusLayout *)layout;

///更新打赏数额
+ (void)appendAward:(WBStatusLayout *)layout;

///解析朋友圈列表
+ (NSArray *)modelsForDic:(NSArray *)data;
///解析单条朋友圈
+ (WBStatus *)modelForDic:(NSDictionary *)dic;

+ (BOOL)hasPermission:(__weak UIViewController *)superSelf;
+ (void)showDisableAlert:(__weak UIViewController *)superSelf;
@end
