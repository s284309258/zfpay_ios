//
//  ReportFormHeader.h
//  XZF
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RealNameModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RFTopView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

-(void)reload:(RealNameModel*)model;

//-(void)reloadCTPos:(NSString*)ctpos mPos:(NSString*)mpos;

@end

NS_ASSUME_NONNULL_END
