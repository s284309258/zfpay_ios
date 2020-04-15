//
//  TextTextImgView.h
//  XZF
//
//  Created by mac on 2019/8/10.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextTextImgView : UIView

@property (nonatomic, strong) UILabel         *title;

@property (nonatomic, strong) UILabel         *desc;

-(void)reloadImg:(NSString *)img title:(NSString *)title desc:(NSString* )desc;

-(void)reloadTop:(NSString *)title bottom:(NSString *)desc right:(NSString* )img;

-(void)isHiddenLine:(BOOL)hidden;

@end

NS_ASSUME_NONNULL_END
