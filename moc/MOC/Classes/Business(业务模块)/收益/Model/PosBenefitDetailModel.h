//
//  PosBenefitDetailModel.h
//  XZF
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PosBenefitDetailModel : BaseObject
//活动收益
@property (nonatomic,copy) NSString* activity_benefit;
//返现收益
@property (nonatomic,copy) NSString* return_benefit;
//直营收益
@property (nonatomic,copy) NSString* merchant_benefit;
//代理收益
@property (nonatomic,copy) NSString* agency_benefit;
//未达标扣除金额
@property (nonatomic,copy) NSString* deduct_money;
//分润收益
@property (nonatomic,copy) NSString* share_benefit;
//总收益
@property (nonatomic,copy) NSString* benefit;

@property (nonatomic, copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
