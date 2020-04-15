//
//  UIScrollView+HiddenKeyboard.h
//  MoPromo_Develop
//
//  Created by fly on 15/12/29.
//  Copyright © 2015年 MoPromo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (HiddenKeyboard)

@property (strong, nonatomic) UITapGestureRecognizer* hiddenTap;
@property (strong, nonatomic) NSNumber* isNoticeOberver;

/**
 *  添加监听键盘的通知，需要手动调用removeHiddenKeyboardNotification
 */
- (void)addHiddenKeyboardNotification;
/**
 *  移除监听键盘的通知
 */
- (void)removeHiddenKeyboardNotification;

@end
