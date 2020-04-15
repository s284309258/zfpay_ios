//
//  UIViewController+NavItem.h
//  MXPay
//
//  导航栏按钮,统一初始化
//
//  Created by yang.xiangbao on 15/8/1.
//  Copyright (c) 2015年 moxiangroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+ActionBlock.h"

@interface UIViewController (NavItem)

/**
 *  统一初始化，导航栏按钮
 *
 *  @param frame  大小
 *  @param title  标题
 *  @param action 事件
 *
 *  @return UIButton 实例
 */
- (UIButton *)navButtonFrame:(CGRect)frame
                       title:(NSString *)title
                      action:(SEL)action;

- (void)setDefaultBackBnt:(ActionBlock)block;

@end
