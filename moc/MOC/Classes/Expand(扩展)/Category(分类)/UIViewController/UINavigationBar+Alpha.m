//
//  UINavigationBar+Alpha.m
//  UINavigationBar
//
//  Created by yang.xiangbao on 15/5/6.
//  Copyright (c) 2015年 ltebean. All rights reserved.
//

#import "UINavigationBar+Alpha.h"
#import <objc/runtime.h>

static char const shadowLineKey;
static char backgroundViewKey;
static char navBarColorKey;
static char titleAttributesKey;
static char titleColorKey;
static CGFloat changedHeight = 50;

//// scrollView 滑动的距离
//#define NAVBAR_CHANGE_POINT (changedHeight)

@implementation UINavigationBar (Alpha)

- (UIView *)backgroundView
{
    return objc_getAssociatedObject(self, &backgroundViewKey);
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    objc_setAssociatedObject(self, &backgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView*)shadowLine{
    return objc_getAssociatedObject(self, &shadowLineKey);
}

-(void)setShadowLine:(UIView*)shadowLine{
    objc_setAssociatedObject(self, &shadowLineKey, shadowLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor*)navBarColor
{
    UIColor *color = objc_getAssociatedObject(self, &navBarColorKey);
    if (!color) {
        color = [UIColor whiteColor];
    }
    
    return color;
}

- (void)setNavBarColor:(UIColor*)navBarColor
{
    objc_setAssociatedObject(self, &navBarColorKey, navBarColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary*)titleAttributes
{
    return objc_getAssociatedObject(self, &titleAttributesKey);
}

- (void)setTitleAttributes:(NSDictionary*)titleAttributes
{
    objc_setAssociatedObject(self, &titleAttributesKey, titleAttributes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor*)titleColor
{
    UIColor *color = objc_getAssociatedObject(self, &titleColorKey);
    if (!color) {
        color = [UIColor blackColor];
    }
    
    return color;
}

- (void)setTitleColor:(UIColor*)titleColor
{
    objc_setAssociatedObject(self, &titleColorKey, titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 设置UINavigationBar的颜色
- (void)mx_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.backgroundView) {
        self.titleAttributes = self.titleTextAttributes;
        [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + [[UIApplication sharedApplication] statusBarFrame].size.height)];
        [self setTranslucent:YES];
        [self setShadowImage:[[UIImage alloc] init]];
        self.backgroundView.userInteractionEnabled = NO;
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
        
        self.shadowLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.backgroundView.frame) - 0.5f, SCREEN_WIDTH, 0.5f)];
        self.shadowLine.backgroundColor = [UIColor clearColor];
        [self.backgroundView addSubview:self.shadowLine];
    }
    
    CGColorRef colorRef = [backgroundColor CGColor];
    const CGFloat *components = CGColorGetComponents(colorRef);
    NSUInteger componentsCount = CGColorGetNumberOfComponents(colorRef);
    self.shadowLine.backgroundColor = [[UIColor moLineLight]colorWithAlphaComponent:components[componentsCount - 1]];
    
    self.backgroundView.backgroundColor = backgroundColor;
}

- (void)fixNaviBarHeight {
    self.backgroundView.height = CGRectGetHeight(self.bounds) + [[UIApplication sharedApplication] statusBarFrame].size.height;
}

#pragma mark - 还原状态
- (void)barReset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:nil];
    [self setTranslucent:NO];
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    [self setBarTintColor:[UIColor whiteColor]];
    [self setTitleTextAttributes:self.titleAttributes];
}

#pragma mark - 设置titleText的样式
- (void)setNavBarTitleColor:(UIColor*)color
{
    [self setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName : color,
                                   NSFontAttributeName : [UIFont font19]
                                   }];
}

#pragma mark - 设置滑动试 UINavigationBar、titleText 的颜色和滑动的高度
- (void)setNavBarCurrentColor:(UIColor*)barBolor
               titleTextColor:(UIColor*)textColor changeHeight:(CGFloat)height
{
    [self mx_setBackgroundColor:barBolor];
    [self setNavBarTitleColor:textColor];
    changedHeight = height;
}

#pragma mark - 设置滑动试 UINavigationBar 和 titleText 的颜色
- (void)setNavBarCurrentColor:(UIColor*)barBolor
               titleTextColor:(UIColor*)textColor
{
    [self mx_setBackgroundColor:barBolor];
    [self setNavBarTitleColor:textColor];
}

#pragma mark - UINavigationBar 透明或不透明 
- (void)showWithOffset:(CGFloat)offsetY
         currentColors:(void(^)(UIColor *currentBarColor, UIColor *currentTitelColor))currentColors
{
    UIColor *color = self.navBarColor;
    if (offsetY > changedHeight) {
        CGFloat alpha              = 1 - ((changedHeight + 64 - offsetY) / 64);
        UIColor *currentBarColor   = [color colorWithAlphaComponent:alpha];
        UIColor *currentTitelColor = [[self titleColor] colorWithAlphaComponent:alpha];
        [self setNavBarCurrentColor:currentBarColor
                     titleTextColor:currentTitelColor];
        if (currentColors) {
            currentColors(currentBarColor, currentTitelColor);
        }
    } else {
        UIColor *currentColor = [color colorWithAlphaComponent:0.0f];
        [self setNavBarCurrentColor:currentColor
                     titleTextColor:[UIColor clearColor]];
        if (currentColors) {
            currentColors(currentColor, [UIColor clearColor]);
        }
    }
}

- (void)showWithOffset:(CGFloat)offsetY
         currentBarColors:(void(^)(UIColor *currentColor))currentBarColor
{
    UIColor *color = self.navBarColor;
    if (offsetY > changedHeight) {
        CGFloat alpha              = 1 - ((changedHeight + 64 - offsetY) / 64);
        UIColor *currentColor   = [color colorWithAlphaComponent:alpha];
        [self setNavBarCurrentColor:currentColor
                     titleTextColor:[self titleColor]];
        if (currentBarColor) {
            currentBarColor(currentColor);
        }
    } else {
        UIColor *currentColor = [color colorWithAlphaComponent:0.0f];
        [self setNavBarCurrentColor:currentColor
                     titleTextColor:[self titleColor]];
        if (currentBarColor) {
            currentBarColor(currentColor);
        }
    }
}

- (void)hiddenShadowLine:(BOOL)hidden {
    self.shadowLine.hidden = hidden;
}

@end
