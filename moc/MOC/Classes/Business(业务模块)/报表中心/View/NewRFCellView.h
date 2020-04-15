//
//  NewRFCellView.h
//  XZF
//
//  Created by mac on 2020/1/8.
//  Copyright © 2020 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewRFCellView : UIView

@property (nonatomic,strong) dispatch_block_t open;

-(void)reload:(RealNameModel*)model;

-(void)reloadCTPos:(NSString*)ctpos mPos:(NSString*)mpos ePos:(NSString*)epos;

@end

NS_ASSUME_NONNULL_END
