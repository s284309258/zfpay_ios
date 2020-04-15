//
//  CTRewardView.h
//  XZF
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PosRewardModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTRewardView : UITableViewCell

-(void)reload:(PosRewardModel*)model;

@end

NS_ASSUME_NONNULL_END
