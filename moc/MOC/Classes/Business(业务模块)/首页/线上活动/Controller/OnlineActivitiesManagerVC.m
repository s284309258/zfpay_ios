//
//  CTPOSVC.m
//  XZF
//
//  Created by mac on 2019/8/7.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "OnlineActivitiesManagerVC.h"
#import "YNPageScrollMenuView.h"
#import "YNPageConfigration.h"
#import "CTActivitiesVC.h"
#import "MActivitiesVC.h"
#import "CTRewardVC.h"
#import "MRewardVC.h"
#import "EActivitiesVC.h"
#import "ERewardVC.h"
@interface OnlineActivitiesManagerVC ()<YNPageScrollMenuViewDelegate>

@property (nonatomic , strong) YNPageScrollMenuView *menu;

@property (nonatomic , strong) UIViewController *lastController;

@property (nonatomic , strong) NSArray *controllers;

@property (nonatomic) int leftIndex;

@property (nonatomic) int rightIndex;

@property (nonatomic , strong)  UISegmentedControl *segment;

@property (nonatomic , strong)  CTActivitiesVC *vc1;

@property (nonatomic , strong)  MActivitiesVC *vc2;

@property (nonatomic , strong)  EActivitiesVC *vc5;

@property (nonatomic , strong)  CTRewardVC *vc3;

@property (nonatomic , strong)  MRewardVC *vc4;

@property (nonatomic , strong)  ERewardVC *vc6;

@end

@implementation OnlineActivitiesManagerVC
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
        _menu = [YNPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38) titles: @[@"传统POS活动",@"MPOS活动",@"EPOS活动"]  configration:configration delegate:self currentIndex:0];
    }
    return _menu;
}

-(void)initUI{
    self.isShowBackButton = YES;
    [self.view addSubview:self.menu];
    [self.menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(38));
    }];
    
    //先创建一个数组用于设置标题
    NSArray *arr = [[NSArray alloc]initWithObjects:@"活动列表",@"活动订单", nil];
    
    //初始化UISegmentedControl
    //在没有设置[segment setApportionsSegmentWidthsByContent:YES]时，每个的宽度按segment的宽度平分
    self.segment = [[UISegmentedControl alloc]initWithItems:arr];
    self.segment.selectedSegmentIndex = 0;
    self.segment.tintColor = [UIColor moGreen];
    //设置frame
    self.segment.frame = CGRectMake(0, 0, 160, 30);
    [self.segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segment;
    
    self.vc1 = [[CTActivitiesVC alloc]init];
    self.vc2 = [[MActivitiesVC alloc]init];
    self.vc5 = [[EActivitiesVC alloc]init];
    
    self.vc3 = [[CTRewardVC alloc]init];
    self.vc4 = [[MRewardVC alloc]init];
    self.vc6 = [[ERewardVC alloc]init];
    
    [self segmentValueChanged:self.segment];
    [self setNavBarRightBtnWithTitle:@"奖励记录" andImageName:nil];
    
}

-(void)segmentValueChanged:(id)sender{
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    NSInteger index = segment.selectedSegmentIndex;
    if (index == 0) {
        self.navBarRightBtn.hidden = NO;
        self.controllers = @[self.vc1,self.vc2,self.vc5];
        self.lastController = self.controllers[self.leftIndex];
        [self initViewControllerWithIndex:self.leftIndex];
    }else{
        self.navBarRightBtn.hidden = YES;
        self.controllers = @[self.vc3,self.vc4,self.vc6];
        self.lastController = self.controllers[self.rightIndex];
        [self initViewControllerWithIndex:self.rightIndex];
    }
}

#pragma mark - 初始化子控制器
- (void)initViewControllerWithIndex:(NSInteger)index {
    [self.menu selectedItemIndex:index animated:NO];
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
    if (self.segment.selectedSegmentIndex == 0) {
        self.leftIndex = index;
    }else{
        self.rightIndex = index;
    }
    [self initViewControllerWithIndex:index];
}

-(void)initData{
    
}

-(void)navBarRightBtnAction:(id)sender{
    NSString* type = @"";
    if (self.segment.selectedSegmentIndex == 0) {
        if (self.leftIndex == 0) {
            type = @"0";
        }else if(self.leftIndex == 1){
            type = @"1";
        }else{
            type = @"2";
        }
    }else if(self.segment.selectedSegmentIndex == 1){
        return;
    }
    [MXRouter openURL:@"lcwl://ActivitiesRewardVC" parameters:@{@"type":type}];
}

@end
