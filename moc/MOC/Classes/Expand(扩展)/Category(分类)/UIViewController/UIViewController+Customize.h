//
//  UIViewController+Customize.h
//  meiliyue
//
//  Created by fly on 12-12-14.
//  Copyright (c) 2012年 sjxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Customize)

- (BOOL)isModal;
- (BOOL)isNavRootViewController;
- (void)closeViewAnimated:(BOOL)animated;


- (UIButton*)buttonWithNavBackStyle:(NSString*)strTitle;
- (UIButton*)buttonWithConfirmStyle:(NSString*)strTitle;
- (UIButton*)buttonWithConfirmStyle:(NSString*)strTitle imageName:(NSString *)strImgName;
- (UIButton*)buttonWithIcon:(NSString*)strImgName;
- (UIView *)viewWithConfirmStyle:(NSString *)strTitle iconImgName:(NSString *)strIconImgName;


/**
 *  自定义的rightBarButtonItem，调用confirmBtnClick:方法
 *
 *  @param strTitle 按钮的名称
 */
- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle;
- (void)addNavConfirmButtonWithIconName:(NSString *)strImgName;

- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle backGroundImgName:(NSString *)strImgName;
- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle iconImageName:(NSString *)strIconImgName;
- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle
                               iconImageName:(NSString *)strIconImgName
                         withBackGroundImage:(NSString*)bgImg;


- (void)removeNavLeftButton;
//- (void)addNavLeftButtonWithDefaultAction:(NSString*)strTitle;
//- (void)addNavLeftButtonWithDefaultAction:(NSString*)strTitle withBackgroundImage:(NSString *)bgImgName;
//- (void)addNavLeftButtonWithDefaultAction:(NSString*)strTitle iconImageName:(NSString *)strIconImgName;

- (void)setConfirmButtonTitle:(NSString *)strTitle;
- (void)setConfirmButtonEnabled:(BOOL)nEnabled;

- (void)confirmBtnClick:(id)sender;
- (void)backBtnClick:(id)sender;
- (void)navLeftBtnItemClick:(id)sender;

@end
