//
//  InvitationCodeView.h
//  ScanPay
//
//  Created by mac on 2019/7/15.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InvitationCodeView : UIView

@property (nonatomic) NSInteger    padding;

@property (nonatomic, strong) UITextField     *tf;

@property (nonatomic , strong) CompletionBlock getText;

@property (nonatomic , strong) NSString* regex;


- (instancetype)initWithFrame:(CGRect)frame ;
// 标题 输入框
-(void)reloadTitle:(NSString *) title placeHolder:(NSString *)placeHolder;
// 图片 输入框
-(void)reloadImg:(NSString *) image  placeHolder:(NSString *)placeHolder;
// 输入框
-(void)reloadPlaceHoder:(NSString *)placeHolder;

-(void)isHiddenLine:(BOOL)hidden;

-(void)showBorder;

-(void)setLeftPadding:(NSInteger)padding;

-(void)showDownLine:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
