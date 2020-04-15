//
//  SCPopularityMainVC.m
//  Lcwl
//
//  Created by mac on 2019/3/12.
//  Copyright © 2019 lichangwanglai. All rights reserved.
//

#import "SCPopularityMainVC.h"
#import "UIImage+Utils.h"
#import "ShowImageVC.h"
#import "SocialContactVC.h"

@interface SCPopularityMainVC ()
@property(nonatomic,strong) ShowImageVC *showImageVC;
@end

@implementation SCPopularityMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *navTitleLabel = [self valueForKey:@"navTitleLabel"];
    navTitleLabel.text = @"人气朋友圈";
    navTitleLabel.textColor = [UIColor blackColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIButton *navBarRightBtn = [self valueForKey:@"navBarRightBtn"];
    [navBarRightBtn setImage: nil forState:UIControlStateNormal];
    [navBarRightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    navBarRightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [navBarRightBtn setTitle:@"人气奖励" forState:UIControlStateNormal];
    
    //去掉代理
    self.delegate = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIImage *image = [UIImage createImageWithColor:RGBA(255, 255, 255, 1)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)navBarRightBtnAction:(id)sender {
    //[MXRouter openURL:@"lcwl://ShowImageVC" parameters:@{@"url":@"FnF9XmOek735hPCnWXYFIPHHuSKL"}];
    self.showImageVC = [[ShowImageVC alloc] init];
    self.showImageVC.showImageType = ShowImageType02;
    self.showImageVC.type = ShowTypePrompt;
    [MoApp.window addSubview:self.showImageVC.view];
}

- (void)updateMenu {
    
}

- (void)setNavBarRightBtnWithColor:(UIColor *)color {
    
}

+ (NSArray *)getArrayVCs {
    
    SocialContactVC *vc_1 = [[SocialContactVC alloc] init];
    vc_1.title = @" 点赞排行榜";
    vc_1.type = SocialContactTypePraise;
    
    SocialContactVC *vc_2 = [[SocialContactVC alloc] init];
    vc_2.title = @" 打赏排行榜";
    vc_2.type = SocialContactTypeReward;
    
    return @[vc_1, vc_2];
}

+ (NSArray *)getArrayTitles {
    return @[@" 点赞排行榜", @" 打赏排行榜"];
}

+ (YNPageConfigration *)pageConfigration {
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleTop;
    configration.headerViewCouldScale = NO;
    configration.showTabbar = YES;
    configration.showNavigation = NO;
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = NO;
    configration.showBottomLine = YES;
    configration.bottomLineBgColor = [UIColor moBackground];
    configration.lineColor = [UIColor moBlue];
    configration.converColor = [UIColor whiteColor];
    configration.selectedItemColor = [UIColor blackColor];
    configration.normalItemColor = [UIColor moTextGray];
    configration.menuHeight = 60;
    configration.showAddButton = NO;
    configration.cutOutHeight = 10;
    configration.lineCorner = 1.5;
    configration.lineHeight = 3;
    configration.lineBottomMargin = 12;
    configration.bottomLineHeight = 10;
    configration.lineLeftAndRightMargin = SCREEN_WIDTH/2/2-7.5;
    configration.headerViewScaleMode = YNPageHeaderViewScaleModeCenter;
    
    NSMutableArray *buttonArrayM = @[].mutableCopy;
    UIButton *praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [praiseButton setImage:[UIImage imageNamed:@"点赞-灰"] forState:UIControlStateNormal];
    [praiseButton setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateSelected];
    [buttonArrayM addObject:praiseButton];
    
    UIButton *rewardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rewardButton setImage:[UIImage imageNamed:@"打赏-灰"] forState:UIControlStateNormal];
    [rewardButton setImage:[UIImage imageNamed:@"打赏"] forState:UIControlStateSelected];
    [buttonArrayM addObject:rewardButton];

    configration.buttonArray = buttonArrayM;
    return configration;
}
@end
