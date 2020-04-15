//
//  InOutModel.h
//  MOC
//
//  Created by mac on 2019/6/21.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface InOutModel : BaseObject

@property (nonatomic , strong) NSString* id;

@property (nonatomic , strong) NSString* after;

@property (nonatomic , strong) NSString* amount;

@property (nonatomic , strong) NSString* before;

@property (nonatomic , strong) NSString* busType;

@property (nonatomic , strong) NSString* createTime;

@property (nonatomic , strong) NSString* currType;

@property (nonatomic , strong) NSString* sceneType;

@property (nonatomic , strong) NSString* userId;

@end

NS_ASSUME_NONNULL_END
