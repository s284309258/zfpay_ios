//
//  PolicyRecordModel.h
//  XZF
//
//  Created by mac on 2019/12/20.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface PolicyRecordModel : BaseObject
//POS类型
@property (nonatomic,strong) NSString* pos_type;
//结束日期
@property (nonatomic,strong) NSString* end_date;
//开始日期
@property (nonatomic,strong) NSString* begin_date;
//商户号
@property (nonatomic,strong) NSString* mer_id;
//商户名称
@property (nonatomic,strong) NSString* mer_name;
//政策类型
@property (nonatomic,strong) NSString* trade_quantity;
//达标金额
@property (nonatomic,strong) NSString* trade_amount;
//对应的政策ID
@property (nonatomic,strong) NSString* policy_id;
//已经领取奖励对应policy_id
@property (nonatomic,strong) NSString* choose;
//政策列表
@property (nonatomic,strong) NSArray* policy3List;
//POS类型
@property (nonatomic,strong) NSString* policy_name;
//政策交易量
@property (nonatomic,strong) NSString* policy_quantity;
//返现金额
@property (nonatomic,strong) NSString* policy_amount;
//政策ID
@property (nonatomic,strong) NSString* id;
//汇总数据
@property (nonatomic,strong) NSArray* policyList;
//过期时间
@property (nonatomic,strong) NSString* expire_day;

@end

NS_ASSUME_NONNULL_END
