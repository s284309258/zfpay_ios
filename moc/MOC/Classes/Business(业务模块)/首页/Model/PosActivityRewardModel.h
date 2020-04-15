//
//  PosActivityRewardModel.h
//  XZF
//
//  Created by mac on 2019/8/30.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PosActivityRewardModel : BaseObject

@property (nonatomic, strong) NSString* expenditure;

@property (nonatomic, strong) NSString* activity_reward_id;

@property (nonatomic, strong) NSString* reward_money;

@property (nonatomic, strong) NSString* pos_num;


@end

NS_ASSUME_NONNULL_END
