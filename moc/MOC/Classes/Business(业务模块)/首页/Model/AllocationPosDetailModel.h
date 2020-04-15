//
//  AllocationPosDetailModel.h
//  XZF
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface AllocationPosDetailModel : BaseObject

@property (nonatomic ,copy) NSString* allocation_id;

@property (nonatomic ,copy) NSString* sn;

@property (nonatomic ,copy) NSString* real_name;

@property (nonatomic ,copy) NSString* zhifubao_settle_price;

@property (nonatomic ,copy) NSString* cloud_settle_price;

@property (nonatomic ,copy) NSString* weixin_settle_price;

@property (nonatomic ,copy) NSString* cash_back_rate;

@property (nonatomic ,copy) NSString* card_settle_price;

@property (nonatomic ,copy) NSString* single_profit_rate;

@property (nonatomic ,copy) NSString* mer_cap_fee;

@property (nonatomic ,copy) NSString* policy_name;

@property (nonatomic ,copy) NSString* card_settle_price_vip;

@property (nonatomic ,copy) NSString* sns;

@property (nonatomic ,copy) NSString* is_reward;


@end

NS_ASSUME_NONNULL_END
