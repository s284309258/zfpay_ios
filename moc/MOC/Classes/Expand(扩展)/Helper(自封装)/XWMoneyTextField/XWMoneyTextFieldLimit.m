//
//  XWMoneyTextFieldLimit.m
//  XWMoneyTextField
//
//  Created by smile.zhang on 16/3/10.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "XWMoneyTextFieldLimit.h"

@interface XWMoneyTextFieldLimit ()
@property (nonatomic, assign) NSInteger limitInteger;
@end

@implementation XWMoneyTextFieldLimit

- (instancetype)init{
    if (self = [super init]) {
        _max = @"99999.99";
        
    }
    return self;
}

//判断是否为整形：
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为小数点：
- (BOOL)isDecimalPoint:(NSString*)string{
    return [string isEqualToString:@"."];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    static BOOL isHaveDian = NO;
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    
    if ([string length] > 0) {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if (textField.text.length == 0 && [string isEqualToString:@"."]) {
            string = @"0.";
            textField.text = string;
            isHaveDian = YES;
            [self valueChange:textField];
            
            return NO;
        }
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            //处理全选状态
            if(textField.text.length > 0 && [textField textInRange:textField.selectedTextRange].length == textField.text.length) {
                textField.text = string;
                [self valueChange:textField];
                return NO;
            }
            
            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHaveDian)//text中还没有小数点
                {
                    if(textField.text.length - range.location <= 2) { //小数点插入后需确保后面的小数个数
                        isHaveDian = YES;
                        return YES;
                    } else {
                        return NO;
                    }
                } else { //已经输入过小数点了
                    //[textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            } else {
                NSRange ran = [textField.text rangeOfString:@"."];
                if(!isHaveDian) { //即将插入的数字为整数部分
                    return textField.text.length + 1 <= self.limitInteger;
                } else if(range.location <= ran.location) {
                    return ran.location < self.limitInteger;
                } else { //即将插入的数字为整数部分
                    //判断小数点后的位数
                    NSInteger decimalCount = [[self.max componentsSeparatedByString:@"."] lastObject].length;
                    return !(textField.text.length-1-ran.location >= decimalCount);
                }
            }
        } else {//输入的数据格式不正确
            //[textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    } else
    {
        //删除'.'要确保整数部分不能超过limitInteger
        if([[textField.text substringWithRange:range] isEqualToString:@"."]) {
            if(textField.text.length - 1 > self.limitInteger) {
                NSString *temp = [textField.text stringByReplacingCharactersInRange:range withString:@""];
                temp = [temp substringToIndex:self.limitInteger];
                textField.text = temp;
                [self valueChange:textField];
                return NO;
            }
        }
        return YES;
    }
}

#pragma mark TextFieleActions
- (void)valueChange:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(valueChange:)]) {
        [_delegate valueChange:sender];
    }
}

- (NSInteger)limitInteger {
    if(_max.length == 0) {
        return NSIntegerMax;
    }
    
    if([_max rangeOfString:@"."].location == NSNotFound) {
        return _max.length;
    } else {
        NSRange range = [_max rangeOfString:@"."];
        return range.location;
    }
}
@end
