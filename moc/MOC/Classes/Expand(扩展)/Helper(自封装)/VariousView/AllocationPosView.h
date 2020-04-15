//
//  AllocationPosView.h
//  XZF
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllocationPosBatchModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AllocationPosView : UIView

-(void)reload:(AllocationPosBatchModel*)model;

@end

NS_ASSUME_NONNULL_END
