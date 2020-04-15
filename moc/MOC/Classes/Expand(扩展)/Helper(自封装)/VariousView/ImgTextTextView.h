//
//  ImgTextTextView.h
//  XZF
//
//  Created by mac on 2019/8/7.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImgTextTextView : UIView

@property (nonatomic, strong) UIImageView     *img;

@property (nonatomic, strong) UILabel         *title;

@property (nonatomic, strong) UILabel         *desc;

-(void)reloadLeft:(NSString *)img middle:(NSString *)title right:(NSString* )desc;

-(void)reloadLeft:(NSString *)img top:(NSString *)top bottom:(NSString *)bottom;

-(void)setImageSize:(CGSize)size;

-(void)isShowLine:(BOOL)isHidden;

@end

NS_ASSUME_NONNULL_END
