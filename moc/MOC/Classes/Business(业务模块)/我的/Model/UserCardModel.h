//
//  UserCardModel.h
//  XZF
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserCardModel : BaseObject

@property (nonatomic, copy) NSString* card_id;

@property (nonatomic, copy) NSString* user_id;

@property (nonatomic, copy) NSString* account;

@property (nonatomic, copy) NSString* bank_code;

@property (nonatomic, copy) NSString* card_photo;

@property (nonatomic, copy) NSString* status;

@property (nonatomic, copy) NSString* account_name;

@property (nonatomic, copy) NSString* bank_name;

@property (nonatomic, copy) NSString* is_default;

@property (nonatomic, copy) NSString* remark;

@end

NS_ASSUME_NONNULL_END
