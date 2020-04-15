//
//  RFPosDetailModel.h
//  XZF
//
//  Created by mac on 2019/9/4.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface RFPosDetailModel : BaseObject

@property (nonatomic,copy) NSString* performance;

@property (nonatomic,copy) NSString* pos_num;

@property (nonatomic,copy) NSString* act_num;

@property (nonatomic,copy) NSString* user_num;

@property (nonatomic,copy) NSString* date;

@property (nonatomic,copy) NSString* pos_avg;

@property (nonatomic,copy) NSString* act_num_day;

@end

NS_ASSUME_NONNULL_END
