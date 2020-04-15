//
//  ProfitTopView.h
//  XZF
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfitTopView : UIView

@property (nonatomic ,strong) CompletionBlock block;

-(void)reloadToday_benefit:(NSString*)today withdraw_money:(NSString*)withdraw_money total_benefit:(NSString*)total_benefit settle_money:(NSString *)settle_money;

@end

NS_ASSUME_NONNULL_END
