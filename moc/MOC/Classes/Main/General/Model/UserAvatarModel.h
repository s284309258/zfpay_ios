//
//  UserAvatarModel.h
//  MoPal_Developer
//
//  用户头像对象
//  Created by aken on 15/3/12.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "ModelProtocol.h"
#import "BaseObject.h"

@interface UserAvatarModel : BaseObject<ModelProtocol>

// 图片Id
@property (nonatomic ,strong) NSString* uId;

// 图片网络地址
@property (nonatomic ,strong) NSString* avatarUrl;

// 图片描述
@property (nonatomic ,strong) NSString* seq;

// 是否为默认头像
@property (nonatomic) BOOL defaultAvatar;

@end
