//
//  MineHeaderCenterView.h
//  MOC
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineHeaderCenterView : UIView

@property (nonatomic ,strong) CompletionBlock block;

- (instancetype)initWithFrame:(CGRect)frame;

-(void)reloadTitleLbl1:(NSString *)title1 titleLbl2:(NSString* )title2 value1:(NSString* )value1 value2:(NSString* )value2;

- (void)reloadUI ;

@end

NS_ASSUME_NONNULL_END
