//
//  SocialContactVC.h
//  Lcwl
//
//  Created by AlphaGO on 2018/11/15.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SocialContactVCDelegate<NSObject>
@optional
- (void)scrollViewDidScrollOffsetY:(CGFloat)offsetY;
@end

typedef NS_ENUM(NSInteger, SocialContactType) {
    ///推荐列表
    SocialContactTypeRecommand = 0,
    ///好友列表
    SocialContactTypeCare = 1,
    ///个人朋友圈列表
    SocialContactTypePersonal = 2,
    ///人气朋友圈-点赞
    SocialContactTypePraise = 3,
    ///人气朋友圈-打赏
    SocialContactTypeReward = 4
};

@interface SocialContactVC : BaseViewController
@property (nonatomic, copy) NSString *otherId;
@property (nonatomic, assign) SocialContactType type;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) UIViewController *superMainVC;
///用于成功发布朋友圈后插入到第一行
- (void)inserNewData:(NSDictionary *)item;
@end

NS_ASSUME_NONNULL_END
