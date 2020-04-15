//
//  ApplyRateRecordModel.h
//  XZF
//
//  Created by mac on 2019/9/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplyRateRecordModel : BaseObject

@property (nonatomic,strong) NSString* apply_id;

@property (nonatomic,strong) NSString* credit_card_rate_old;

@property (nonatomic,strong) NSString* credit_card_rate_new;

@property (nonatomic,strong) NSString* sn;

@property (nonatomic,strong) NSString* status;

@property (nonatomic,strong) NSString* cre_datetime;

@property (nonatomic,strong) NSString* remark;




@end

NS_ASSUME_NONNULL_END
