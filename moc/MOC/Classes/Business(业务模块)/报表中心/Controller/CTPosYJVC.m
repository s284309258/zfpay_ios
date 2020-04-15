//
//  CTPOSVC.m
//  XZF
//
//  Created by mac on 2019/8/7.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "CTPosYJVC.h"
#import "YNPageScrollMenuView.h"
#import "YNPageConfigration.h"
#import "CTDLYJVC.h"
#import "CTWDEJVC.h"
@interface CTPosYJVC ()<YNPageScrollMenuViewDelegate>

@property (nonatomic , strong) YNPageScrollMenuView *menu;

@property (nonatomic , strong) UIViewController *lastController;

@property (nonatomic , strong) NSArray *controllers;

@end

@implementation CTPosYJVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initUI];
    [self initData];
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
       _menu = [YNPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38) titles: @[@"代理业绩",@"我的业绩"]  configration:configration delegate:self currentIndex:0];
    }
    return _menu;
}

-(void)initUI{
    self.isShowBackButton = YES;
    [self setNavBarTitle:@"传统POS"];
    CTDLYJVC* vc1 = [[CTDLYJVC alloc]init];
    CTWDEJVC* vc2 = [[CTWDEJVC alloc]init];
    self.controllers = @[vc1,vc2];

    self.lastController = self.controllers[0];
    [self.view addSubview:self.menu];
    [self initViewControllerWithIndex:0];
    [self.menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(38));
    }];
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

- (void)pagescrollMenuViewItemOnClick:(UIButton *)button index:(NSInteger)index{
    [self initViewControllerWithIndex:index];
}

-(void)initData{
    
}
@end
