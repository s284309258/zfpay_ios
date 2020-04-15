//
//  UserModel.m
//  MoPal_Developer
//
//  Created by 王 刚 on 15/2/26.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "UserModel.h"
#import "UserAvatarModel.h"
#import "CommonDefine.h"
#import "MXCache.h"
#import "SSDeviceDefault.h"
#import "DeviceManager.h"

static NSString * const UserModelCacheKey = @"UserModelCacheKey";

@interface UserModel ()


@end

@implementation UserModel

#pragma mark - 对象序列化
- (void)encodeWithCoder:(NSCoder *)aCoder
{
//    [aCoder encodeObject:self.auth_status forKey:@"auth_status"];
    [aCoder encodeObject:self.head_photo forKey:@"head_photo"];
    [aCoder encodeObject:self.pay_password forKey:@"pay_password"];
    [aCoder encodeObject:self.qiniu_domain forKey:@"qiniu_domain"];
    [aCoder encodeObject:self.qr_code_url forKey:@"qr_code_url"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.user_id forKey:@"user_id"];
    [aCoder encodeObject:self.user_tel forKey:@"user_tel"];
    [aCoder encodeObject:self.password forKey:@"password"];
    
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
//        self.auth_status = [aDecoder decodeObjectForKey:@"auth_status"];
        self.head_photo = [aDecoder decodeObjectForKey:@"head_photo"];
        self.pay_password = [aDecoder decodeObjectForKey:@"pay_password"];
        self.qiniu_domain = [aDecoder decodeObjectForKey:@"qiniu_domain"];
        self.qr_code_url = [aDecoder decodeObjectForKey:@"qr_code_url"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.user_id = [aDecoder decodeObjectForKey:@"user_id"];
        self.user_tel = [aDecoder decodeObjectForKey:@"user_tel"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
              
    }
    return self;
}

- (void)saveModelToCache{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self];
    if (data) {
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:UserModelCacheKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (UserModel*)modelFromCache{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:UserModelCacheKey];
    if (!data) {
        return nil;[[UserModel alloc] init];
    }
    UserModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (model && [model isKindOfClass:[UserModel class]]) {
        return model;
    }
    return nil;
}

-(NSDictionary*)generateChatParam{
//    return @{@"user_id":self.user_id,
//             @"sys_user_account":self.account,
//             @"head_photo":self.pic,
//             @"register_type":@"1",
//             @"user_tel":self.mobile,
//             //@"user_email":self.user_email,
//             @"system_type":@"BiHuo"
//    };
    return nil;
}
@end
