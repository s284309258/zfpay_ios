//
//  PosDetailModel.h
//  XZF
//
//  Created by mac on 2019/9/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PosDetailModel :BaseObject

@property (nonatomic,strong) NSString* name;

@property (nonatomic,strong) NSString* tel;

@property (nonatomic,strong) NSString* sn;

@property (nonatomic,strong) NSString* zhifubao_settle_price;

@property (nonatomic,strong) NSString* cloud_settle_price;

@property (nonatomic,strong) NSString* zhifubao_rate;

@property (nonatomic,strong) NSString* credit_card_rate;

@property (nonatomic,strong) NSString* weixin_rate;

@property (nonatomic,strong) NSString* weixin_settle_price;

@property (nonatomic,strong) NSString* cloud_flash_rate;

@property (nonatomic,strong) NSString* card_settle_price;

@property (nonatomic,strong) NSString* single_profit_rate;

@property (nonatomic,strong) NSString* act_status;

@property (nonatomic,strong) NSString* cash_back_rate;

@property (nonatomic,strong) NSString* mer_cap_fee;

@property (nonatomic,strong) NSString* mer_name;

@property (nonatomic,strong) NSString* mer_id;

@property (nonatomic,strong) NSString* num;

@property (nonatomic,strong) NSString* performance;

@property (nonatomic,strong) NSString* cash_back_status;

@property (nonatomic,strong) NSString* card_settle_price_vip;

@property (nonatomic,strong) NSString* expire_day;

@property (nonatomic,strong) NSString* policy_name;
//激活时间
@property (nonatomic,strong) NSString* act_date;

@end


NS_ASSUME_NONNULL_END
