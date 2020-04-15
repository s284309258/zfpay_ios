//
//  BankOverlayView.h
//  XZF
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankOverlayView : UIView

@property (nonatomic ,strong) CompletionBlock block;

-(NSInteger)getHeight;

@end

NS_ASSUME_NONNULL_END
