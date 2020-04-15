//
//  ReferAgencyPosModel.h
//  XZF
//
//  Created by mac on 2019/9/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReferAgencyPosModel : BaseObject


@property (nonatomic,strong) NSString* mpos_id;

@property (nonatomic,strong) NSString* trapos_id;

@property (nonatomic,strong) NSString* performance;

@property (nonatomic,strong) NSString* sn;

@property (nonatomic,strong) NSString* name;

@property (nonatomic,strong) NSString* mer_name;

@property (nonatomic,strong) NSString* state_status;

@end

NS_ASSUME_NONNULL_END
