//
//  PosSliderView.h
//  XZF
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanTraditionalPosModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PosSliderView : UIView

-(void)reload:(ScanTraditionalPosModel*)model select:(BOOL)isSelect;

@end

NS_ASSUME_NONNULL_END
