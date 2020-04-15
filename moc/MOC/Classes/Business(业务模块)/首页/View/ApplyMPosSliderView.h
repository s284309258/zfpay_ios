//
//  ApplyMPosSliderView.h
//  XZF
//
//  Created by mac on 2019/8/30.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPosModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ApplyMPosSliderView : UIView

-(void)reload:(MPosModel*)model select:(BOOL)isSelect;

-(void)reloadSN:(NSString*)sn select:(BOOL)isSelect;

@end

NS_ASSUME_NONNULL_END
