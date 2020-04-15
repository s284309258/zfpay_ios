//
//  PersonalDetailModel.h
//  Lcwl
//
//  Created by mac on 2018/12/10.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalDetailModel : NSObject
///用户ID
@property (nonatomic,strong) NSString *user_id;
///用户名（昵称）
@property (nonatomic,strong) NSString *user_name;
///用户礼常往来号
@property (nonatomic,strong) NSString *user_no;
///用户手机号码
@property (nonatomic,strong) NSString *user_tel;
///资料完善度
@property (nonatomic,strong) NSString *complete_rate;
///真实姓名
@property (nonatomic,strong) NSString *real_name;
///身份证号
@property (nonatomic,strong) NSString *id_card;
///星星链接地址
@property (nonatomic,strong) NSString *star_address;
///星星数量
@property (nonatomic,strong) NSString *star_num;
///冻结数量
@property (nonatomic,strong) NSString *free_num;
///能量数量
@property (nonatomic,strong) NSString *under_num;
///Ykc数量
@property (nonatomic,strong) NSString *ykc_num;
///头像
@property (nonatomic,strong) NSString *head_photo;
/// 允许搜索状态 0—不允许，1—允许
@property (nonatomic,strong) NSString *search_status;
///查看状态 1—所有人，2—仅好友，3—仅自己
@property (nonatomic,strong) NSString *detail_status;
///推荐人
@property (nonatomic,strong) NSString *referer_id;
///等级
@property (nonatomic,strong) NSString *grade;
///系统时间
@property (nonatomic,strong) NSString *sys_datetime;

//好友关系状态 当查看他人个人资料所带参数
//•1    需添加好友
//•2    需移除黑名单
//•3    已经是好友
@property (nonatomic,strong) NSString *status;

@property (nonatomic) NSInteger is_circle;

@property (nonatomic) NSInteger is_chat;

- (id)initPersonalDetailModel:(NSDictionary *)dic;

-(FriendModel* )toFriendModel;

@end

NS_ASSUME_NONNULL_END
