//
//  RewardOverlayView.h
//  XZF
//
//  Created by mac on 2019/12/21.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RewardOverlayView : UIView

+(void)showInView:(UIView*)inView text:(NSString*)text confirm:(dispatch_block_t)confirm cancel:(dispatch_block_t)cancel;

+(void)hiddenInView:(UIView*)inView ;

@end

NS_ASSUME_NONNULL_END
