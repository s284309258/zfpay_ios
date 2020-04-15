//
//  VerityCodeView2.h
//  JiuJiuEcoregion
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextCaptchaView : UIView

@property (nonatomic , strong) CompletionBlock getText;

@property (nonatomic , strong) CompletionBlock sendCodeBlock;

@property (nonatomic, strong) UITextField     *tf;

-(void)isHiddenLine:(BOOL)hidden;

-(void)reloadTitle:(NSString *) title placeHolder:(NSString *)placeHolder;

-(void)reloadImg:(NSString *) image  placeHolder:(NSString *)placeHolder;

-(void)reloadplaceHolder:(NSString *)placeHolder;

-(void)startCountDowView;

-(void)showBorder;

-(void)setLeftPadding:(NSInteger)leftPadding;

-(void)showDownLine:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
