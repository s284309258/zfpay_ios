//
//  CTActivitiesView.h
//  XZF
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TraditionalPosActivityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTActivitiesView : UIView

-(void)reload:(TraditionalPosActivityModel*) model;

@end

NS_ASSUME_NONNULL_END
