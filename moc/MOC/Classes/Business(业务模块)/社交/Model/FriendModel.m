//
//  NearByFriendModel.m
//  MoPal_Developer
//
//  Created by fred on 15/5/30.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "FriendModel.h"
#import "CommonDefine.h"
#import "MXCache.h"

@implementation FriendModel

-(instancetype)init{
    if (self = [super init]) {
        self.followState = MoRelationshipTypeNone;
    }
    return self;
}

+ (id)initFriendModel:(NSDictionary *)dic
{
    FriendModel* model  = [[FriendModel alloc]init];
    if ([dic objectForKey:@"user_id"])
        model.friend_id = [@([[dic objectForKey:@"user_id"] integerValue]) description];
    if ([dic objectForKey:@"friend_id"])
        model.userid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"friend_id"]];
    if ([dic objectForKey:@"sys_user_account"])
        model.name = [StringUtil isEmpty:[dic objectForKey:@"sys_user_account"]]?@"":[dic objectForKey:@"sys_user_account"];
    if ([dic objectForKey:@"userTel"])
        model.phone = [dic objectForKey:@"userTel"];
    if ([dic objectForKey:@"nick_name"])
        model.nick_name = [dic objectForKey:@"nick_name"];
    if ([dic objectForKey:@"system_user_id"])
        model.system_user_id = [@([[dic objectForKey:@"system_user_id"] integerValue]) description];
    if ([dic objectForKey:@"head_photo"])
         model.avatar = [dic objectForKey:@"head_photo"];
         model.head_photo = model.avatar;
    if ([dic objectForKey:@"status"]){
        if (([[dic objectForKey:@"isBlack"] boolValue])) {
            model.followState = 2;
        }else{
            model.followState = [[dic objectForKey:@"status"]intValue];
        }
    }
    if ([dic objectForKey:@"remark"])
        model.remark = [StringUtil isEmpty:[dic objectForKey:@"remark"]]?@"":[dic objectForKey:@"remark"];
    return model;
}

///可用于接口api/chat/frined/moblieImportFriend等返回的信息
+ (id)initFriendModel2:(NSDictionary *)dic
{
    FriendModel* model  = [[FriendModel alloc]init];
    model.phone = [dic objectForKey:@"user_tel"];
    model.userid = [@([[dic objectForKey:@"id"] integerValue]) description];
    model.name = [dic objectForKey:@"sys_user_account"];
    model.avatar = [dic objectForKey:@"head_photo"];
    model.nick_name = [dic objectForKey:@"nick_name"];
    model.followState = [[dic objectForKey:@"status"] integerValue];
    
    model.area = [dic objectForKey:@"area"];
    model.sex = [dic objectForKey:@"sex"];
    model.sign_name = [dic objectForKey:@"sign_name"];
    
    if (([[dic objectForKey:@"isBlack"] boolValue])) {
        model.followState = 2;
    } else {
        model.followState = [[dic objectForKey:@"status"]intValue];
    }
    model.remark = [dic objectForKey:@"remark"];
    model.circle_back_img = [dic objectForKey:@"circle_back_img"];
    return model;
}

+(id)initMemberModel:(NSDictionary *)dic{
    FriendModel* model  = [[FriendModel alloc]init];
    if ([dic objectForKey:@"user_id"])
        model.userid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"user_id"]];
    if ([dic objectForKey:@"group_nick_name"])
        model.groupNickname = [dic objectForKey:@"group_nick_name"];
    if ([dic objectForKey:@"userTel"])
        model.phone = [dic objectForKey:@"userTel"];
    if ([dic objectForKey:@"head_photo"])
        model.avatar = [dic objectForKey:@"head_photo"];
    if ([dic objectForKey:@"group_id"])
        model.groupid =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"group_id"]];
    if ([dic objectForKey:@"group_role_type"])
        model.roleType = [[dic objectForKey:@"group_role_type"] integerValue];
    if ([dic objectForKey:@"sys_user_account"])
        model.name = [dic objectForKey:@"sys_user_account"];

    return model;
}

- (instancetype)initTopicFriend:(NSDictionary *)dict
{
    if (!dict) {
        return nil;
    }
    
    self = [super init];
    if (self) {
//        @onExit {
//            [self checkPropertyAndSetDefaultValue];
//        };
        
        _avatar = dict[@"headUrl"];
        _name = [dict[@"name"] description];
        _userid = [dict[@"userId"] description];
        _introduction = dict[@"introduction"];
        if ([dict objectForKey:@"birthdayItype"]){
            self.birthdayItype = [[dict objectForKey:@"birthdayItype"] integerValue];
        }else{
            self.birthdayItype = 0;
        }
        
        //special by lhy begin 2016年01月30日
        //2.1.1首页改版 身边的人需要显示职业
        NSString *occupation = [@([[dict objectForKey:@"occupationId"] integerValue]) description];
        NSString *occupationKey = [NSString stringWithFormat:@"%@_FriendModel_%@", AppUserModel.chatUser_id, occupation];
        
        if([MXCache valueForKey:occupationKey])
        {
            self.occupationId = [MXCache valueForKey:occupationKey];
        } else {
          
        }
        //end
        
    }
    return self;
}

+ (NSArray *)dictionaryToModel:(NSDictionary *)dict {
    NSArray *arr = [dict valueForKey:@"data"];
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:1];
    for(NSDictionary *dic in arr) {
        FriendModel *model = [[FriendModel alloc] init];
        model.userid = [dic valueForKey:@"friend_id"];
        //model.userid = [dic valueForKey:@"create_time"];
        //model.userid = [dic valueForKey:@"user_id"];
        model.phone = [dic valueForKey:@"user_tel"];
        model.name = [dic valueForKey:@"user_name"];
        //model.userid = [dic valueForKey:@"id"];
        model.avatar = [dic valueForKey:@"head_photo"];
        model.head_photo = [dic valueForKey:@"head_photo"];
        model.black_id = [[dic valueForKey:@"black_id"] integerValue];
        [muArr addObject:model];
    }
    return muArr;
}

- (NSString *)smartName {
    return ![StringUtil isEmpty:_remark] ? _remark : (![StringUtil isEmpty:_nick_name] ? _nick_name : _name);
}
@end
