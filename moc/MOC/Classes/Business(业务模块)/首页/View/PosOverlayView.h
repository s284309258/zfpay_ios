//
//  PosOverlayView.h
//  XZF
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PosOverlayView : UIView

@property (nonatomic ,strong) CompletionBlock block;

-(NSInteger)getHeight;

-(void)configPosModel:(NSArray*)posArray;

@end

NS_ASSUME_NONNULL_END
