//
//  AutoChangeLabelCount.m
//  MoPal_Developer
//
//  Created by aken on 15/2/2.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "AutoChangeLabelCount.h"
#import "YYTextView.h"

@implementation AutoChangeLabelCount

#pragma mark - 限制字数控制1
+ (void)changeLimitLabelCount:(id)textField limitLabel:(UILabel*)limitLabel limitNumber:(NSInteger)total {
    
    NSInteger textCount=0;
    if ([textField isKindOfClass:[UITextField class]]) {
        textCount=((UITextField*)textField).text.length;
    }else if ([textField isKindOfClass:[UITextView class]]) {
        textCount=((UITextView*)textField).text.length;
    }
    limitLabel.text=[NSString stringWithFormat:@"%@",@(total - textCount)];
}

#pragma mark - 限制字数控制2
+ (void)changeLimitLabelCountForChineseHightedInput:(id)textField limitLabel:(UILabel*)limitLabel limitNumber:(NSInteger)total {
    
    NSInteger textCount=0;
    if ([textField isKindOfClass:[UITextField class]]) {
        textCount=((UITextField*)textField).text.length;
    }else if ([textField isKindOfClass:[UITextView class]]) {
        textCount=((UITextView*)textField).text.length;
    }
    // 一个中文两个字节
    limitLabel.text=[NSString stringWithFormat:@"%@",@(total - (textCount + 1 )/2)];
    
}

+(void)textEditChanged:(id)sender leftLimitLabel:(UILabel*)limitLabel  limitNumber:(NSInteger)titleLimitNumber {
    
    NSString *toBeString = nil;
    id textField=nil;
    
    if ([sender isKindOfClass:[UITextField class]]) {
        toBeString=((UITextField*)sender).text;
        textField=((UITextField*)sender);
    }else if ([sender isKindOfClass:[UITextView class]]) {
        toBeString=((UITextView*)sender).text;
        textField=((UITextView*)sender);
    }
    
    // 键盘输入模式
    NSString *lang = [[textField textInputMode] primaryLanguage];
    
    // 简体中文输入，包括简体拼音，健体五笔，简体手写
    if ([lang isEqualToString:@"zh-Hans"] || [lang isEqualToString:@"zh-Hant"]) {
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > titleLimitNumber) {
                if ([sender isKindOfClass:[UITextField class]]) {
                    ((UITextField*)sender).text = [toBeString substringToIndex:titleLimitNumber];
                }else if ([sender isKindOfClass:[UITextView class]]) {
                    ((UITextView*)sender).text = [toBeString substringToIndex:titleLimitNumber];
                }
                
                [self changeLimitLabelCount:textField limitLabel:limitLabel limitNumber:titleLimitNumber];
            }else{
                [self changeLimitLabelCount:textField limitLabel:limitLabel limitNumber:titleLimitNumber];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            if ((toBeString.length + 1)/2 > titleLimitNumber) {
                return;
            }else{
                [self changeLimitLabelCountForChineseHightedInput:textField limitLabel:limitLabel limitNumber:titleLimitNumber];
            }
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > titleLimitNumber) {
            if ([sender isKindOfClass:[UITextField class]]) {
                ((UITextField*)sender).text = [toBeString substringToIndex:titleLimitNumber];
            }else if ([sender isKindOfClass:[UITextView class]]) {
                ((UITextView*)sender).text = [toBeString substringToIndex:titleLimitNumber];
            }
            [self changeLimitLabelCount:textField limitLabel:limitLabel limitNumber:titleLimitNumber];
            
        }else{
            [self changeLimitLabelCount:textField limitLabel:limitLabel limitNumber:titleLimitNumber];
        }
    }
    
}

+(void)textEditChanged:(id)sender increaseLimitLabel:(UILabel*)limitLabel  limitNumber:(NSInteger)titleLimitNumber {

    id textField=sender;
    NSInteger textCount=0;
    if ([textField isKindOfClass:[UITextField class]]) {
        textCount=[StringUtil  asciiLengthOfString:((UITextField*)textField).text];
    }else if ([textField isKindOfClass:[UITextView class]]) {
        textCount=[StringUtil  asciiLengthOfString:((UITextView*)textField).text];
    }else if([textField isKindOfClass:NSClassFromString(@"YYTextView")]){
        YYTextView* tv = (YYTextView*)textField;
        textCount = tv.textLayout.range.length-1;
    }
   
    
    if (textCount >titleLimitNumber) {
        limitLabel.textColor = [UIColor redColor];
    }else{
        limitLabel.textColor = [UIColor moPlaceholderLight];
    }
    
    limitLabel.text = [NSString stringWithFormat:@"%@",@(textCount)];
    
     textCount++;
}
@end
