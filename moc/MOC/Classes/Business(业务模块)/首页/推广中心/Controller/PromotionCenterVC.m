//
//  PromotionCenterVC.m
//  XZF
//
//  Created by mac on 2020/3/7.
//  Copyright © 2020 AlphaGo. All rights reserved.
//

#import "PromotionCenterVC.h"
#import "PromotionYWKZVC.h"
#import "PromotionSHKZVC.h"
#import "PromotionYLBVC.h"
@interface PromotionCenterVC ()

@property (nonatomic , strong) YNPageScrollMenuView *menu;

@property (nonatomic , strong) UIViewController *lastController;

@property (nonatomic , strong) NSArray *controllers;

@property (nonatomic , strong)  PromotionYWKZVC *vc1;

@property (nonatomic , strong)  PromotionSHKZVC *vc2;

@property (nonatomic , strong)  PromotionYLBVC *vc3;

@end

@implementation PromotionCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupData];
}

-(void)setupUI{
    [self setNavBarTitle:@"推广中心"];
    [self.view addSubview:self.menu];
    [self.menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(38));
    }];
    
    self.vc1 = [[PromotionYWKZVC alloc]init];
    
    self.vc2 = [[PromotionSHKZVC alloc]init];
    
    self.vc3 = [[PromotionYLBVC alloc]init];
    
    self.controllers = @[self.vc1,self.vc2,self.vc3];
    
    [self initViewControllerWithIndex:0];
}

-(void)setupData{
    
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
        _menu = [YNPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38) titles: @[@"宣传素材",@"招商素材"]  configration:configration delegate:self currentIndex:0];
    }
    return _menu;
}

- (void)pagescrollMenuViewItemOnClick:(UIButton *)button index:(NSInteger)index{
    [self initViewControllerWithIndex:index];
}

- (void)initViewControllerWithIndex:(NSInteger)index {
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
