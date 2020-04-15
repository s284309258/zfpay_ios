//
//  EnumDefine.h
//  MoPal_Developer
//
//  Created by Fly on 15/10/30.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#ifndef EnumDefine_h
#define EnumDefine_h

//1男、2女、3为男女 4未设置
typedef NS_ENUM(NSInteger, MoGenderType){
    MoGenderTypeMale    = 1,//男
    MoGenderTypeFemale  = 2,//女
    MoGenderTypeAll     = 3,//查询时使用，如果男女都查询请传3
    MoGenderTypeUnknow  = 4,//
};

//对当前登录用户关系类型
typedef NS_ENUM(NSInteger, MoRelationshipType){
    MoRelationshipTypeNone        = 0,// 未注册
    MoRelationshipTypeStranger    = 1,// 陌生人
    MoRelationshipTypeBlack       = 2,// 我的朋友
    MoRelationshipTypeMyFriend    = 3,// 好友
};


typedef NS_ENUM(NSUInteger, TopicDispalyType) {
    TopicDispalyTypeChoice = 1,//为精选话题，需要显示topicName 和 topicDesc 1表示显示
    TopicDispalyTypeCustom = 2,//用户自定义的话题
};
#endif /* EnumDefine_h */
