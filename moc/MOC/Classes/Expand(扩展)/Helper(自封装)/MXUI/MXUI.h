//
//  MXUI.h
//  MoPal_Developer
//
//  Created by yang.xiangbao on 16/3/10.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MXUI : NSObject

+ (UILabel *)labelFont:(UIFont *)font textColor:(UIColor *)color;

+ (UITextField *)textFieldPlaceholder:(NSString *)placeholder;

+ (UIButton *)buttonImage:(NSString *)name target:(id)target  action:(SEL)action;

@end
