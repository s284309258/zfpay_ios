//
//  RewardVC.h
//  Lcwl
//
//  Created by mac on 2018/12/13.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RewardVC : BaseViewController
@property(nonatomic, copy) NSString *circleId;
@property(nonatomic, copy) NSString *circleUserId;
@property(nonatomic, copy) CompletionBlock block;
@end

NS_ASSUME_NONNULL_END
