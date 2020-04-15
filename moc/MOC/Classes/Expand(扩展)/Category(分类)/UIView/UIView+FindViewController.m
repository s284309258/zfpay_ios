//
//  UIView+FindViewController.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/4/30.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "UIView+FindViewController.h"

@implementation UIView (FindViewController)

- (UIViewController *)viewController {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    return nil;
}


//获取当前屏幕显示的viewController
+ (UIViewController *)viewControllerFromWindow{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] firstObject];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    
    return result;
}

+ (UIViewController *)getTopViewControllerInNavigationStackFromWindow {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    while (frontView) {
        if([frontView subviews].count > 0)
            frontView = [[frontView subviews] firstObject];
        else
            break;
    }
    
    id nextResponder = [frontView nextResponder];
    
    while ((nextResponder = [nextResponder nextResponder])) {
        if ([nextResponder isKindOfClass: [UIViewController class]]) {
            if([(UIViewController *)nextResponder navigationController])
                break;
        }
    }
    return nextResponder;
}

@end
