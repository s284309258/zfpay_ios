//
//  WBFeedHelper.m
//  YYKitExample
//
//  Created by ibireme on 15/9/5.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import "WBStatusHelper.h"
#import "WBStatusLayout.h"
#import "QNManager.h"
#import "UIAlertController+Blocks.h"
#import "PersonalDetailModel.h"

@implementation WBStatusHelper

+ (NSBundle *)bundle {
    static NSBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ResourceWeibo" ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:path];
    });
    return bundle;
}

+ (NSBundle *)emoticonBundle {
    static NSBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"EmoticonWeibo" ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:bundlePath];
    });
    return bundle;
}

+ (YYMemoryCache *)imageCache {
    static YYMemoryCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [YYMemoryCache new];
        cache.shouldRemoveAllObjectsOnMemoryWarning = NO;
        cache.shouldRemoveAllObjectsWhenEnteringBackground = NO;
        cache.name = @"WeiboImageCache";
    });
    return cache;
}

+ (UIImage *)imageNamed:(NSString *)name {
    if (!name) return nil;
    UIImage *image = [[self imageCache] objectForKey:name];
    if (image) return image;
    NSString *ext = name.pathExtension;
    if (ext.length == 0) ext = @"png";
    NSString *path = [[self bundle] pathForScaledResource:name ofType:ext];
    if (!path) {
        return [UIImage imageNamed:name];
    }
    image = [UIImage imageWithContentsOfFile:path];
    image = [image imageByDecoded];
    if (!image) return nil;
    [[self imageCache] setObject:image forKey:name];
    return image;
}

+ (UIImage *)imageWithPath:(NSString *)path {
    if (!path) return nil;
    UIImage *image = [[self imageCache] objectForKey:path];
    if (image) return image;
    if (path.pathScale == 1) {
        // 查找 @2x @3x 的图片
        NSArray *scales = [NSBundle preferredScales];
        for (NSNumber *scale in scales) {
            image = [UIImage imageWithContentsOfFile:[path stringByAppendingPathScale:scale.floatValue]];
            if (image) break;
        }
    } else {
        image = [UIImage imageWithContentsOfFile:path];
    }
    if (image) {
        image = [image imageByDecoded];
        [[self imageCache] setObject:image forKey:path];
    }
    return image;
}

+ (YYWebImageManager *)avatarImageManager {
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"weibo.avatar"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        manager.sharedTransformBlock = ^(UIImage *image, NSURL *url) {
            if (!image) return image;
            return [image imageByRoundCornerRadius:5]; // a large value
        };
    });
    return manager;
}

+ (NSString *)stringWithTimelineDate:(NSDate *)date {
    if (!date) return @"";
    
    static NSDateFormatter *formatterYesterday;
    static NSDateFormatter *formatterSameYear;
    static NSDateFormatter *formatterFullDate;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatterYesterday = [[NSDateFormatter alloc] init];
        [formatterYesterday setDateFormat:@"昨天 HH:mm"];
        [formatterYesterday setLocale:[NSLocale currentLocale]];
        
        formatterSameYear = [[NSDateFormatter alloc] init];
        [formatterSameYear setDateFormat:@"M-d"];
        [formatterSameYear setLocale:[NSLocale currentLocale]];
        
        formatterFullDate = [[NSDateFormatter alloc] init];
        [formatterFullDate setDateFormat:@"yy-M-dd"];
        [formatterFullDate setLocale:[NSLocale currentLocale]];
    });
    
    NSDate *now = [NSDate new];
    NSTimeInterval delta = now.timeIntervalSince1970 - date.timeIntervalSince1970;
    if (delta < -60 * 10) { // 本地时间有问题
        return [formatterFullDate stringFromDate:date];
    } else if (delta < 60 * 10) { // 10分钟内
        return @"刚刚";
    } else if (delta < 60 * 60) { // 1小时内
        return [NSString stringWithFormat:@"%d分钟前", (int)(delta / 60.0)];
    } else if (date.isToday) {
        return [NSString stringWithFormat:@"%d小时前", (int)(delta / 60.0 / 60.0)];
    } else if (date.isYesterday) {
        return [formatterYesterday stringFromDate:date];
    } else if (date.year == now.year) {
        return [formatterSameYear stringFromDate:date];
    } else {
        return [formatterFullDate stringFromDate:date];
    }
}

+ (NSURL *)defaultURLForImageURL:(id)imageURL {
    /*
     微博 API 提供的图片 URL 有时并不能直接用，需要做一些字符串替换：
     http://u1.sinaimg.cn/upload/2014/11/04/common_icon_membership_level6.png //input
     http://u1.sinaimg.cn/upload/2014/11/04/common_icon_membership_level6_default.png //output
     
     http://img.t.sinajs.cn/t6/skin/public/feed_cover/star_003_y.png?version=2015080302 //input
     http://img.t.sinajs.cn/t6/skin/public/feed_cover/star_003_os7.png?version=2015080302 //output
     */
    
    if (!imageURL) return nil;
    NSString *link = nil;
    if ([imageURL isKindOfClass:[NSURL class]]) {
        link = ((NSURL *)imageURL).absoluteString;
    } else if ([imageURL isKindOfClass:[NSString class]]) {
        link = imageURL;
    }
    if (link.length == 0) return nil;
    
    if ([link hasSuffix:@".png"]) {
        // add "_default"
        if (![link hasSuffix:@"_default.png"]) {
            NSString *sub = [link substringToIndex:link.length - 4];
            link = [sub stringByAppendingFormat:@"_default.png"];
        }
    } else {
        // replace "_y.png" with "_os7.png"
        NSRange range = [link rangeOfString:@"_y.png?version"];
        if (range.location != NSNotFound) {
            NSMutableString *mutable = link.mutableCopy;
            [mutable replaceCharactersInRange:NSMakeRange(range.location + 1, 1) withString:@"os7"];
            link = mutable;
        }
    }
    
    return [NSURL URLWithString:link];
}

+ (NSString *)shortedNumberDesc:(NSUInteger)number {
    // should be localized
    if (number <= 9999) return [NSString stringWithFormat:@"%d", (int)number];
    if (number <= 9999999) return [NSString stringWithFormat:@"%d万", (int)(number / 10000)];
    return [NSString stringWithFormat:@"%d千万", (int)(number / 10000000)];
}

+ (NSRegularExpression *)regexAt {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 微博的 At 只允许 英文数字下划线连字符，和 unicode 4E00~9FA5 范围内的中文字符，这里保持和微博一致。。
        // 目前中文字符范围比这个大
        regex = [NSRegularExpression regularExpressionWithPattern:@"@[-_a-zA-Z0-9\u4E00-\u9FA5]+" options:kNilOptions error:NULL];
    });
    return regex;
}

+ (NSRegularExpression *)regexTopic {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"#[^@#]+?#" options:kNilOptions error:NULL];
    });
    return regex;
}

+ (NSRegularExpression *)regexEmoticon {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"\\[[^ \\[\\]]+?\\]" options:kNilOptions error:NULL];
    });
    return regex;
}

+ (NSDictionary *)emoticonDic {
    static NSMutableDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *emoticonBundlePath = [[NSBundle mainBundle] pathForResource:@"EmoticonWeibo" ofType:@"bundle"];
        dic = [self _emoticonDicFromPath:emoticonBundlePath];
    });
    return dic;
}

+ (NSMutableDictionary *)_emoticonDicFromPath:(NSString *)path {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    WBEmoticonGroup *group = nil;
    NSString *jsonPath = [path stringByAppendingPathComponent:@"info.json"];
    NSData *json = [NSData dataWithContentsOfFile:jsonPath];
    if (json.length) {
        group = [WBEmoticonGroup modelWithJSON:json];
    }
    if (!group) {
        NSString *plistPath = [path stringByAppendingPathComponent:@"info.plist"];
        NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        if (plist.count) {
            group = [WBEmoticonGroup modelWithJSON:plist];
        }
    }
    for (WBEmoticon *emoticon in group.emoticons) {
        if (emoticon.png.length == 0) continue;
        NSString *pngPath = [path stringByAppendingPathComponent:emoticon.png];
        if (emoticon.chs) dic[emoticon.chs] = pngPath;
        if (emoticon.cht) dic[emoticon.cht] = pngPath;
    }
    
    NSArray *folders = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    for (NSString *folder in folders) {
        if (folder.length == 0) continue;
        NSDictionary *subDic = [self _emoticonDicFromPath:[path stringByAppendingPathComponent:folder]];
        if (subDic) {
            [dic addEntriesFromDictionary:subDic];
        }
    }
    return dic;
}

+ (NSArray<WBEmoticonGroup *> *)emoticonGroups {
    static NSMutableArray *groups;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *emoticonBundlePath = [[NSBundle mainBundle] pathForResource:@"EmoticonWeibo" ofType:@"bundle"];
        NSString *emoticonPlistPath = [emoticonBundlePath stringByAppendingPathComponent:@"emoticons.plist"];
        NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:emoticonPlistPath];
        NSArray *packages = plist[@"packages"];
        groups = (NSMutableArray *)[NSArray modelArrayWithClass:[WBEmoticonGroup class] json:packages];
        
        NSMutableDictionary *groupDic = [NSMutableDictionary new];
        for (int i = 0, max = (int)groups.count; i < max; i++) {
            WBEmoticonGroup *group = groups[i];
            if (group.groupID.length == 0) {
                [groups removeObjectAtIndex:i];
                i--;
                max--;
                continue;
            }
            NSString *path = [emoticonBundlePath stringByAppendingPathComponent:group.groupID];
            NSString *infoPlistPath = [path stringByAppendingPathComponent:@"info.plist"];
            NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:infoPlistPath];
            [group modelSetWithDictionary:info];
            if (group.emoticons.count == 0) {
                i--;
                max--;
                continue;
            }
            groupDic[group.groupID] = group;
        }
        
        NSArray<NSString *> *additionals = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[emoticonBundlePath stringByAppendingPathComponent:@"additional"] error:nil];
        for (NSString *path in additionals) {
            WBEmoticonGroup *group = groupDic[path];
            if (!group) continue;
            NSString *infoJSONPath = [[[emoticonBundlePath stringByAppendingPathComponent:@"additional"] stringByAppendingPathComponent:path] stringByAppendingPathComponent:@"info.json"];
            NSData *infoJSON = [NSData dataWithContentsOfFile:infoJSONPath];
            WBEmoticonGroup *addGroup = [WBEmoticonGroup modelWithJSON:infoJSON];
            if (addGroup.emoticons.count) {
                for (WBEmoticon *emoticon in addGroup.emoticons) {
                    emoticon.group = group;
                }
                [((NSMutableArray *)group.emoticons) insertObjects:addGroup.emoticons atIndex:0];
            }
        }
    });
    return groups;
}

+ (WBUser *)userModel:(NSDictionary *)dic {
    WBUser *user = [[WBUser alloc] init];
    user.userID = [[dic valueForKey:@"circle_user_id"] integerValue];
    user.name = [dic valueForKey:@"circle_user_name"];
    user.remark = [dic valueForKey:@"circle_user_remark"];
    NSString *headeUrl = [dic valueForKey:@"circle_user_head_photo"];
    user.profileImageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://jiasu.wzftop.com/%@",AssignSize(headeUrl, 40, 40)]];//[NSURL URLWithString:AssignSize(headeUrl, 40, 40)];
    user.avatarHD = user.profileImageURL;
    user.avatarLarge = user.profileImageURL;
    return user;
}

+ (WBUser *)transUserModel:(NSDictionary *)dic {
    WBUser *transUser = [[WBUser alloc] init];
    transUser.userID = [[dic valueForKey:@"trans_user_id"] integerValue];
    transUser.name = [dic valueForKey:@"trans_user_name"];
    transUser.remark = [dic valueForKey:@"trans_user_remark"];
    transUser.profileImageURL = [NSURL URLWithString:[dic valueForKey:@"trans_user_head_photo"]];
    transUser.avatarHD = transUser.profileImageURL;
    transUser.avatarLarge = transUser.profileImageURL;
    return transUser;
}

+ (NSArray *)commentArr:(NSDictionary *)commentDic {
    NSMutableArray *commentArr = [NSMutableArray arrayWithCapacity:1];
    for(NSDictionary *dic in commentDic) {
        [commentArr addObject:[self commentItem:dic]];
    }
    return commentArr;
}

+ (WBCommentItem *)commentItem:(NSDictionary *)dic {
    WBCommentItem *commentItem = [[WBCommentItem alloc] init];
    commentItem._id = [dic valueForKey:@"id"] ? [NSString stringWithFormat:@"%@",[dic valueForKey:@"id"]] : nil;
    commentItem.user_id = [dic valueForKey:@"user_id"] ? [NSString stringWithFormat:@"%@",[dic valueForKey:@"user_id"]] : nil;
    commentItem.user_name = [dic valueForKey:@"user_name"];
    commentItem.user_head_photo = [dic valueForKey:@"user_head_photo"];
    commentItem.content = [dic valueForKey:@"content"];
    commentItem.circle_id = [NSString stringWithFormat:@"%@",@([[dic valueForKey:@"circle_id"] integerValue])];
    commentItem.comment_id = [dic valueForKey:@"comment_id"] ? [NSString stringWithFormat:@"%@",[dic valueForKey:@"comment_id"]] : nil;
    commentItem.comment_user_id = [dic valueForKey:@"comment_user_id"] ? [NSString stringWithFormat:@"%@",[dic valueForKey:@"comment_user_id"]] : nil;
    commentItem.comment_user_name = [dic valueForKey:@"comment_user_name"] ? [NSString stringWithFormat:@"%@",[dic valueForKey:@"comment_user_name"]] : nil;
    commentItem.comment_user_head_photo = [dic valueForKey:@"comment_user_head_photo"];
    commentItem.token_user = [dic valueForKey:@"token_user"];
    return commentItem;
}

+ (void)appendPraise:(WBStatusLayout *)layout dic:(NSDictionary *)dic {
    if(dic == nil) {
        return;
    }
    
    NSArray *resultArr = [self praiseArr:@[dic]];
    if(layout.status.praise_info_list == nil) {
        layout.status.praise_info_list = [NSMutableArray arrayWithCapacity:1];
    }
    [layout.status.praise_info_list safeAddObj:resultArr.firstObject];
    layout.status.attitudesCount += 1;
    [layout layout];
}

+ (void)removePraise:(WBStatusLayout *)layout praiseId:(NSString *)praiseId {
    if(praiseId == nil) {
        return;
    }
    
    __block NSInteger index = -1;
    [layout.status.praise_info_list enumerateObjectsUsingBlock:^(PraiseItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj._id isEqualToString:praiseId]) {
            index = idx;
        }
    }];

    if(index < 0) {
        return;
    }
    [layout.status.praise_info_list safeRemoveObjectAtIndex:index];
    layout.status.attitudesCount -= 1;
    [layout layout];
}

+ (void)appendComment:(WBStatusLayout *)layout dic:(NSDictionary *)dic {
    if(dic == nil) {
        return;
    }
    
    if(layout.status.comment_info_list.count < 4) { //列表中插入评论
        WBCommentItem *item = [self commentItem:dic];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:layout.status.comment_info_list];
        [arr addObject:item];
        layout.status.comment_info_list = [arr copy];
        //layout.status.commentsCount = (int32_t)layout.status.comment_info_list.count;
    }
    layout.status.commentsCount += 1;
    [layout layout];
}

+ (void)removeComment:(WBStatusLayout *)layout dic:(NSDictionary *)dic {
    if(dic == nil) {
        return;
    }
    
    __block NSInteger index = -1;
    [layout.status.comment_info_list enumerateObjectsUsingBlock:^(WBCommentItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj._id isEqualToString:[dic valueForKey:@"id"]]) {
            index = idx;
            *stop = YES;
        }
    }];
    
    if(index >= 0) {
        layout.status.commentsCount -= 1;
        NSMutableArray *tempArr = [layout.status.comment_info_list mutableCopy];
        [tempArr safeRemoveObjectAtIndex:index];
        layout.status.comment_info_list = [tempArr copy];
        [layout layout];
    }
}

+ (void)appendTransfer:(WBStatusLayout *)layout {
    layout.status.repostsCount += 1;
    [layout layout];
}

+ (void)removeTransfer:(WBStatusLayout *)layout {
    layout.status.repostsCount -= 1;
    [layout layout];
}

+ (void)appendAward:(WBStatusLayout *)layout {
    layout.status.awardCount += 1;
    [layout layout];
}

+ (NSArray *)praiseArr:(NSArray *)array {
    NSMutableArray *praiseArr = [NSMutableArray arrayWithCapacity:1];
    for(NSDictionary *dic in array) {
        PraiseItem *praiseItem = [[PraiseItem alloc] init];
        praiseItem._id = [dic valueForKey:@"id"];
        praiseItem.send_time = [dic valueForKey:@"send_time"];
        praiseItem.cre_date = [dic valueForKey:@"cre_date"];
        praiseItem.cre_time = [dic valueForKey:@"cre_time"];
        praiseItem.user_id = [dic valueForKey:@"user_id"];
        praiseItem.user_name = [dic valueForKey:@"user_name"];
        praiseItem.token_user = [dic valueForKey:@"token_user"];
        [praiseArr addObject:praiseItem];
    }
    return praiseArr;
}

+ (NSArray<WBPicture *> *)imageArr:(NSDictionary *)dic {
    NSString *linkStr = [dic valueForKey:@"circle_link"];
    if(linkStr.length <= 0) {
        return nil;
    }
    
    NSString *imageSizeStr = ([[dic valueForKey:@"circle_send_type"] isEqualToString:@"00"] ? [dic valueForKey:@"circle_image_type"] : [dic valueForKey:@"trans_image_type"]);//[[dic valueForKey:@"trans_image_type"] componentsSeparatedByString:@","];
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:1];
    [[linkStr componentsSeparatedByString:@","] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WBPicture *picture = [[WBPicture alloc] init];
        WBPictureMetadata *meta = [[WBPictureMetadata alloc] init];
        meta.url = [NSURL URLWithString:[NSString stringWithFormat:@"http://jiasu.wzftop.com/%@",obj]];
        
        
        NSArray *typeInfoArr = [imageSizeStr componentsSeparatedByString:@","];
        NSArray *imageInfo = [[typeInfoArr safeObjectAtIndex:idx] componentsSeparatedByString:@"|"];
        
        NSString *type = [imageInfo firstObject]; //0-静态图 1-动态图 2-视频
        NSString *suffix = [imageInfo lastObject];
        NSString *size = [imageInfo safeObjectAtIndex:1];
        
        meta.type = [meta.url pathExtension];
        meta.type = [StringUtil isEmpty:meta.type] ? suffix : meta.type;
        
        meta.width = [[[size componentsSeparatedByString:@"x"] firstObject] intValue];
        meta.height = [[[size componentsSeparatedByString:@"x"] lastObject] intValue];
        
        /// 图片标记
        if([type integerValue] == 0) { //静态图
            if (meta.width > 0 && (float)meta.height / meta.width > 3) {
                meta.badgeType = WBPictureBadgeTypeLong;
            } else {
                meta.badgeType = WBPictureBadgeTypeNone;
            }
        } else if([type integerValue] == 1) { //gif图
            meta.badgeType = WBPictureBadgeTypeGIF;
        } else {
            meta.badgeType = WBPictureBadgeTypeNone;
        }
        
        //meta.type = @"GIF";
        picture.bmiddle = meta;
        picture.largest = meta;
        [imageArr addObject:picture];
    }];
    return imageArr;
}

///视频部分
+ (WBPageInfo *)pageInfo:(NSDictionary *)dic {
    
    NSString *url = nil;
    
    WBPageInfo *info = [[WBPageInfo alloc] init];
    info.objectType = @"video";
    if([[dic valueForKey:@"circle_send_type"] isEqualToString:@"00"]) {
        url = [dic valueForKey:@"circle_link"];
        info.type = [[[[dic valueForKey:@"circle_image_type"] componentsSeparatedByString:@"|"] firstObject] intValue];
    } else {
        url = [dic valueForKey:@"trans_link"];
        info.type = [[[[dic valueForKey:@"trans_image_type"] componentsSeparatedByString:@"|"] firstObject] intValue];
    }
    NSString *videoScreenshot = VideoFirstScreenShot(url);
    info.pagePic = [NSURL URLWithString:videoScreenshot];
    NSMutableDictionary *mediaInfo = [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *fixUrl = [WBStatusHelper addHostForVideoUrl:url];
    [mediaInfo setValue:fixUrl forKey:@"mp4_hd_url"];
    [mediaInfo setValue:fixUrl forKey:@"mp4_sd_url"];
    info.mediaInfo = mediaInfo;
    return info;
}

+ (NSString *)addHostForVideoUrl:(NSString *)url {
    NSURL *fixUrl = [NSURL URLWithString:url];
    if(fixUrl.host.length == 0) {
        return [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,url];
    } else {
        return url;
    }
}

+ (WBStatus *)transInfoModel:(NSDictionary *)dic {
    if([[dic valueForKey:@"circle_send_type"] isEqualToString:@"01"]) {
        NSMutableDictionary *picParam = [NSMutableDictionary dictionaryWithCapacity:1];
        [picParam setValue:[dic valueForKey:@"trans_link"] forKey:@"circle_link"];
        [picParam setValue:[dic valueForKey:@"trans_image_type"] forKey:@"trans_image_type"];
        WBStatus *retweetStatus = [[WBStatus alloc] init];
        retweetStatus.pics = [self imageArr:picParam];
        
        retweetStatus.trans_user_id = [dic valueForKey:@"trans_user_id"];
        retweetStatus.trans_user_name = [dic valueForKey:@"trans_user_name"];
        retweetStatus.trans_user_remark = [dic valueForKey:@"trans_user_remark"];
        retweetStatus.trans_user_head_photo = [dic valueForKey:@"trans_user_head_photo"];
        retweetStatus.trans_content = [dic valueForKey:@"trans_content"];
        retweetStatus.trans_link = [dic valueForKey:@"trans_link"];
        retweetStatus.trans_message_type = [dic valueForKey:@"trans_message_type"];
        
        retweetStatus.pageInfo = [self pageInfo:dic];
        return retweetStatus;
    } else {
        return nil;
    }
}

+ (WBStatus *)modelForDic:(NSDictionary *)dic {
    WBStatus *model = [[WBStatus alloc] init];
    model.circle_id = [NSString stringWithFormat:@"%@",@([[dic valueForKey:@"circle_id"] integerValue])];
    model.createdAt = [NSDate dateWithTimeIntervalSince1970:[[dic valueForKey:@"circle_send_time"] doubleValue]/1000.0];
    
//    NSString
//    [[[dic valueForKey:@"circle_link"] componentsSeparatedByString:@","] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [urls addObject:@""];
//    }];
    
    
    model.circle_link = [dic valueForKey:@"circle_link"];
    model.trans_link = [dic valueForKey:@"trans_link"];
    model.circle_user_addr = [dic valueForKey:@"circle_user_addr"];
    model.awardCount = [[dic valueForKey:@"reward_num"] intValue];
    model.pics = [self imageArr:dic];
    //init User
    model.user = [self userModel:dic];
    model.transUser = [self transUserModel:dic];
    
    //WBStatusTitle *title; ///< 标题栏 (通常为nil)
    
    model.text = [dic valueForKey:@"circle_content"];
    //        if([StringUtil isEmpty:model.text]) {
    //            model.text = @"\n";
    //        }
    
    //WBStatus *retweetedStatus; ///转发微博
    //NSArray<NSString *> *picIds;
    //NSDictionary<NSString *, WBPicture *> *picInfos;
    model.circle_send_type = [dic valueForKey:@"circle_send_type"];
    model.circle_image_type = [dic valueForKey:@"circle_image_type"];
    model.trans_image_type = [dic valueForKey:@"trans_image_type"];
    
    //视频url只会有一个
    NSString *circle_link = model.isTransfer ? model.trans_link : model.circle_link;
    if([[circle_link componentsSeparatedByString:@","] count] == 1 && model.circleFileType == 2) {
        
        
        WBStatus *retweetStatus = [[WBStatus alloc] init];
        retweetStatus.pageInfo = [self pageInfo:dic];
        model.retweetedStatus = retweetStatus;
        model.pageInfo = retweetStatus.pageInfo;
    } else {
        model.retweetedStatus = [self transInfoModel:dic];
        model.pageInfo = model.retweetedStatus.pageInfo;
    }
    
    model.repostsCount = [[dic valueForKey:@"circle_num"] intValue];
    model.commentsCount = [[dic valueForKey:@"comment_num"] intValue];
    model.attitudesCount = [[dic valueForKey:@"praise_num"] intValue];
    model.attitudesStatus = [dic valueForKey:@"praise_id"] ? 1 : 0;
    model.praise_id = [dic valueForKey:@"praise_id"];
    
    
    //NSArray *annotations; ///< 地理位置
    model.comment_info_list = [[self commentArr:[dic valueForKey:@"comment_info_list"]] mutableCopy];
    model.praise_info_list = [[self praiseArr:[dic valueForKey:@"praise_info_list"]] mutableCopy];
    return model;
}

+ (NSArray *)modelsForDic:(NSArray *)data {
    NSArray *deleteCirleIds = [[NSUserDefaults standardUserDefaults] objectForKey:@"deleteCirleIds"];
    NSMutableArray *modelsArr = [NSMutableArray arrayWithCapacity:1];
    for(NSDictionary *dic in data) {
        WBStatus *model = [self modelForDic:dic];
        
//        if(model.isTransfer) {
//            //WBStatus *m = [[WBStatus alloc] init];
//            //m.retweetedStatus = m;
//
//            //[modelsArr addObject:m];
//        }
        #ifdef OPEN_DISTRIBUTION
        if([AppDelegate isTestDistribution]) {
            if(deleteCirleIds && [deleteCirleIds containsObject:model.circle_id]) {
                continue;
            }
        }
        #endif
        
        [modelsArr addObject:model];
    }
    return modelsArr;
}

//+ (BOOL)hasPermission:(__weak UIViewController *)superSelf {
//    NSInteger bol = [LcwlChat shareInstance].user.is_circle;
//    if(bol == 0) {
//        [self showDisableAlert:superSelf];
//        return NO;
//    }
//    return YES;
//}

+ (void)showDisableAlert:(__weak UIViewController *)superSelf {
    [UIAlertController showAlertInViewController:(superSelf ?: [[MXRouter sharedInstance] getTopViewController]) withTitle:nil message:@"您已被多人投诉，已违反了礼常往来的朋友圈规则，暂时不能使用朋友圈功能。申诉请联系客服小助手。" cancelButtonTitle:@"确定" destructiveButtonTitle:nil otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        
    }];
}

/*
 weibo.app 里面的正则，有兴趣的可以参考下：
 
 HTTP链接 (例如 http://www.weibo.com ):
 ([hH]ttp[s]{0,1})://[a-zA-Z0-9\.\-]+\.([a-zA-Z]{2,4})(:\d+)?(/[a-zA-Z0-9\-~!@#$%^&*+?:_/=<>.',;]*)?
 ([hH]ttp[s]{0,1})://[a-zA-Z0-9\.\-]+\.([a-zA-Z]{2,4})(:\d+)?(/[a-zA-Z0-9\-~!@#$%^&*+?:_/=<>]*)?
 (?i)https?://[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+([-A-Z0-9a-z_\$\.\+!\*\(\)/,:;@&=\?~#%]*)*
 ^http?://[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+(\/[\w-. \/\?%@&+=\u4e00-\u9fa5]*)?$
 
 链接 (例如 www.baidu.com/s?wd=test ):
 ^[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+([-A-Z0-9a-z_\$\.\+!\*\(\)/,:;@&=\?~#%]*)*
 
 邮箱 (例如 sjobs@apple.com ):
 \b([a-zA-Z0-9%_.+\-]{1,32})@([a-zA-Z0-9.\-]+?\.[a-zA-Z]{2,6})\b
 \b([a-zA-Z0-9%_.+\-]+)@([a-zA-Z0-9.\-]+?\.[a-zA-Z]{2,6})\b
 ([a-zA-Z0-9%_.+\-]+)@([a-zA-Z0-9.\-]+?\.[a-zA-Z]{2,6})
 
 电话号码 (例如 18612345678):
 ^[1-9][0-9]{4,11}$
 
 At (例如 @王思聪 ):
 @([\x{4e00}-\x{9fa5}A-Za-z0-9_\-]+)
 
 话题 (例如 #奇葩说# ):
 #([^@]+?)#
 
 表情 (例如 [呵呵] ):
 \[([^ \[]*?)]
 
 匹配单个字符 (中英文数字下划线连字符)
 [\x{4e00}-\x{9fa5}A-Za-z0-9_\-]
 
 匹配回复 (例如 回复@王思聪: ):
 \x{56de}\x{590d}@([\x{4e00}-\x{9fa5}A-Za-z0-9_\-]+)(\x{0020}\x{7684}\x{8d5e})?:
 
 */

@end
