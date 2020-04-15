//
//  StandardMerchantCell.h
//  XZF
//
//  Created by mac on 2019/12/20.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolicyRecordModel.h"
#import "StandardRewardView.h"
NS_ASSUME_NONNULL_BEGIN

@interface StandardMerchantCell : UITableViewCell

@property (strong, nonatomic) StandardRewardView* rewardView;

-(void)reload:(PolicyRecordModel*)model;

//-(void)reload:(NSString*)name no:(NSString*)no money:(NSString*)money date:(NSString*)date data:(NSArray*)data;

@end

NS_ASSUME_NONNULL_END
