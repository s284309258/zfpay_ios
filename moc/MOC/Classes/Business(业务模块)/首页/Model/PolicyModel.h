//
//  PolicyModel.h
//  XZF
//
//  Created by mac on 2019/12/20.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"
typedef NS_ENUM(NSInteger, TakeRewardState) {
    UnEnableTakeReward,
    EnableTakeReward,
    TakeRewarded,
};

NS_ASSUME_NONNULL_BEGIN

@interface PolicyModel : BaseObject
//
@property (nonatomic,strong) NSString* cre_date;
//
@property (nonatomic,strong) NSString* id;
//
@property (nonatomic,strong) NSString* isuse;
//
@property (nonatomic,strong) NSString* manager_id;
//
@property (nonatomic,strong) NSString* policy_amount;
//
@property (nonatomic,strong) NSString* policy_begin_day;
//
@property (nonatomic,strong) NSString* policy_end_day;
//
@property (nonatomic,strong) NSString* policy_name;
//
@property (nonatomic,strong) NSString* policy_quantity;
//
@property (nonatomic,strong) NSString* policy_type;
//
@property (nonatomic,strong) NSString* pos_type;
//
@property (nonatomic,strong) NSString* remark;
//
@property (nonatomic,strong) NSString* upd_by;
//
@property (nonatomic,strong) NSString* upd_date;

@property (nonatomic) TakeRewardState state;

@end

NS_ASSUME_NONNULL_END
