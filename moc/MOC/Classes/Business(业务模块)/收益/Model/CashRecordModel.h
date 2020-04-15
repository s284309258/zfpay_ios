//
//  CashRecordModel.h
//  XZF
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CashRecordDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CashRecordModel : BaseObject

@property (nonatomic,copy) NSString* cash_id;

@property (nonatomic,copy) NSString* order_id;

@property (nonatomic,copy) NSString* account;

@property (nonatomic,copy) NSString* cash_money;

@property (nonatomic,copy) NSString* cash_actual_money;

@property (nonatomic,copy) NSString* feet_rate;

@property (nonatomic,copy) NSString* rate_feet_money;

@property (nonatomic,copy) NSString* single_feet_money;

@property (nonatomic,copy) NSString* deduct_money;

@property (nonatomic,copy) NSString* status;

@property (nonatomic,copy) NSString* cre_date;

@property (nonatomic,copy) NSArray* cashRecordDetailList;

@end

NS_ASSUME_NONNULL_END
