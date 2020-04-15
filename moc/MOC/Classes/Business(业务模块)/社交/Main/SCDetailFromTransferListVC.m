//
//  SCDetailFromTransferListVC.m
//  Lcwl
//
//  Created by mac on 2019/1/3.
//  Copyright © 2019 lichangwanglai. All rights reserved.
//

#import "SCDetailFromTransferListVC.h"
#import "SCRequestHelper.h"
#import "WBStatusHelper.h"
#import "WBStatusLayout.h"
#import "SocialContactDetailVC.h"
#import "UINavigationBar+Alpha.h"
#import "UIImage+Utils.h"
#import "UIViewController+NavItem.h"

@interface SCDetailFromTransferListVC ()
@property (nonatomic, strong) SocialContactDetailVC *detailVC;
@end

@implementation SCDetailFromTransferListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"详情";
    
    [self getData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = nil;
    
    //[self.navigationController.navigationBar barReset];
    //[self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setNavBarCurrentColor:[UIColor whiteColor] titleTextColor:[UIColor blackColor]];
    //    [self.navigationController.navigationBar setTitleTextAttributes:@{
    //                                                                      NSForegroundColorAttributeName : [UIColor blackColor],
    //                                                                      NSFontAttributeName : [UIFont font19]
    //                                                                      }];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBg"] forBarMetrics:UIBarMetricsDefault];
    //[self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    @weakify(self)
    [self setDefaultBackBnt:^(UIButton *btn) {
        @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[MXRouter sharedInstance] configureCurrentVC:self];
}

- (void)getData {
    [SCRequestHelper getCircleDetail:self.circle_id completion:^(id data) {
        if([data isSuccess]) {
            WBStatus *status = [WBStatusHelper modelForDic:[data valueForKey:@"data"]];
            WBStatusLayout *layout = [[WBStatusLayout alloc] initWithStatus:status style:WBLayoutStyleTimeline];
            
            self.detailVC = [SocialContactDetailVC instanceVC];
            self.detailVC.layout = layout;
            
            [self.view addSubview:self.detailVC.view];
            [self.detailVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view);
            }];
        }
    }];
}

@end
