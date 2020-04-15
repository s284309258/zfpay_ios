//
//  PersonalDetailModel.m
//  Lcwl
//
//  Created by mac on 2018/12/10.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "PersonalDetailModel.h"

@implementation PersonalDetailModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.is_chat = 1;
        self.is_circle = 1;
    }
    return self;
}


- (id)initPersonalDetailModel:(NSDictionary *)dic
{
    self = [self init];
    if (self) {
//        @onExit {
//            [self checkPropertyAndSetDefaultValue];
//        };
        
        self.is_chat = 1;
        self.is_circle = 1;
        
        if ([dic objectForKey:@"id"])
            self.user_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        if ([dic objectForKey:@"user_name"])
            self.user_name = [dic objectForKey:@"user_name"];
        if ([dic objectForKey:@"user_no"])
            self.user_no = [dic objectForKey:@"user_no"];
        if ([dic objectForKey:@"user_tel"])
            self.user_tel = [dic objectForKey:@"user_tel"];
        if ([dic objectForKey:@"real_name"])
            self.real_name = [dic objectForKey:@"real_name"];
        if ([dic objectForKey:@"id_card"])
            self.id_card = [dic objectForKey:@"id_card"];
        if ([dic objectForKey:@"star_address"])
            self.star_address = [dic objectForKey:@"star_address"];
        if ([dic objectForKey:@"star_num"])
            self.star_num = [dic objectForKey:@"star_num"];
        if ([dic objectForKey:@"free_num"])
            self.free_num = [dic objectForKey:@"free_num"];
        if ([dic objectForKey:@"under_num"])
            self.under_num = [dic objectForKey:@"under_num"];
        if ([dic objectForKey:@"ykc_num"])
            self.ykc_num = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ykc_num"]];
        if ([dic objectForKey:@"head_photo"])
            self.head_photo = [dic objectForKey:@"head_photo"];
        if ([dic objectForKey:@"search_status"])
            self.search_status = [dic objectForKey:@"search_status"];
        if ([dic objectForKey:@"detail_status"])
            self.detail_status = [dic objectForKey:@"detail_status"];
        if ([dic objectForKey:@"referer_id"])
            self.referer_id = [dic objectForKey:@"referer_id"];
        if ([dic objectForKey:@"grade"])
            self.grade = [dic objectForKey:@"grade"];
        if ([dic objectForKey:@"sys_datetime"])
            self.sys_datetime = [dic objectForKey:@"sys_datetime"];
        if ([dic objectForKey:@"is_circle"])
            self.is_circle = [[dic objectForKey:@"is_circle"] integerValue];
        if ([dic objectForKey:@"is_chat"])
            self.is_chat = [[dic objectForKey:@"is_chat"] integerValue];
       

    }
    return self;
}

-(FriendModel* )toFriendModel{
    FriendModel* model = [[FriendModel alloc]init];
    model.userid = self.user_id;
    model.name = self.user_name;
    model.phone = self.user_tel;
    model.avatar = self.head_photo;
    model.followState = [self.status intValue];
    return model;
}

@end
