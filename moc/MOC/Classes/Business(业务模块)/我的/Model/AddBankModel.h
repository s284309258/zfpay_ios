//
//  AddBankModel.h
//  XZF
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddBankModel : NSObject

@property (nonatomic, copy) NSString* bank_code;

@property (nonatomic, copy) NSString* bank_name;
//新增必传
@property (nonatomic, copy) NSString* card_photo_up;

@property (nonatomic, copy) NSString* card_photo_down;

@property (nonatomic, copy) NSString* is_default;

@property (nonatomic, copy) NSString* account;

@property (nonatomic, copy) NSString* card_id;

@property (nonatomic, copy) NSString* pay_password;


@end

NS_ASSUME_NONNULL_END
