//
//  ActivityOverlayView.h
//  XZF
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ActivityOverlayView : UIView

@property (nonatomic ,strong) CompletionBlock block;

-(NSInteger)getHeight;

-(void)configActivityModel:(NSArray*)activityArray;

@end

NS_ASSUME_NONNULL_END
