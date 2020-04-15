//
//  CashOutTailer.h
//  XZF
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CashOutTailer : UIView

@property (nonatomic, strong) CompletionBlock block;

@property (nonatomic , strong) UITextField* numTf;

-(void)reload:(CashInfoModel*)model;

@end

NS_ASSUME_NONNULL_END
