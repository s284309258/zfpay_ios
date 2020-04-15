//
//  CTPOSVC.m
//  XZF
//
//  Created by mac on 2019/8/7.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "RecallVC.h"
#import "YNPageScrollMenuView.h"
#import "YNPageConfigration.h"
#import "CTRecalManagerVC.h"
#import "MRecalManagerVC.h"
#import "LLKRecalManagerVC.h"
#import "ERecalManagerVC.h"
@interface RecallVC ()<YNPageScrollMenuViewDelegate>

@property (nonatomic , strong) UIViewController *lastController;

@property (nonatomic , strong) NSArray *controllers;

@property (nonatomic , strong) UISegmentedControl *segment;

@end

@implementation RecallVC
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

-(void)initUI{
    self.isShowBackButton = YES;
    [self setNavBarTitle:@"传统POS"];
    //初始化UISegmentedControl
    //在没有设置[segment setApportionsSegmentWidthsByContent:YES]时，每个的宽度按segment的宽度平分
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"传统POS",@"MPOS",@"流量卡",@"EPOS"] ];
    self.segment.selectedSegmentIndex = 0;
    self.segment.tintColor = [UIColor moGreen];
    //设置frame
    self.segment.frame = CGRectMake(0, 0, 160, 30);
    [self.segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segment;
    
    CTRecalManagerVC*      vc1 = [CTRecalManagerVC new];
    MRecalManagerVC*        vc2 = [MRecalManagerVC new];
    LLKRecalManagerVC*   vc3 = [LLKRecalManagerVC new];
    ERecalManagerVC* vc4 = [ERecalManagerVC new];
    self.controllers = @[vc1,vc2,vc3,vc4];
    [self initViewControllerWithIndex:0];
}

-(void)segmentValueChanged:(id)sender{
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    NSInteger index = segment.selectedSegmentIndex;
    [self initViewControllerWithIndex:index];
}

#pragma mark - 初始化子控制器
- (void)initViewControllerWithIndex:(NSInteger)index {
    [self.lastController removeFromParentViewController];
    [self.lastController.view removeFromSuperview];
    UIViewController *cacheViewController = [self.controllers objectAtIndex:index];
    [self addChildViewController:cacheViewController];
    [self.view addSubview:cacheViewController.view];
    @weakify(self)
    [cacheViewController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];
    self.lastController = cacheViewController;
}

- (void)pagescrollMenuViewItemOnClick:(UIButton *)button index:(NSInteger)index{
    [self initViewControllerWithIndex:index];
}

-(void)initData{
    
}
@end
