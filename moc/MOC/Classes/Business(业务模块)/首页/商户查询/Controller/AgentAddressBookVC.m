//
//  CTPOSVC.m
//  XZF
//
//  Created by mac on 2019/8/7.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "AgentAddressBookVC.h"
#import "CTAgentAddressBookDetailVC.h"
#import "MAgentAddressBookDetailVC.h"
#import "EAgentAddressBookDetailVC.h"
@interface AgentAddressBookVC ()

@property (nonatomic , strong) UIViewController *lastController;

@property (nonatomic , strong) NSArray *controllers;

@property (nonatomic , strong) UISegmentedControl *segment;

@property (nonatomic , strong) CTAgentAddressBookDetailVC* vc1;

@property (nonatomic , strong) MAgentAddressBookDetailVC* vc2;

@property (nonatomic , strong) EAgentAddressBookDetailVC* vc3;

@end

@implementation AgentAddressBookVC
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
    
    self.vc1 = [CTAgentAddressBookDetailVC new];
    self.vc1.model = self.model;
    
    self.vc2 = [MAgentAddressBookDetailVC new];
    self.vc2.model = self.model;
    
    self.vc3 = [EAgentAddressBookDetailVC new];
    self.vc3.model = self.model;
    self.controllers = @[self.vc1,self.vc2,self.vc3];
    //先创建一个数组用于设置标题
    NSArray *arr = [[NSArray alloc]initWithObjects:@"传统POS",@"MPOS",@"EPOS", nil];
    
    //初始化UISegmentedControl
    //在没有设置[segment setApportionsSegmentWidthsByContent:YES]时，每个的宽度按segment的宽度平分
    self.segment = [[UISegmentedControl alloc]initWithItems:arr];
    self.segment.selectedSegmentIndex = 0;
    self.segment.tintColor = [UIColor moGreen];
    //设置frame
    self.segment.frame = CGRectMake(0, 0, 160, 30);
    [self.segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segment;
    [self segmentValueChanged:self.segment];
    
    
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
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-SafeAreaBottom_Height);
        make.top.equalTo(self.view);
    }];
    self.lastController = cacheViewController;
}

-(void)initData{
    
}


@end
