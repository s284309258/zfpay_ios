//
//  UIImage+Color.h
//  MoPromo_Develop
//
//  Created by yang.xiangbao on 15/5/19.
//  Copyright (c) 2015年 MoPromo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 *  通过指定的颜色生成图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size alpha:(CGFloat)alpha;

- (UIImage *)jsq_imageMaskedWithColor:(UIColor *)maskColor;

//加模糊效果，image是图片，blur是模糊度

+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
@end
