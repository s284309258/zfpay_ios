//
//  UIViewController+PushViewController.m
//  MoPal_Developer
//
//  Created by Fly on 15/10/24.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import "UIViewController+PushViewController.h"

@implementation UIViewController (PushViewController)

- (UIViewController*)isExistToViewController:(UIViewController*)viewController{
    if (!self.navigationController) {
        NSLog(@"不存在 navigationController");
        return nil;
    }
    NSArray *viewControllers = self.navigationController.viewControllers;
    UIViewController *isExistPushedVC = nil;
    for (UIViewController *subVC in viewControllers) {
        if ([subVC isKindOfClass:[viewController class]]) {
            isExistPushedVC = subVC;
            break;
        }
    }
    return isExistPushedVC;
}

- (NSArray*)pushToNotExistViewController:(UIViewController*)viewController{
    if (!self.navigationController) {
        return nil;
    }
    UIViewController *isExistPushedVC = [self isExistToViewController:viewController];
    if (isExistPushedVC) {
        NSLog(@"is popToViewController");
        NSArray* popViewControllers = [self.navigationController popToViewController:isExistPushedVC animated:YES];
        return popViewControllers;
    }else{
        NSLog(@"is pushViewController");
        [self.navigationController pushViewController:isExistPushedVC animated:YES];
        return nil;
    }
}

@end
