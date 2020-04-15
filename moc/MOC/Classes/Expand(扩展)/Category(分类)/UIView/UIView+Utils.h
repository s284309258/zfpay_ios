//
//  UIView+Utils.h
//  xue
//
//  Created by Fly on 15/7/20.
//  Copyright (c) 2015年 kungstrate.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

- (void)setCircleView;
- (void)setViewCornerRadius:(CGFloat)cornerRadius;
- (void)setPurpleBorderStyle;
- (UIImage *)convertViewToImage;
- (UIImage *)convertViewToImageWithCornerRadius:(CGFloat)cornerRadius;
- (void)shake;
- (void)moveX:(CGFloat)toValue duration:(CGFloat)duration block:(CompletionBlock)block;
- (void)moveY:(CGFloat)toValue block:(CompletionBlock)block;
- (void)addAlpha:(CGFloat)toValue duration:(CGFloat)duration block:(CompletionBlock)block;
- (void)scaleXY:(CGSize)toValue duration:(CGFloat)duration comletion:(CompletionBlock)block;
- (void)like;
- (void)unLike;
- (void)addDashedBorder:(UIColor *)color corner:(CGFloat)corner;

//可以添加边框
- (UIImage *)convertViewToImageWithBorder:(UIColor *)color width:(CGFloat)width cornerRadius:(CGFloat)cornerRadius;

- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners;

///设置UIView的某几个角为圆角
- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                             type:(UIRectCorner)corners;
@end
