//
//  UIViewController+FormatPhoneNumber.h
//  MoPal_Developer
//
//  Created by yangjiale on 9/12/15.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (FormatPhoneNumber)

//3-4-4格式手机号输入
/*
 @param 
 previousSelection:获取到光标的位置textField.selectedTextRange
 previousTextFieldContent:textField的文本内容
 */
- (void)formatPhone:(UITextField *)textField previousTextFieldContent:(NSString *)previousTextFieldContent previousSelection:(UITextRange *)previousSelection;

@end
