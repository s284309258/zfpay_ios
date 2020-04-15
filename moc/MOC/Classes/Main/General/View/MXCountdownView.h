//
//  MXCountdownView.h
//  MoPal_Developer
//
//  倒计时：用于注册、重置密码获取验证码
//  Created by aken on 15/2/5.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CountdownState) {
    
    CountdownViewSendBeforeGray = 0,
    CountdownViewSendBeforePurge,
    CountdownViewSendBefore      ,
    CountdownViewSendIng       ,
    CountdownViewSendAfterGray,
    CountdownViewSendAfter    ,
    
    //yangjiale
    CountdownViewSendBeforeNewWhite,
    CountdownViewSendNewBefore,
    CountdownViewSendNewBeforePurge,
    CountdownViewSendNewIng       ,
    CountdownViewSendNewAfterGray,
    CountdownViewSendNewAfter,
    
    CountdownChangePhoneNumberState
};


typedef NS_ENUM(NSInteger, FromClassType) {
    FromForgetPasswordType = 0,
    FromLoginRegisterType = 1
};

@protocol MXCountdownViewDelegate;

@interface MXCountdownView : UIView

@property (nonatomic, weak) id<MXCountdownViewDelegate>delegate;

/// 按钮正常情况下的背景颜色 add by yang.xiangbao 2015/8/11
@property (nonatomic, strong) UIColor *buttonNormalBackColor;
/// 按钮选中后的背景颜色 add by yang.xiangbao 2015/8/11
@property (nonatomic, strong) UIColor *buttonSelectBackColor;
/// 按钮正常情况下的标题颜色 add by yang.xiangbao 2015/8/14
@property (nonatomic, strong) UIColor *normalTitleColor;
/// 按钮选中后的标题颜色 add by yang.xiangbao 2015/8/14
@property (nonatomic, strong) UIColor *selectTitleColor;

@property (nonatomic) CountdownState countdownViewState;

@property (nonatomic) BOOL isBlank;

@property (nonatomic ,assign) FromClassType fromClassType;

@property (nonatomic ,weak  ) UIView *verifyView;

// 设置标题
- (void)setCountdownViewTitle:(NSString*)title;

//
- (instancetype)initWithFrame:(CGRect)frame timeInterval:(NSInteger)seconds;

// 开始倒计时
- (void)start;

// 可用/禁用
- (void)enableCountdownView:(BOOL)enable;

-(void)setCountdownViewState:(CountdownState)state;

/**
 *  一定要调用这个方法，会有强引用
 */
- (void)clear;

@end

@protocol MXCountdownViewDelegate <NSObject>

@optional
// 开始网络请求
- (void)startToRequest;

// 计数
//- (void)

@end
