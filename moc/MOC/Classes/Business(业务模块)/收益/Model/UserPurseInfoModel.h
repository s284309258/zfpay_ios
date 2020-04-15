//
//  UserPurseInfoModel.h
//  XZF
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserPurseInfoModel : BaseObject

//账户余额
@property (nonatomic,copy) NSString* money;
//扣除金额
@property (nonatomic,copy) NSString* deduct_money;
//到账金额
@property (nonatomic,copy) NSString* settle_money;
//结算单笔手续费金额
@property (nonatomic,copy) NSString* settle_single_feet_money;
//结算比例手续费金额
@property (nonatomic,copy) NSString* single_rate_feet_money;
//今日收益
@property (nonatomic,copy) NSString* today_benefit;
//累计收益
@property (nonatomic,copy) NSString* total_benefit;

@end

NS_ASSUME_NONNULL_END
