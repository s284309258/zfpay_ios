//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "LLKRecalManagerVC.h"
#import "YNPageScrollMenuView.h"
#import "YNPageConfigration.h"
#import "LLKRecallingVC.h"
#import "LLKRecaledVC.h"
#import "LLKRecallRefuseVC.h"
@interface LLKRecalManagerVC ()<YNPageScrollMenuViewDelegate>

@property (nonatomic , strong) YNPageScrollMenuView *menu;

@property (nonatomic , strong) NSArray *controllers;

@property (nonatomic , strong) UIViewController *lastController;

@end

@implementation LLKRecalManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self layout];
}

-(void)initUI{
    LLKRecallingVC*   vc1 = [[LLKRecallingVC alloc]init];
    LLKRecaledVC*    vc2 = [[LLKRecaledVC alloc]init];
    LLKRecallRefuseVC*  vc3 = [[LLKRecallRefuseVC alloc]init];
    self.controllers = @[vc1,vc2,vc3];
    [self.view addSubview:self.menu];
    [self initViewControllerWithIndex:0];
    [self.menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(38));
    }];
}

-(void)layout{
    
}

-(YNPageScrollMenuView*)menu{
    if(!_menu){
        YNPageConfigration *configration = [YNPageConfigration defaultConfig];
        configration.pageStyle = YNPageStyleSuspensionTop;
        configration.headerViewCouldScale = YES;
        configration.showTabbar = NO;
        configration.showNavigation = YES;
        configration.scrollMenu = NO;
        configration.aligmentModeCenter = NO;
        configration.lineWidthEqualFontWidth = YES;
        configration.showBottomLine = YES;
        configration.bottomLineBgColor = [UIColor clearColor];
        configration.itemFont = [UIFont font14];
        configration.selectedItemFont = [UIFont font14];
        configration.lineColor = [UIColor moGreen];
        configration.converColor = [UIColor clearColor];
        configration.selectedItemColor = [UIColor moGreen];
        configration.normalItemColor = [UIColor moBlack];
        configration.bottomLineHeight = 0.5;
        configration.menuHeight = 38;
        
        configration.scrollViewBackgroundColor = [UIColor whiteColor];
        _menu = [YNPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38) titles: @[@"待处理",@"已同意",@"已拒绝"]  configration:configration delegate:self currentIndex:0];
    }
    return _menu;
}

/// 点击item
- (void)pagescrollMenuViewItemOnClick:(UIButton *)button index:(NSInteger)index{
    [self initViewControllerWithIndex:index];
}
#pragma mark - 初始化子控制器
- (void)initViewControllerWithIndex:(NSInteger)index {
    [self.menu selectedItemIndex:index animated:YES];
    [self.lastController removeFromParentViewController];
    [self.lastController.view removeFromSuperview];
    UIViewController *cacheViewController = [self.controllers objectAtIndex:index];
    [self addChildViewController:cacheViewController];
    [self.view addSubview:cacheViewController.view];
    @weakify(self)
    [cacheViewController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-SafeAreaBottom_Height);
        make.top.equalTo(self.menu.mas_bottom);
    }];
    self.lastController = cacheViewController;
}
@end
