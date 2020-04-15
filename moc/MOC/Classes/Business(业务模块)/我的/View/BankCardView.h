//
//  BankCardView.h
//  XZF
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCardModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BankCardView : UIView

@property (nonatomic ,strong) CompletionBlock deleteBlock;

-(void)reload:(UserCardModel*)model;

@end

NS_ASSUME_NONNULL_END
