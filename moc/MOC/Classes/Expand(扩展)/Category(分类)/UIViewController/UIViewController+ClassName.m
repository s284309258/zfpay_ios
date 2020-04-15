//
//  UIViewController+ClassName.m
//  MXPay
//
//  Created by yang.xiangbao on 15/8/1.
//  Copyright (c) 2015年 moxiangroup. All rights reserved.
//

#import "UIViewController+ClassName.h"

@implementation UIViewController (ClassName)

#pragma mark - 通过类名生成 UIViewController
- (UIViewController *)controllerClassName:(NSString *)name
{
    if (![name isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    Class cls = NSClassFromString(name);
    UIViewController *vc = [[cls alloc] init];
    
    return vc;
}

@end
