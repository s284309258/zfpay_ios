//
//  MessageRecordDetailModel.h
//  XZF
//
//  Created by mac on 2019/9/5.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageRecordDetailModel : BaseObject

@property (nonatomic , strong) NSString* order_id;

@property (nonatomic , strong) NSString* money;

@property (nonatomic , strong) NSString* sn;

@property (nonatomic , strong) NSString* op_type;

@property (nonatomic , strong) NSString* cre_datetime;

@end

NS_ASSUME_NONNULL_END
