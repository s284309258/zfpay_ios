//
//  CashInfoModel.h
//  XZF
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 提现手续费率
 cashFeetRate
 是
 String
 提现手续费率
 可提现金额
 can_cash_money
 是
 String
 可提现金额
 最低提现额度
 cashMinNum
 是
 String
 最低提现额度
 提现单笔固定手续费
 cashSingleFeet
 是
 String
 提现单笔固定手续费
 未达标扣除金额
 deduct_money
 是
 String
 未达标扣除金额

 */
@interface CashInfoModel : BaseObject

@property (nonatomic, copy) NSString* cashFeetRate;

@property (nonatomic, copy) NSString* can_cash_money;

@property (nonatomic, copy) NSString* cashMinNum;

@property (nonatomic, copy) NSString* cashSingleFeet;

@property (nonatomic, copy) NSString* deduct_money;

@end



NS_ASSUME_NONNULL_END
