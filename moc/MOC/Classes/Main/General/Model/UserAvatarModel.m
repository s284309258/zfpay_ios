//
//  UserAvatarModel.m
//  MoPal_Developer
//
//  Created by aken on 15/3/12.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "UserAvatarModel.h"
#import "CommonDefine.h"

@implementation UserAvatarModel

#pragma mark - 通过字典将数据转换成model
- (void)dictionaryToModel:(NSDictionary *)dic {
//    @onExit {
//        [self checkPropertyAndSetDefaultValue];
//    };
    self.uId = [StringUtil isEmpty:[NSString stringWithFormat:@"%@",dic[@"id"]]]?@"":[NSString stringWithFormat:@"%@",dic[@"id"]];
    self.avatarUrl = [StringUtil isEmpty:[NSString stringWithFormat:@"%@",dic[@"avatarUrl"]]]?@"":[NSString stringWithFormat:@"%@",dic[@"avatarUrl"]];
    self.avatarUrl = self.avatarUrl;
    self.seq = [StringUtil isEmpty:[NSString stringWithFormat:@"%@",dic[@"seq"]]]?@"":[NSString stringWithFormat:@"%@",dic[@"seq"]];
    self.defaultAvatar= [dic[@"isAvatar"] boolValue];
}

@end
