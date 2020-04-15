//
//  PosInstallDetailModel.h
//  XZF
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface PosInstallDetailModel : BaseObject

@property (nonatomic,strong) NSString* biz_code;

@property (nonatomic,strong) NSString* biz_msg;

@property (nonatomic,strong) NSString* source;

@property (nonatomic,strong) NSString* merchant_name;

@property (nonatomic,strong) NSString* mer_code;

@property (nonatomic,strong) NSString* agent_id;

@property (nonatomic,strong) NSString* settle_flag;

@property (nonatomic,strong) NSString* sdk_push_key;

@property (nonatomic,strong) NSString* cre_datetime;

@property (nonatomic,strong) NSArray* terminalList;

@end

NS_ASSUME_NONNULL_END
