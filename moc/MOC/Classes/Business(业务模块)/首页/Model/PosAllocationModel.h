//
//  PosAllocationModel.h
//  XZF
//
//  Created by mac on 2019/8/31.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PosAllocationModel : BaseObject

@property (nonatomic, strong) NSString* sn;

@property (nonatomic, strong) NSString* card_no;

@property (nonatomic, strong) NSString* zhifubao_settle_price;

@property (nonatomic, strong) NSString* weixin_settle_price;

@property (nonatomic, strong) NSString* card_settle_price;

@property (nonatomic, strong) NSString* cloud_settle_price;

@property (nonatomic, strong) NSString* cash_back_rate;

@property (nonatomic, strong) NSString* single_profit_rate;

@property (nonatomic, strong) NSString* expire_day;

@property (nonatomic, strong) NSString* card_settle_price_vip;

@property (nonatomic, strong) NSString* policy_name;

@end

NS_ASSUME_NONNULL_END
