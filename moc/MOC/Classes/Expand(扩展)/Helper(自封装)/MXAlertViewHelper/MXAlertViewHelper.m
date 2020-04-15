//
//  MXAlertViewHelper.m
//  MoPromo
//
//  所有Alert出来的弹出框，都可以用此类
//  Created by litiankun on 14-6-12.
//  Copyright (c) 2014年 MOPromo. All rights reserved.
//

#import "MXAlertViewHelper.h"


@interface MXAlertViewHelper()

@end

@implementation MXAlertViewHelper

+ (MXAlertViewHelper*)sharedInstance {
    
    static id sharedInstanceNH;
    static dispatch_once_t onceNH;
    dispatch_once(&onceNH, ^{
        sharedInstanceNH = [[[self class] alloc] init];
    });
    return sharedInstanceNH;
}
- (id)init{
    if(!(self = [super init])){
        return nil;
    }
    return self;
}

// 显示弹出框
+ (void)showAlertViewWithMessage:(NSString*)message {
    
    [MXAlertView showAlertWithTitle:Lang(@"提示")
                         message:message
                         cancelTitle:Lang(@"确定")
                         otherTitle:nil
                         completion:^(BOOL cancelled, NSInteger buttonIndex) {}];
}


#pragma mark -  显示弹出框-带title
+ (void)showAlertViewWithMessage:(NSString*)message withTitle:(NSString*)title {
    
    [MXAlertView showAlertWithTitle:title
                            message:message
                        cancelTitle:Lang(@"确定")
                         otherTitle:nil
                         completion:^(BOOL cancelled, NSInteger buttonIndex) {}];
}

#pragma mark - 显示弹出框 - 带回函数
+ (void)showAlertViewWithMessage:(NSString*)message completion:(MXAlertViewCompletionBlock)completion {
    
    [MXAlertView showAlertWithTitle:Lang(@"提示") message:message
                         cancelTitle:Lang(@"取消")
                         otherTitle:Lang(@"确定")
                         completion:completion];
    
    
}
#pragma mark - 显示弹出框 - 带回函数
+ (void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message  completion:(MXAlertViewCompletionBlock)completion {
    
    [MXAlertView showAlertWithTitle:title message:message
                        cancelTitle:Lang(@"取消")
                         otherTitle:Lang(@"确定")
                         completion:completion];
    
}
@end

@implementation MXAlertViewHelper(MXExtendedAlertView)

/**
 * 显示弹出框:默认的标题是->提示(Note) 在ios8.3上，键盘未消失即返回并且有Alertview的情况下，返回键盘会闪现一下，该bug使用8.0后的UIAlertController解决,其他系统仍然使用MXAlertView
 * @param   message 显示内容
 */
+ (void)showAlertViewWithMessage:(NSString*)message title:(NSString*)title  okTitle:(NSString*)okTitle cancelTitle:(NSString*)cancelTitle completion:(MXAlertViewCompletionBlock)completion {
    NSString* titleString = title;
    if (title == nil) {
        titleString= Lang(@"提示");
    }

    if(IOS8_Later) {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        if(cancelTitle) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle ?: @"" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if (completion) {
                    completion(YES, 0);
                }
            }];
            [alertCtrl addAction:cancelAction];
        }
        
        if(okTitle) {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle ?: @""  style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if (completion) {
                    completion(NO, 1);
                }
            }];
            [alertCtrl addAction:okAction];
        }
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertCtrl animated:YES completion:nil];
    } else {
        [MXAlertView showAlertWithTitle: titleString
                                message:message
                            cancelTitle:cancelTitle
                             otherTitle:okTitle
                             completion:completion];
    }

}


+ (void)showAlertViewWithTextFiled:(NSString*)conent title:(NSString*)title  okTitle:(NSString*)okTitle cancelTitle:(NSString*)cancelTitle completion:(MXAlertViewWithTextCompletionBlock)completion {
    NSString* titleString = title;
    if (title == nil) {
        titleString= Lang(@"提示");
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = conent;
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (completion) {
            UITextField *textField = alertController.textFields.firstObject;
            completion(textField.text, 0);
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}

+ (void)showAlertViewWithTextFiled:(NSString*)title msg:(NSString*)msg placeholder:(NSString*)placeholder okTitle:(NSString*)okTitle cancelTitle:(NSString*)cancelTitle keyboardType:(UIKeyboardType)keyboardType completion:(MXAlertViewWithTextCompletionBlock)completion {
    NSString* titleString = title;
    if (title == nil) {
        titleString= Lang(@"提示");
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = placeholder;
        textField.keyboardType = keyboardType;
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (completion) {
            UITextField *textField = alertController.textFields.firstObject;
            completion(textField.text, 0);
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}
@end

