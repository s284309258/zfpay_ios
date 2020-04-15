//
//  ProfitView.h
//  XZF
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PosBenefitDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProfitView : UIView

@property (nonatomic,strong) CompletionBlock block;

-(void)reload:(PosBenefitDetailModel*)model dateString:(NSString*)date;

@end

NS_ASSUME_NONNULL_END
