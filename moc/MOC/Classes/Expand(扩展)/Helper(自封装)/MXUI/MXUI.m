//
//  MXUI.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 16/3/10.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import "MXUI.h"

@implementation MXUI

+ (UILabel *)labelFont:(UIFont *)font textColor:(UIColor *)color {
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectZero];
    lbl.textColor = color;
    lbl.font = font;
    
    return lbl;
}

+ (UITextField *)textFieldPlaceholder:(NSString *)placeholder
{
    @autoreleasepool {
        UITextField *field        = [[UITextField alloc] initWithFrame:CGRectZero];
        field.textAlignment       = NSTextAlignmentLeft;
        field.backgroundColor     = [UIColor whiteColor];
        UIView *view       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
        field.leftView     = view;
        field.leftViewMode = UITextFieldViewModeAlways;
        field.font = [UIFont font14];
        NSMutableParagraphStyle *style = [field.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
        style.minimumLineHeight = 15;
        field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName : [UIColor moPlaceholderLight], NSFontAttributeName : [UIFont font14], NSParagraphStyleAttributeName : style}];
        
        return field;
    }
}

+ (UIButton *)buttonImage:(NSString *)name target:(id)target  action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
