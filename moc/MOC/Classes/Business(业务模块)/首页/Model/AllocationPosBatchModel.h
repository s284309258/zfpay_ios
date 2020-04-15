//
//  AllocationPosBatchModel.h
//  XZF
//
//  Created by mac on 2019/11/1.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface AllocationPosBatchModel : BaseObject
//最小sn号
@property (nonatomic,strong) NSString* min_sn;
//最大sn号
@property (nonatomic,strong) NSString* max_sn;
//手机分配POS的分配日期
@property (nonatomic,strong) NSString* allocate_date;
//代理商姓名
@property (nonatomic,strong) NSString* real_name;
//购买设备的代理商ID
@property (nonatomic,strong) NSString* user_id;
//批次号
@property (nonatomic,strong) NSString* batch_no;
//发货的代理商ID
@property (nonatomic,strong) NSString* allocate_by;
//记录ID号
@property (nonatomic,strong) NSString* id;
//台数
@property (nonatomic,strong) NSString* cnt;


@end

NS_ASSUME_NONNULL_END
