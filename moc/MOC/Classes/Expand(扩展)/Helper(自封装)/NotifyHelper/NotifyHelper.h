//
//  Notify.h
//  Moxian
//
//  Created by litiankun on 13-11-22.
//  Copyright (c) 2013年 Moxian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"


/// UIAlertView提示框的回调函数,返回参数为YES,表示点击确定,返回参数为NO,表示点击取消
typedef void(^AlertBlock)(NSInteger buttonIndex);

@interface NotifyHelper : MBProgressHUD

/**
 * (NotifyHelper)单列模式:实例化对象
 */
+ (NotifyHelper*)sharedInstance;

+ (void)showHUD;
+ (void)hideHUD;
/**
 * HUD显示进度提示消息
 * @param view 
 * @param animated
 */
+(void)showAlertProgressDialogAddedTo:(UIView*)view animated:(BOOL)animated;

/**
 * HUD隐藏进度提示消息
 * @param view
 * @param animated
 */
+(void)hideAlertProgressDialogForView:(UIView *)view animated:(BOOL)animated;


/**
 * 显示状态时同时加入描述内容
 * @param view
 * @param text
 * @param animated
 */
+ (void)showHUDAddedTo:(UIView *)view makeText:(NSString *)text animated:(BOOL)animated ;

/**
 * HUD显示短时间消息提示
 * @param text
 */
+(void)showMessageWithMakeText:(NSString*)text;

/**
 * HUD显示指定时间消息提示,过时自动消失
 * @param text
 * @param del 指定显示秒数
 */
+(void)showMessageWithMakeText:(NSString*)text delay:(int)del ;

/**
 *  同上，增加superView
 */
+ (MBProgressHUD *)showMessageWithMakeText:(NSString*)text onView:(UIView *)view delay:(int)del ;

/**
 *  显示魔线加载中的Gif图片
 *
 */
+ (MBProgressHUD *)showMXLoadingHUDAddedTo:(UIView *)view animated:(BOOL)animated;

/**
 *  显示自定义View
 *
 */
+ (MBProgressHUD *)showMXCustomView:(UIView *)customView animated:(BOOL)animated;


/**
 *  显示alertView 无标题
 *
 *  @param message           提示
 *  @param cancelButtonTitle 取消
 *  @param otherButtonTitle  其它
 *  @param _block            回调
 */
-(void)showAlertViewWithMessage:(NSString*)message
              cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle
                     completion:(AlertBlock)_block;

/**
 *  显示alertView 无标题
 *
 *  @param title             标题
 *  @param message           提示
 *  @param cancelButtonTitle 取消
 *  @param otherButtonTitle  其它
 *  @param _block            回调
 */
-(void)showAlertViewWithTitle:(NSString*)title
              message:(NSString*)message
              cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle
                     completion:(AlertBlock)_block;

@end
