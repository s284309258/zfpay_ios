//
//  UIViewController+NavFindVC.m
//  MXPay
//
//  Created by yang.xiangbao on 15/8/1.
//  Copyright (c) 2015年 moxiangroup. All rights reserved.
//

#import "UIViewController+NavFindVC.h"

@implementation UIViewController (NavFindVC)

#pragma mark - 在导航栏栈中查找置顶的类实例
- (UIViewController *)findClass:(NSString *)cls
{
    if (![cls isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"class == %@",NSClassFromString(cls)];
    NSArray *tmp = [self.navigationController.childViewControllers filteredArrayUsingPredicate:pre];
    if (tmp.count > 0) {
        return tmp[0];
    }
    
    return nil;
}

#pragma mark - 在导航栏栈中查找后面的类实例
- (UIViewController *)findLastClass:(NSString *)cls
{
    if (![cls isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"class == %@",NSClassFromString(cls)];
    NSArray *tmp = [self.navigationController.childViewControllers filteredArrayUsingPredicate:pre];
    if (tmp.count > 0) {
        return [tmp lastObject];
    }
    
    return nil;
}

#pragma mark - 通过协议名字查找 Controller
- (instancetype)findClssWithProtocol:(Protocol *)protocol {
    if (!protocol) {
        return nil;
    }
    
    NSString *name = NSStringFromProtocol(protocol);
    return [self findClass:name];
}

@end
