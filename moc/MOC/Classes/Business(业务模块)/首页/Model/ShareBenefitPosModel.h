//
//  ShareBenefitPosModel.h
//  XZF
//
//  Created by mac on 2019/9/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareBenefitPosModel : BaseObject

@property (nonatomic,strong) NSString* record_id;

@property (nonatomic,strong) NSString* benefit_type;

@property (nonatomic,strong) NSString* single_amount;

@property (nonatomic,strong) NSString* state_type;

@property (nonatomic,strong) NSString* benefit_money;

@property (nonatomic,strong) NSString* sn;

@property (nonatomic,strong) NSString* trans_datetime;

@property (nonatomic,strong) NSString* cre_datetime;

@property (nonatomic,strong) NSString* trans_amount;

@property (nonatomic,strong) NSString* card_type;

@property (nonatomic,strong) NSString* order_id;

@property (nonatomic,strong) NSString* trans_type;

@property (nonatomic,strong) NSString* trans_product;

@end

NS_ASSUME_NONNULL_END
