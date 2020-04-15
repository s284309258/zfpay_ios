//
//  UIViewController+FormatPhoneNumber.m
//  login register
//
//  Created by yangjiale on 9/12/15.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import "UIViewController+FormatPhoneNumber.h"

@implementation UIViewController (FormatPhoneNumber)

-(void)formatPhone:(UITextField *)textField previousTextFieldContent:(NSString *)previousTextFieldContent previousSelection:(UITextRange *)previousSelection{
    NSUInteger targetCursorPosition =
    [textField offsetFromPosition:textField.beginningOfDocument
                       toPosition:textField.selectedTextRange.start];
    // nStr表示不带空格的号码
    NSString *nStr = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *preTxt = [previousTextFieldContent stringByReplacingOccurrencesOfString:@" " withString:@""];
    char editFlag = 0;  // 正在执行删除操作时为0，否则为1
    
    if (nStr.length <= preTxt.length) {
        editFlag = 0;
    } else {
        editFlag = 1;
    }
    
    // textField设置text
    if (nStr.length > 11) {
        textField.text = previousTextFieldContent;
        textField.selectedTextRange = previousSelection;
        return;
    }
    
    // 空格
    NSString *spaceStr = @" ";
    
    NSMutableString *mStrTemp = [NSMutableString new];
    int spaceCount = 0;
    if (nStr.length < 3 && nStr.length > -1) {
        spaceCount = 0;
    } else if (nStr.length < 7 && nStr.length > 2) {
        spaceCount = 1;
        
    } else if (nStr.length < 12 && nStr.length > 6) {
        spaceCount = 2;
    }
    
    for (int i = 0; i < spaceCount; i++) {
        if (i == 0) {
            [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(0, 3)], spaceStr];
        } else if (i == 1) {
            [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(3, 4)], spaceStr];
        } else if (i == 2) {
            [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(7, 4)], spaceStr];
        }
    }
    
    if (nStr.length == 11) {
        [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(7, 4)], spaceStr];
    }
    
    if (nStr.length < 4) {
        [mStrTemp appendString:[nStr substringWithRange:NSMakeRange(nStr.length - nStr.length % 3,
                                                                    nStr.length % 3)]];
    } else if (nStr.length > 3) {
        NSString *str = [nStr substringFromIndex:3];
        [mStrTemp appendString:[str substringWithRange:NSMakeRange(str.length - str.length % 4,
                                                                   str.length % 4)]];
        if (nStr.length == 11) {
            [mStrTemp deleteCharactersInRange:NSMakeRange(13, 1)];
        }
    }
    textField.text = mStrTemp;
    // textField设置selectedTextRange
    NSUInteger curTargetCursorPosition = targetCursorPosition;  // 当前光标的偏移位置
    if (editFlag == 0) {
        //删除
        if (targetCursorPosition == 9 || targetCursorPosition == 4) {
            curTargetCursorPosition = targetCursorPosition - 1;
        }
    } else {
        //添加
        if (curTargetCursorPosition == 9 || curTargetCursorPosition == 4) {
            curTargetCursorPosition = targetCursorPosition + 1;
        }
    }
    
    UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument]
                                                              offset:curTargetCursorPosition];
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition
                                                          toPosition:targetPosition]];
}


@end
