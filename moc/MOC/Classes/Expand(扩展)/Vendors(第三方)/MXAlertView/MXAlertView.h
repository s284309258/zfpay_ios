//
//  MXAlertView.h
//  MXAlertViewDemo
//
//  Created by Alex Jarvis on 25/09/2013.
//  Copyright (c) 2013 Panaxiom Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MXAlertViewCompletionBlock)(BOOL cancelled, NSInteger buttonIndex);

@interface MXAlertView : UIViewController

@property (nonatomic, getter = isVisible) BOOL visible;

+ (instancetype)showAlertWithTitle:(NSString *)title;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                        completion:(MXAlertViewCompletionBlock)completion;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        completion:(MXAlertViewCompletionBlock)completion;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        otherTitle:(NSString *)otherTitle
                        completion:(MXAlertViewCompletionBlock)completion;

/**
 * @param otherTitles Must be a NSArray containing type NSString, or set to nil for no otherTitles.
 */
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                       otherTitles:(NSArray *)otherTitles
                        completion:(MXAlertViewCompletionBlock)completion;


+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        otherTitle:(NSString *)otherTitle
                       contentView:(UIView *)view
                        completion:(MXAlertViewCompletionBlock)completion;
/**
 * @param otherTitles Must be a NSArray containing type NSString, or set to nil for no otherTitles.
 */
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                       otherTitles:(NSArray *)otherTitles
                       contentView:(UIView *)view
                        completion:(MXAlertViewCompletionBlock)completion;

- (void)show;
/**
 * Adds a button to the receiver with the given title.
 * @param title The title of the new button
 * @return The index of the new button. Button indices start at 0 and increase in the order they are added.
 */
- (NSInteger)addButtonWithTitle:(NSString *)title;

/**
 * Dismisses the receiver, optionally with animation.
 */
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

/**
 * By default the alert allows you to tap anywhere around the alert to dismiss it.
 * This method enables or disables this feature.
 */
- (void)setTapToDismissEnabled:(BOOL)enabled;

@end
