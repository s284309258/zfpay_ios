//
//  HBLevelModel.h
//  MOC
//
//  Created by mac on 2019/6/21.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface HBLevelModel : BaseObject

@property (nonatomic , strong) NSString* id;

@property (nonatomic , strong) NSString* level;

@property (nonatomic , strong) NSString* amount;

@property (nonatomic , strong) NSString* status;

@property (nonatomic , strong) NSString* createTime;

@end

NS_ASSUME_NONNULL_END
