//
//  PosRewardModel.h
//  XZF
//
//  Created by mac on 2019/8/30.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PosRewardModel : BaseObject

@property (nonatomic, strong) NSString* record_id;

@property (nonatomic, strong) NSString* activity_name;

@property (nonatomic, strong) NSString* money;

@property (nonatomic, strong) NSString* order_id;

@property (nonatomic, strong) NSString* start_date;

@property (nonatomic, strong) NSString* end_date;

@property (nonatomic, strong) NSString* cre_datetime;

@property (nonatomic, strong) NSString* sn;

@end

NS_ASSUME_NONNULL_END
