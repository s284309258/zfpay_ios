//
//  StandardRewardView.h
//  XZF
//
//  Created by mac on 2019/12/20.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolicyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface StandardRewardView : UIView

@property (nonatomic,strong) CompletionBlock click;

- (void)reloadData:(NSArray*)data layout:(UICollectionViewFlowLayout*)layout;
    
@end

@interface StandardRewardCell : UICollectionViewCell

-(void)reload:(PolicyModel*)model;

@end
NS_ASSUME_NONNULL_END
