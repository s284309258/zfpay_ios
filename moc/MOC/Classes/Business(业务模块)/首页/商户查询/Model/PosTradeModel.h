//
//  PosTradeModel.h
//  XZF
//
//  Created by mac on 2020/3/14.
//  Copyright © 2020 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PosTradeModel : BaseObject

@property (nonatomic,copy) NSString* benefit_money;

@property (nonatomic,copy) NSString* trans_amount;

@property (nonatomic,copy) NSString* trans_time;

@end

NS_ASSUME_NONNULL_END
