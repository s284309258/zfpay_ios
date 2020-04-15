//
//  BaseViewController.m
//  MoPal_Developer
//
//  Created by litiankun on 15/1/29.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "BaseViewController.h"
#import "MXCache.h"
#import "MXAlertViewHelper.h"

//#import "MXReachabilityManager.h"

@interface BaseViewController () <UIGestureRecognizerDelegate>

/// 导航栏标题
@property (nonatomic, strong) UILabel         *navTitleLabel;
@property (nonatomic, strong) UIBarButtonItem *rightBarItem;

@end

@implementation BaseViewController
@synthesize activtyTextField;

- (void)dealloc {
    NSLog(@"dealloc-->%@",NSStringFromClass([self class]));
}

- (id)init {
    if (self = [super init]) {
        //self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil object:(id)object {
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        //self.hidesBottomBarWhenPushed = YES;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initBaseView];
    [self initBaseUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshUI];
    [[MoApp router] configureCurrentVC:self];
}

- (void)updateForLanguageChanged {
    
}

#pragma mark -滑动返回代理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 如果controller不是第一层则返回
    if ([gestureRecognizer isEqual:self.navigationController.interactivePopGestureRecognizer]) {
        if ([self viewWillPopByGestureRecognizer:gestureRecognizer] && ![self isEqual:[self.navigationController.viewControllers firstObject]]) {
            return YES;
        }
        return NO;
    }
    return YES;
}

//子类如果需要自己控制是否滑动返回，重写该方法,默认开启
- (BOOL)viewWillPopByGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self initInternalParam];
}

- (void)initInternalParam {
    activtyTextField = nil;
}

#pragma mark - UI
- (void)initBaseView {
    self.view.backgroundColor = [UIColor moBackground];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)initBaseUI {
    // 加载返回按钮
    [self setupNavBackItemStyle];
    
    if ([self.navigationController.viewControllers count] > 1) {
        self.isShowBackButton = YES;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateForLanguageChanged) name:LanguageChangedNotification object:nil];
}

#pragma mark - 返回按钮事件
// 返回事件
- (void)backAction:(id)sender {
    [self back];
}

- (void)unchangedBackAction:(id)sender isChanged:(BOOL)isChange{
    if (isChange) {
        NSString *msg = @"要放弃刚刚的修改么？";
        NSString *okTitle = @"继续编辑";
        NSString *cancellTitle = @"取消";
        @weakify(self);
        [MXAlertViewHelper showAlertViewWithMessage:msg title:@"" okTitle:okTitle cancelTitle:cancellTitle completion:^(BOOL cancelled, NSInteger buttonIndex) {
            @strongify(self);
            if (cancelled) {
                [self back];
            }
        }];
    } else {
        [self back];
    }
}

- (void)back {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setIsShowBackButton:(BOOL)isShowBackButton {
    
    _isShowBackButton = isShowBackButton;
    
    if (isShowBackButton) {
        
        self.backBut.hidden = !isShowBackButton;
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {      // return NO to disallow editing.
    activtyTextField = nil;
    activtyTextField = textField;
    return YES;
}

- (void)hideKeyboard {
    [activtyTextField resignFirstResponder];
}

#pragma mark - 是否有网络
//- (BOOL)isReachNetwork {
//    BOOL isReachable = [MXReachabilityManager isNetWorkReachable];
//    return isReachable;
//}

#pragma mark - ReWrite
- (void)setNavBarTitle:(NSString *)title {
    self.navTitleLabel.text = title;
    self.navigationItem.titleView = self.navTitleLabel;
}
- (void)setNavBarTitle:(NSString *)title color:(UIColor* )color{
    [self setNavBarTitle:title];
    self.navTitleLabel.textColor = color;
    
}
#pragma mark-rightBarButtonItem
- (void)setNavBarRightBtnWithTitle:(NSString *)title andImageName:(NSString *)imgName {
    if ([title length] > 0) {
        self.navBarRightBtn.hidden = NO;
        CGFloat width = [title sizeWithAttributes:@{NSFontAttributeName : _navBarRightBtn.titleLabel.font}].width;
        self.navBarRightBtn.frame = CGRectMake(0, 0, width > 60 ? 60 : width, 30);
        [self.navBarRightBtn setTitle:title forState:UIControlStateNormal];
        [self.navBarRightBtn setTitleColor:[UIColor moBlack] forState:UIControlStateNormal];
        self.rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.navBarRightBtn];
        self.navigationItem.rightBarButtonItem = self.rightBarItem;
    }
    
    if (imgName.length > 0) {
        self.navBarRightBtn.hidden = NO;
        self.navBarRightBtn.frame = CGRectMake(0, 0, 40, 30);
        [self.navBarRightBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        self.rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.navBarRightBtn];
        self.navigationItem.rightBarButtonItem = self.rightBarItem;
    }
}

#pragma mark - 重设导航栏上按钮控件显示
-(void)resetNavBarBtnsWithLeftBtnImg:(NSString *)leftBtnImg rigBtnImg:(NSString *)rigBtnImg
{
    //rigBtnImg不能为空 special by lhy 2015年10月29日
    UIImage *image = nil;
    if (self.navBarRightBtn && ![StringUtil isEmpty:rigBtnImg]) {
        self.navBarRightBtn.hidden = NO;
        image = [MXCache memoryValueForKey:rigBtnImg];
        if (!image) {
            image = [UIImage imageNamed:rigBtnImg];
            [MXCache setMemoryValue:image forKey:rigBtnImg];
        }
        
        [self.navBarRightBtn setImage:image forState:UIControlStateNormal];
    } else {
        self.navBarRightBtn.hidden = YES;
    }
    
    image = [MXCache memoryValueForKey:leftBtnImg];
    if (!image) {
        image = [UIImage imageNamed:leftBtnImg];
        [MXCache setMemoryValue:image forKey:leftBtnImg];
    }
    
    [self.backBut setImage:image forState:UIControlStateNormal];
    [self.backBut setImage:image forState:UIControlStateHighlighted];
}

//设置按钮透明度
- (void)resetBtnsAlpha:(CGFloat)alpha {
    self.backBut.alpha = alpha;
    self.navBarRightBtn.alpha = alpha;
}

- (void)setNavBarRightBtnEnabled:(BOOL)enabled {
    self.rightBarItem.enabled = enabled;
    self.navBarRightBtn.enabled = enabled;
}

- (void)navBarRightBtnAction:(id)sender {
    //子类重写该方法
}

- (void)setNavBarLeftBtnImg:(NSString *)imgName {
    if ([imgName length] > 0) {
        [self.backBut setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [self.backBut setImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];
    }
}

- (void)refreshUI {
    [self setupNavDefaultStyle];
 
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.backBut.hidden = !self.isShowBackButton;
    
    [self setupInteractive];
}

#pragma mark - 导航栏默认样式
- (void)setupNavDefaultStyle {
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - 配置手势交互
- (void)setupInteractive {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

#pragma mark - 设置导航返回按钮样式
- (void)setupNavBackItemStyle {
    if (self.backTitle) {
        [self configureBackTitleStyle];
    } else {
        [self configureNavBackDefaultStyle];
    }
    
    [self setupNavBackItem];
}

- (void)setupNavBackItem {
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBut];
    self.navigationItem.leftBarButtonItem = barBtnItem;
}

- (void)configureBackTitleStyle {
    self.backBut.frame = CGRectMake(0, 0, 60, 40);
    [self.backBut setImageEdgeInsets:UIEdgeInsetsMake(0, -35, 0, 0)];
    [self.backBut setTitleEdgeInsets:UIEdgeInsetsMake(0, -35, 0, 0)];
    [self.backBut setTitle:self.backTitle forState:UIControlStateNormal];
    [self.backBut setTitleColor:[UIColor moBlack] forState:UIControlStateNormal];
    [self.backBut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
}

- (void)configureNavBackDefaultStyle {
    self.backBut.frame = CGRectMake(0, 0, 40, 40);
    [self.backBut setImageEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)];
}

- (UIButton *)backBut {
    if (!_backBut) {
        _backBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBut.titleLabel.font = [UIFont font14];
        [_backBut setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_backBut setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateHighlighted];
        [_backBut addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backBut;
}

- (UILabel *)navTitleLabel {
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 24)];
        _navTitleLabel.backgroundColor = [UIColor clearColor];
        _navTitleLabel.font = [UIFont boldFont17];
        _navTitleLabel.textAlignment = NSTextAlignmentCenter;
        _navTitleLabel.textColor = [UIColor moBlack];
    }
    
    return _navTitleLabel;
}

- (UIButton *)navBarRightBtn {
    if (!_navBarRightBtn) {
        _navBarRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _navBarRightBtn.frame = CGRectMake(0, 0, 80, 30);
        _navBarRightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _navBarRightBtn.titleLabel.font = [UIFont font14];
        [_navBarRightBtn setTitleColor:[UIColor moBlack] forState:UIControlStateNormal];
        [_navBarRightBtn setTitleColor:[UIColor moDarkGray] forState:UIControlStateDisabled];
        [_navBarRightBtn addTarget:self action:@selector(navBarRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _navBarRightBtn;
}

-(void)setNavBarRightBtnTitleColor:(UIColor *)color backColor:(UIColor *)backColor title:(NSString*)title{
    [self setNavBarRightBtnWithTitle:title andImageName:nil];
    [_navBarRightBtn setTitleColor:color forState:UIControlStateNormal];
    [_navBarRightBtn setBackgroundColor:backColor];
    _navBarRightBtn.layer.masksToBounds = YES;
    _navBarRightBtn.layer.cornerRadius = 5;
    _navBarRightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _navBarRightBtn.titleLabel.font = [UIFont font12];
    CGFloat width = [title sizeWithAttributes:@{NSFontAttributeName : _navBarRightBtn.titleLabel.font}].width;
    _navBarRightBtn.frame = CGRectMake(0, 0, width+10 , 26);
     _navBarRightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
//}


@end
