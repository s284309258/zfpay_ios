//
//  CreditCardRateSliderVC.h
//  XZF
//
//  Created by mac on 2019/9/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreditCardRateSliderVC : BaseViewController

@property (nonatomic,strong )CompletionBlock block;

@property (nonatomic,strong )NSString* type;

@property (nonatomic,strong )NSString* subType;

@end

NS_ASSUME_NONNULL_END
