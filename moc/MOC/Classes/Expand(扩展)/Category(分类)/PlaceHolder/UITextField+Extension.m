//
//  UITextField+Extension.m
//  RatelBrother
//
//  Created by mac on 2019/9/27.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "UITextField+Extension.h"
#import <objc/runtime.h>

@implementation UITextField (Extension)
- (void)setCustomPlaceholderFont:(UIFont *)font {
    const char *key = "_placeholderLabel";
    Ivar ivar = class_getInstanceVariable([self class], key);
    UILabel *placeholderLabel = object_getIvar(self, ivar);
    if([placeholderLabel isKindOfClass:[UILabel class]]) {
        placeholderLabel.font = font;
    }
}

- (void)setCustomPlaceholderColor:(UIColor *)color {
    const char *key = "_placeholderLabel";
    Ivar ivar = class_getInstanceVariable([self class], key);
    UILabel *placeholderLabel = object_getIvar(self, ivar);
    if([placeholderLabel isKindOfClass:[UILabel class]]) {
        placeholderLabel.textColor = color;
    }
}
@end
