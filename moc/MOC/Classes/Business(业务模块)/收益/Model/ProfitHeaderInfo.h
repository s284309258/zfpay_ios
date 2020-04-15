//
//  ProfitHeaderInfo.h
//  XZF
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfitHeaderInfo : BaseObject
//可提现金额
@property (nonatomic,copy) NSString* withdraw_money;
//今日收益
@property (nonatomic,copy) NSString* today_benefit;
//累计收益
@property (nonatomic,copy) NSString* total_benefit;
//累计提现
@property (nonatomic,copy) NSString* settle_money;

@end

NS_ASSUME_NONNULL_END
