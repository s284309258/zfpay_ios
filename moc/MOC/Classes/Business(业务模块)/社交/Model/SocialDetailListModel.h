//
//  SocialDetailListModel.h
//  Lcwl
//  详情页转发列表、评论列表、赞列表model
//  Created by mac on 2018/12/28.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SocialDetailListModel : NSObject
@property (nonatomic, assign) NSInteger send_time;
@property (nonatomic, copy)   NSString *content;
@property (nonatomic, copy)   NSString *cre_date;
@property (nonatomic, copy)   NSString *user_head_photo;
@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, copy)   NSString *cre_time;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, copy)   NSString *user_name;
///转发列表的circle_id是进详情的circle_id，而评论列表的circle_id就是头部的circle_id
@property (nonatomic, assign) NSInteger circle_id;
@property (nonatomic, assign) NSInteger comment_id;
@property (nonatomic, copy) NSString *comment_user_name;
@end

NS_ASSUME_NONNULL_END
