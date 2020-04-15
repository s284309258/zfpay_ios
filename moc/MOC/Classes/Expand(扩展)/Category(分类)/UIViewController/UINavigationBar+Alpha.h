//
//  UINavigationBar+Alpha.h
//  UINavigationBar
//
//  Created by yang.xiangbao on 15/5/6.
//  Copyright (c) 2015年 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Alpha)

/**
 *  设置titleText的默认颜色,(不设置默认是黑色)
 *
 *  @param titleColor 颜色值
 */
- (void)setTitleColor:(UIColor*)titleColor;

/**
 *  设置NavBar不透明是的颜色(不设置默认是白色)
 *
 *  @param navBarColor 颜色值
 */
- (void)setNavBarColor:(UIColor*)navBarColor;

/**
 *  设置滑动试 UINavigationBar 和 titleText 的颜色
 *  在 - (void)viewWillAppear:(BOOL)animated 调用
 *
 *  @param barBolor  当前NavBar的颜色
 *  @param textColor 当前titleText的颜色
*  @param height     滑动多少变动
 */
- (void)setNavBarCurrentColor:(UIColor*)barBolor
               titleTextColor:(UIColor*)textColor changeHeight:(CGFloat)height;

/**
 *  设置滑动试 UINavigationBar 和 titleText 的颜色
 *  在 - (void)viewWillAppear:(BOOL)animated 调用
 *
 *  @param barBolor  当前NavBar的颜色
 *  @param textColor 当前titleText的颜色
 */
- (void)setNavBarCurrentColor:(UIColor*)barBolor
               titleTextColor:(UIColor*)textColor;

/**
 *  UINavigationBar 透明或不透明
 *  在 - (void)scrollViewDidScroll:(UIScrollView *)scrollView 中调用
 *
 *  @param offsetY       contentOffset.y
 *  @param currentColors 回调，会把当前NavBar的颜色和当前titleText的颜色回传过去
 */
- (void)showWithOffset:(CGFloat)offsetY
         currentColors:(void(^)(UIColor *currentBarColor, UIColor *currentTitelColor))currentColors;

/**
 *  UINavigationBar 透明或不透明
 *  在 - (void)scrollViewDidScroll:(UIScrollView *)scrollView 中调用
 *
 *  @param offsetY       contentOffset.y
 *  @param currentColors 回调，仅仅会把当前NavBar的颜色
 */
- (void)showWithOffset:(CGFloat)offsetY
      currentBarColors:(void(^)(UIColor *currentColor))currentBarColor;
/**
 *  还原状态
 *  最好在 - (void)viewWillDisappear:(BOOL)animated 调用
 */
- (void)barReset;

///隐藏分割线 add by lhy 2016年01月06日
- (void)hiddenShadowLine:(BOOL)hidden;

///修复导航栏高度，
- (void)fixNaviBarHeight;
@end
