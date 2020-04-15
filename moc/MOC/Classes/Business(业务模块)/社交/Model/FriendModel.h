//
//  NearByFriendModel.h
//  MoPal_Developer
//
//  Created by fred on 15/5/30.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "BaseObject.h"

@interface FriendModel : BaseObject

//用户ID
@property (nonatomic, strong) NSString     *userid;
///非聊天模块的用户ID
@property (nonatomic, strong) NSString     *system_user_id;
//群号
@property (nonatomic, copy)   NSString     *groupid;
//名字
@property (nonatomic, copy) NSString     *name;

@property (nonatomic, copy) NSString     *email;
//电话号码
@property (nonatomic, copy) NSString     *phone;
//头像
@property (nonatomic, copy) NSString     *avatar;
//性别
@property (nonatomic, assign) MoGenderType gender;
//关系
@property (nonatomic, assign) MoRelationshipType    followState;
//群角色
@property (nonatomic, assign) NSInteger    roleType;
//群昵称
@property (nonatomic, copy) NSString     *groupNickname;
@property (nonatomic, copy) NSString     *circle_back_img;

@property (nonatomic, assign) NSInteger     black_id;


@property (nonatomic, strong) NSString     *distance;
@property (nonatomic, strong) NSString     *mood;
@property (nonatomic, strong) NSString     *age;
@property (nonatomic, strong) NSString     *fans;
@property (nonatomic, copy  ) NSString     *introduction;
//通讯录名称
@property (nonatomic, strong) NSString    *addressListName;
//该属性用于存储手机通讯录中多个联系方式
@property (nonatomic, strong) NSMutableArray    *phones;

// 隐藏年龄类型 获取好友详情时使用
@property (nonatomic ,assign) NSInteger birthdayItype;

@property (nonatomic, copy) NSString    *occupationId;
@property (nonatomic, copy) NSString    *homeTownCode;


@property (nonatomic, copy) NSString    *stars;
@property (nonatomic, copy) NSString    *stealStars;
@property (nonatomic, copy) NSString    *stealStarsTime;
@property (nonatomic, assign) BOOL      canSteal;

//game
@property (nonatomic, copy)   NSString *steal_num;
@property (nonatomic, copy)   NSString *star_steal_id;
@property (nonatomic, copy)   NSString *star_id;
@property (nonatomic, copy)   NSString *friend_id;
@property (nonatomic, copy)   NSString *steal_user_id;
@property (nonatomic, copy)   NSString *create_time;
//@property (nonatomic, copy)   NSString *user_id;
@property (nonatomic, copy)   NSString *user_name;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, copy)   NSString *head_photo;
@property (nonatomic, copy)   NSString *nick_name;

@property (nonatomic, copy) NSString    *energys;

@property (nonatomic) NSInteger   enable_top;

@property (nonatomic) NSInteger   enable_disturb;

@property (nonatomic, copy) NSString*   remark;
@property (nonatomic, copy) NSString*   smartName;
@property (nonatomic, copy) NSString*   sex;
@property (nonatomic, copy) NSString*   area;
//个人签名
@property (nonatomic ,copy) NSString* sign_name;


//置顶时间
@property (nonatomic, copy) NSString* lastUpdateTime;


+(id)initFriendModel:(NSDictionary *)dic;

+(id)initFriendModel2:(NSDictionary *)dic;

+(id)initMemberModel:(NSDictionary *)dic;

/// 首页交朋友
- (instancetype)initTopicFriend:(NSDictionary *)dict;


+ (NSArray *)dictionaryToModel:(NSDictionary *)dict;

@end
