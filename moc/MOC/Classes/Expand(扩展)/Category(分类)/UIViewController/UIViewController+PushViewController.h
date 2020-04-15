//
//  UIViewController+PushViewController.h
//  MoPal_Developer
//
//  Created by Fly on 15/10/24.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PushViewController)

- (UIViewController*)isExistToViewController:(UIViewController*)viewController;

- (NSArray*)pushToNotExistViewController:(UIViewController*)viewController;

@end
