//
//  MachineBackPosModel.h
//  XZF
//
//  Created by mac on 2019/9/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MachineBackPosModel : BaseObject

@property (nonatomic,strong) NSString* record_id;

@property (nonatomic,strong) NSString* money;

@property (nonatomic,strong) NSString* frozen_time;

@property (nonatomic,strong) NSString* sn;

@property (nonatomic,strong) NSString* cre_datetime;

@property (nonatomic,strong) NSString* order_id;

@property (nonatomic,strong) NSString* activity_name;

@property (nonatomic,strong) NSString* start_date;

@property (nonatomic,strong) NSString* end_date;

@property (nonatomic,strong) NSString* assess_name;

@end

NS_ASSUME_NONNULL_END
