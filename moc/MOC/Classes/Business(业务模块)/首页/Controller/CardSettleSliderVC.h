//
//  CardSettleSliderVC.h
//  XZF
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardSettleSliderVC : BaseViewController

@property (nonatomic,strong )CompletionBlock block;

@property (nonatomic,strong )NSString* type;

@property (nonatomic,strong )NSString* subType;

@property (nonatomic,strong )NSString* sn;


@end

NS_ASSUME_NONNULL_END
