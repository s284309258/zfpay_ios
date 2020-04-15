//
//  MoneyLockerCollegeModel.h
//  XZF
//
//  Created by mac on 2019/9/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MoneyLockerCollegeModel : BaseObject

@property (nonatomic,strong) NSString* money_locker_id;

@property (nonatomic,strong) NSString* money_locker_title;

@property (nonatomic,strong) NSString* money_locker_cover;

@property (nonatomic,strong) NSString* cre_datetime;

@end

NS_ASSUME_NONNULL_END
