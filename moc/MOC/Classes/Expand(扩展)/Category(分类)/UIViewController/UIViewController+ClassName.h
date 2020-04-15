//
//  UIViewController+ClassName.h
//  MXPay
//
//  Created by yang.xiangbao on 15/8/1.
//  Copyright (c) 2015年 moxiangroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ClassName)

/**
 *  通过类名生成 UIViewController
 *
 *  @param name 类名
 *
 *  @return 对应的Controller实例
 */
- (UIViewController *)controllerClassName:(NSString *)name;

@end
