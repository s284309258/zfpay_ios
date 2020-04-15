//
//  UIView+FindViewController.h
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/4/30.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FindViewController)

/**
 *  查找 View 所在的 viewController
 *
 *  @return 查找到的viewController没找到返回nil
 */
- (UIViewController *)viewController;

//获取当前屏幕显示的viewController 不是当前的具体的ViewController 可以用在需要present的时候
+ (UIViewController *)viewControllerFromWindow;

//获取当前屏幕显示的viewController 并且是在navigation栈顶的viewController
+ (UIViewController *)getTopViewControllerInNavigationStackFromWindow;
@end
