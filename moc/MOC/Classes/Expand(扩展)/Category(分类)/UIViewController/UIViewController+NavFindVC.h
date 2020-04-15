//
//  UIViewController+NavFindVC.h
//  MXPay
//
//  在导航栏栈中查找某个类
//
//  Created by yang.xiangbao on 15/8/1.
//  Copyright (c) 2015年 moxiangroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavFindVC)

/**
 *  在导航栏栈中查找置顶的类实例
 *
 *  @param cls 需要查找的类，没有查找的返回nil,
 *
 *  @return 类实例
 */
- (UIViewController *)findClass:(NSString *)cls;

/**
 *  在导航栏栈中查找后面的类实例
 *
 *  @param cls 需要查找的类，没有查找的返回nil,
 *
 *  @return 类实例
 */
- (UIViewController *)findLastClass:(NSString *)cls;

/**
 *  通过协议名字查找 Controller
 *
 *  @param protocol 协议名字
 *
 *  @return 实例
 */
- (UIViewController *)findClssWithProtocol:(Protocol *)protocol;

@end
