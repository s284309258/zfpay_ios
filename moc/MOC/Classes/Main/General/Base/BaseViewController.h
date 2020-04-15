//
//  BaseViewController.h
//  MoPal_Developer
//
//  所有controller的基类
//  Created by litiankun on 15/1/29.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@class MXBackButton;

#define NavigationBarViewTag 1001

typedef NS_ENUM(NSInteger, BoundsType) {
    Email=0,//默认从0开始
    Mobile
};
@interface BaseViewController : UIViewController<UITextFieldDelegate>

// 实例化Controller
- (id)initWithNibName:(NSString *)nibNameOrNil object:(id)object;

@property (nonatomic,retain) UIView *activtyTextField; //当前操作的对象;

@property (nonatomic,strong) UIButton *navBarRightBtn; //导航栏右侧按钮
// 是否显示返回按钮
@property (nonatomic,assign) BOOL isShowBackButton ;
// 返回标题
@property (nonatomic, copy) NSString *backTitle;

// 返回按钮
@property (nonatomic, strong) UIButton *backBut;


// 返回事件
- (void)backAction:(id)sender;

//如果有修改的话会有提示，是否直接退出
- (void)unchangedBackAction:(id)sender isChanged:(BOOL)isChange;

// 隐藏键盘
- (void)hideKeyboard;

// 是否有网络
- (BOOL)isReachNetwork;

- (void)setupInteractive;

- (void)initBaseView;

//设置导航条标题
-(void)setNavBarTitle:(NSString *)title;

//设置右键
-(void)setNavBarRightBtnWithTitle:(NSString *)title andImageName:(NSString *)imgName;

// 重设导航栏上按钮控件显示
-(void)resetNavBarBtnsWithLeftBtnImg:(NSString *)leftBtnImg rigBtnImg:(NSString *)rigBtnImg;

//设置按钮透明度
-(void)resetBtnsAlpha:(CGFloat)alpha;

// 控制点击
- (void)setNavBarRightBtnEnabled:(BOOL)enabled;

//右键点击事件
-(void)navBarRightBtnAction:(id)sender;

//子类如果需要自己控制是否滑动返回，重写该方法,默认开启
-(BOOL)viewWillPopByGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer;

-(void)setNavBarLeftBtnImg:(NSString *)imgName;

- (void)setNavBarTitle:(NSString *)title color:(UIColor* )color;

//设置右键
-(void)setNavBarRightBtnTitleColor:(UIColor *)color backColor:(UIColor *)backColor title:(NSString*)title;

///子类继承
- (void)updateForLanguageChanged;
@end
