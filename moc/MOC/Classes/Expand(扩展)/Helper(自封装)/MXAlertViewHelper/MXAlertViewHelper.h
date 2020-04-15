//
//  MXAlertViewHelper.h
//  MoPromo
//
//  所有Alert出来的弹出框，都可以用此类
//  Created by litiankun on 14-6-12.
//  Copyright (c) 2014年 MOPromo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXAlertView.h"
typedef void(^MXAlertViewWithTextCompletionBlock)(NSString *text, NSInteger buttonIndex);

@interface MXAlertViewHelper : NSObject

+ (MXAlertViewHelper*)sharedInstance;
/**
 * 显示弹出框:默认的标题是->提示(Note)
 * @param   message 显示内容
 */
+ (void)showAlertViewWithMessage:(NSString*)message;

/**
 * 显示弹出框:带标题
 * @param   message 显示内容
 * @param   title   标题
 */
+ (void)showAlertViewWithMessage:(NSString*)message withTitle:(NSString*)title;

/**
 * 显示弹出框:带回函数
 * @param   message         显示内容
 * @return  completion      MXAlertView的回调函数
 */
+ (void)showAlertViewWithMessage:(NSString*)message completion:(MXAlertViewCompletionBlock)completion;

#pragma mark - 显示弹出框 - 带回函数
+ (void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message  completion:(MXAlertViewCompletionBlock)completion;

@end

@interface MXAlertViewHelper(MXExtendedAlertView)

/**
 * 显示弹出框:默认的标题是->提示(Note)
 * @param   message 显示内容
 */
+ (void)showAlertViewWithMessage:(NSString*)message title:(NSString*)title okTitle:(NSString*)okTitle cancelTitle:(NSString*)cancelTitle completion:(MXAlertViewCompletionBlock)completion;


+ (void)showAlertViewWithTextFiled:(NSString*)conent title:(NSString*)title  okTitle:(NSString*)okTitle cancelTitle:(NSString*)cancelTitle completion:(MXAlertViewWithTextCompletionBlock)completion ;

+ (void)showAlertViewWithTextFiled:(NSString*)title msg:(NSString*)msg placeholder:(NSString*)placeholder okTitle:(NSString*)okTitle cancelTitle:(NSString*)cancelTitle keyboardType:(UIKeyboardType)keyboardType completion:(MXAlertViewWithTextCompletionBlock)completion;
@end
