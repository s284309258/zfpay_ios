//
//  PosActivityApplyModel.h
//  XZF
//
//  Created by mac on 2019/8/30.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PosActivityApplyDetailModel : BaseObject

@property (nonatomic, strong) NSString* apply_id;

@property (nonatomic, strong) NSString* activity_name;

@property (nonatomic, strong) NSString* sn_list;

@property (nonatomic, strong) NSString* expenditure;

@property (nonatomic, strong) NSString* reward_money;

@property (nonatomic, strong) NSString* order_id;

@property (nonatomic, strong) NSString* pos_num;

@property (nonatomic, strong) NSString* status;

@property (nonatomic, strong) NSString* start_date;

@property (nonatomic, strong) NSString* end_date;

@property (nonatomic, strong) NSString* cre_datetime;


@end

NS_ASSUME_NONNULL_END
