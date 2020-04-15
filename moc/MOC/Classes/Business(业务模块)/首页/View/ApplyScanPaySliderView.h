//
//  ApplyScanPaySliderView.h
//  XZF
//
//  Created by mac on 2019/8/29.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanTraditionalPosModel.h"
#import "RefererAgencyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ApplyScanPaySliderView : UIView

-(void)reload:(ScanTraditionalPosModel*)model select:(BOOL)isSelect;

-(void)reloadAgent:(RefererAgencyModel*)model select:(BOOL)isSelect;

-(void)reloadTitle:(NSString*)title select:(BOOL)isSelect;

@end

NS_ASSUME_NONNULL_END
