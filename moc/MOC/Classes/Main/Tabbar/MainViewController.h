//
//  MainViewController.h
//  MoXian

//  Created by 王 刚 on 14-4-17.
//  Copyright (c) 2014年 litiankun. All rights reserved.
//  程序首页


#import <UIKit/UIKit.h>
//#import "MXTabBar.h"
//#import "PersonalCenterVC.h"
//#import "MXMoMessageHomeVC.h"
//#import "MXWalletHomeVC.h"
//#import "DiscoveryHomeVC.h"
//#import "ChatHomeVC.h"
//#import "ShoppingMainViewController.h"
//#import "TopicHomeVC.h"
//#define OpenNOLogin 1

#import "BaseTabBar.h"


#import "HomeVC.h"
#import "RFHomeVC.h"
#import "ProfitVC.h"
#import "PersonalCenterVC.h"

#import "SocialContactMainVC.h"

#define No_Login_PhoneNo @""

#define No_Login_Password @""

@interface MainViewController : BaseTabBar

@property (nonatomic, strong) UIImageView                *barBottomView;

@property (nonatomic, strong) UIView                     *moveView;

@property (nonatomic, strong) HomeVC                      *homeVC;

@property (nonatomic, strong) RFHomeVC                *businessVC;

@property (nonatomic, strong) ProfitVC               *appVC;

@property (nonatomic, strong) PersonalCenterVC            *mineVC;

@property (nonatomic, strong) SocialContactMainVC                *socialContactVC;

- (void)switchToGameList;
- (void)switchToGameMyPet;
- (void)switchToExchange;

- (UINavigationController *)selectedNavigaitonController;
@end
