//
//  MXSeparatorLine.h
//  MoPal_Developer
//
//  分割线包括垂直、
//  Created by litiankun on 15/1/31.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXSeparatorLine : UIView

// 垂直分割线
+ (id)initVerticalLineHeight:(CGFloat)height orginX:(CGFloat)x orginY:(CGFloat)y;

// 水平分割线
+ (id)initHorizontalLineWidth:(CGFloat)width orginX:(CGFloat)x orginY:(CGFloat)y;


@end
