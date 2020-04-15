//
//  HBTradeModel.h
//  MOC
//
//  Created by mac on 2019/6/21.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface HBTradeModel : BaseObject

@property (nonatomic , strong) NSString* id;

@property (nonatomic , strong) NSString* userId;

@property (nonatomic , strong) NSString* sellId;

@property (nonatomic , strong) NSString* sellUserId;

@property (nonatomic , strong) NSString* amount;

@property (nonatomic , strong) NSString* price;

@property (nonatomic , strong) NSString* worth;

@property (nonatomic , strong) NSString* buyAmount;

@property (nonatomic , strong) NSString* buyWorth;

@property (nonatomic , strong) NSString* voucher;

@property (nonatomic , strong) NSString* status;//状态 wait_sell(等待卖出) wait_voucher(等待上传凭证) wait_confirm(等待确认放币) success(成功) sys_close(系统关闭) sys_success(系统成功) sys_freeze(系统冻结)

@property (nonatomic , strong) NSString* reason;

@property (nonatomic) NSInteger payType;

@property (nonatomic , strong) NSString* sellTime;

@property (nonatomic , strong) NSString* voucherTime;

@property (nonatomic , strong) NSString* confirmTime;

@property (nonatomic , strong) NSString* createTime;

@property (nonatomic , strong) NSString* updateTime;

@property (nonatomic , strong) NSString* payPassword;

@property (nonatomic , strong) NSString* username;

@end

NS_ASSUME_NONNULL_END
