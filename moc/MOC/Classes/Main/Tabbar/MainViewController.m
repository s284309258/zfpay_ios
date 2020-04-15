//
//  MainViewController.m
//  MoXian
//
//  Created by 王 刚 on 14-4-17.
//  Copyright (c) 2014年 litiankun. All rights reserved.
//

#import "MainViewController.h"
//#import "MXTabBarButton.h"
#import "BaseNavigationController+ExtendBaseNavigationController.h"
#import "AppDelegate.h"
#import "MXUIDefine.h"
#import "MXDeviceDefine.h"
#import "ViewController.h"
#define kFirstShowCityList @"kFirstShowCityList"

@interface MainViewController ()<AxcAE_TabBarDelegate, UINavigationControllerDelegate>
{
    NSInteger   selectedIndex;
}

@property (nonatomic, strong) NSDate              *lastPlaySoundDate;
@property (nonatomic, strong) NSDate              *lastReceiveMsgDate;
@property (nonatomic, strong) UILocalNotification *notification;
@property (nonatomic, strong) UIImageView *selectView;
//@property (nonatomic, strong) AuthorityVC* vc;
@property (nonatomic, strong) NSArray<NSDictionary *> *tabArr;
@property (nonatomic, strong) NSMutableArray *tabBarConfs;
@property (nonatomic, strong) NSMutableArray *tabBarVCs;

-(void)setupSubviews;
-(void)setUpTabs;


@end
static const CGFloat kDefaultPlaySoundInterval = 3.0;

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initControllers];
    [self initTabbar];
    //self.tabBar.alpha = 0;
    [self configNotification];
    //    if ([StringUtil isEmpty:first]) {
    //[[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:_vc.view];
    [MXCache setValue:@"1" forKey:@"first"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)configNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(redBadgeCountChanged:) name:@"redBadgeCountChanged" object:nil];
    //[[LcwlChat shareInstance].chatManager addDelegate:self];
}


// 收到消息回调
//-(void)didReceiveMessage:(MessageModel *)message {
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    BOOL isEnterBack = ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground);
//    MXConversation* con = [[LcwlChat shareInstance].chatManager getLastestConversation];
//    if (con == nil || ![con.chat_id isEqualToString:message.chat_with] || isEnterBack) {
//        //红点更新
//        {
//            NSMutableDictionary* userInfo = [[NSMutableDictionary alloc]initWithCapacity:0];
//            NSInteger nums = [[LcwlChat shareInstance].chatManager getAllUnReadNums];
//            [userInfo setValue:[NSNumber numberWithInteger:nums] forKey:@"nums"];
//            [userInfo setValue:[NSNumber numberWithInteger:1] forKey:@"tabBarIndex"];
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"redBadgeCountChanged" object:nil userInfo:userInfo];
//            [[AudioVibrateManager shareInstance]playSound];;
//        }
//
////        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
////        switch (state) {
////            case UIApplicationStateActive: {
////
////                if (message.subtype==-1) {
////                    return;
////                }
////
////                if (self.lastReceiveMsgDate == nil) {
////                    [self startTimer];
////                }
////
////                [self playMsgSound:message];
////
////                break;
////            }
////            case UIApplicationStateInactive: {
////
////                if (message.subtype==-1) {
////                    return;
////                }
////                if (self.lastReceiveMsgDate == nil) {
////                    [self startTimer];
////                }
////
////
////                [self playMsgSound:message];
////
////                break;
////            }
////            case UIApplicationStateBackground: {
////                [self showNotificationWithMessage:message];
////                break;
////            }
////            default:
////                break;
////        }
//    }
//
//}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillLayoutSubviews {
    NSLog(@"viewWillLayoutSubviews...");

}


- (void)initControllers {
    
    self.homeVC = [[HomeVC alloc] init];
    self.businessVC = [[RFHomeVC alloc] init];
    self.appVC = [[ProfitVC alloc]init];
    self.mineVC = [[PersonalCenterVC alloc]init];
    
    BaseNavigationController* nav1 = [[BaseNavigationController alloc]initWithRootViewController:self.homeVC];
    nav1.delegate = self;
    
    BaseNavigationController* nav2 = [[BaseNavigationController alloc]initWithRootViewController:self.businessVC];
    nav2.delegate = self;
    
    BaseNavigationController* nav3 = [[BaseNavigationController alloc]initWithRootViewController:self.appVC];
    nav3.delegate = self;
    
    BaseNavigationController* nav4 = [[BaseNavigationController alloc]initWithRootViewController:self.mineVC];
    nav4.delegate = self;
    
//    #ifdef OPEN_DISTRIBUTION
//        if([AppDelegate isTestDistribution]) {
//            self.socialContactVC = [SocialContactMainVC instanceVC];
//            BaseNavigationController* nav5 = [[BaseNavigationController alloc]initWithRootViewController:self.socialContactVC];
//            nav5.delegate = self;
//
//            self.tabArr =
//            @[@{@"vc":nav1,@"normalImg":@"首页_Nor",@"selectImg":@"首页_Sel",@"itemTitle":@"首页"},
//              @{@"vc":nav5,@"normalImg":@"区块-1",@"selectImg":@"区块",@"itemTitle":@"社交"},
//              @{@"vc":nav2,@"normalImg":@"报表_Nor",@"selectImg":@"报表_Sel",@"itemTitle":@"报表"},
//              @{@"vc":nav3,@"normalImg":@"收益_Nor",@"selectImg":@"收益_Sel",@"itemTitle":@"收益"},
//              @{@"vc":nav4,@"normalImg":@"我的_Nor",@"selectImg":@"我的_Sel",@"itemTitle":@"我的"}];
//        } else {
//            self.tabArr =
//            @[@{@"vc":nav1,@"normalImg":@"首页_Nor",@"selectImg":@"首页_Sel",@"itemTitle":@"首页"},
//              @{@"vc":nav2,@"normalImg":@"报表_Nor",@"selectImg":@"报表_Sel",@"itemTitle":@"报表"},
//              @{@"vc":nav3,@"normalImg":@"收益_Nor",@"selectImg":@"收益_Sel",@"itemTitle":@"收益"},
//              @{@"vc":nav4,@"normalImg":@"我的_Nor",@"selectImg":@"我的_Sel",@"itemTitle":@"我的"}];
//        }
//    #else
//        self.tabArr =
//        @[@{@"vc":nav1,@"normalImg":@"首页_Nor",@"selectImg":@"首页_Sel",@"itemTitle":@"首页"},
//          @{@"vc":nav2,@"normalImg":@"报表_Nor",@"selectImg":@"报表_Sel",@"itemTitle":@"报表"},
//          @{@"vc":nav3,@"normalImg":@"收益_Nor",@"selectImg":@"收益_Sel",@"itemTitle":@"收益"},
//          @{@"vc":nav4,@"normalImg":@"我的_Nor",@"selectImg":@"我的_Sel",@"itemTitle":@"我的"}];
//    #endif
    
    self.tabArr =
    @[@{@"vc":nav1,@"normalImg":@"首页_Nor",@"selectImg":@"首页_Sel",@"itemTitle":@"首页"},
      @{@"vc":nav2,@"normalImg":@"报表_Nor",@"selectImg":@"报表_Sel",@"itemTitle":@"报表"},
      @{@"vc":nav3,@"normalImg":@"收益_Nor",@"selectImg":@"收益_Sel",@"itemTitle":@"收益"},
      @{@"vc":nav4,@"normalImg":@"我的_Nor",@"selectImg":@"我的_Sel",@"itemTitle":@"我的"}];
    
    
    // 1.遍历这个集合
    // 1.1 设置一个保存构造器的数组
    self.tabBarConfs = @[].mutableCopy;
    // 1.2 设置一个保存VC的数组
    self.tabBarVCs = @[].mutableCopy;
    [self.tabArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 2.根据集合来创建TabBar构造器
        AxcAE_TabBarConfigModel *model = [AxcAE_TabBarConfigModel new];
        // 3.item基础数据三连
        model.itemTitle = [obj objectForKey:@"itemTitle"];
        model.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        model.selectImageName = [obj objectForKey:@"selectImg"];
        model.normalImageName = [obj objectForKey:@"normalImg"];
        // 4.设置单个选中item标题状态下的颜色
        model.selectColor = [UIColor moGreen];
        model.normalColor = [UIColor moBlack];
        model.automaticHidden = YES;
        /***********************************/
        // 来点效果好看
        model.interactionEffectStyle = AxcAE_TabBarInteractionEffectStyleSpring;
        // 点击背景稍微明显点吧
        //model.selectBackgroundColor = AxcAE_TabBarRGBA(248, 248, 248, 1);
        model.normalBackgroundColor = [UIColor clearColor];
        model.icomImgViewSize = CGSizeMake(22, 22);
        model.pictureWordsMargin = 0;
        // 备注 如果一步设置的VC的背景颜色，VC就会提前绘制驻留，优化这方面的话最好不要这么写
        // 示例中为了方便就在这写了
        UIViewController *vc = [obj objectForKey:@"vc"];
        //vc.view.backgroundColor = [UIColor whiteColor];
        // 5.将VC添加到系统控制组
        [self.tabBarVCs addObject:vc];
        // 5.1添加构造Model到集合
        [self.tabBarConfs addObject:model];
    }];
    
    
    
}

- (void)initTabbar{
    self.viewControllers = self.tabBarVCs;
    
    self.axcTabBar = [AxcAE_TabBar new] ;
//    self.axcTabBar.backgroundImageView.image = [UIImage imageNamed:@"底部栏"];
    self.axcTabBar.tabBarConfig = self.tabBarConfs;
    // 7.设置委托
    self.axcTabBar.delegate = self;
    self.axcTabBar.backgroundColor = [UIColor whiteColor];
    
    // 8.添加覆盖到上边
    [self.tabBar addSubview:self.axcTabBar];
    [self addLayoutTabBar]; // 10.添加适配
    [self changeTabbarItenHierarchy];
    //[self setSelectedIndex:2];
}

- (void)changeTabbarItenHierarchy {
    [[self.axcTabBar subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[AxcAE_TabBarItem class]]) {
            AxcAE_TabBarItem *item = (AxcAE_TabBarItem *)obj;
            [item insertSubview:item.titleLabel aboveSubview:item.icomImgView];
        }
    }];
}

- (void)setGameTabbarStyle:(BOOL)isGameStyle {
    
    self.axcTabBar.backgroundColor = (isGameStyle ? [UIColor gameTabbarColor] : [UIColor whiteColor]);
    [[self.axcTabBar subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[AxcAE_TabBarItem class]]) {
            AxcAE_TabBarItem *item = (AxcAE_TabBarItem *)obj;
            if(isGameStyle) {
                item.normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_Game",item.title]];
                item.selectImage = item.normalImage;
                item.selectColor = [item.title isEqualToString:@"摘星星"] ? [UIColor whiteColor] : [UIColor colorWithHexString:@"#3C6CFB"];
                item.normalColor = item.selectColor;
            } else {
                item.normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_Nor",item.title]];
                item.selectImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_Sel",item.title]];
                item.selectColor = [UIColor moOrange];
                item.normalColor = [UIColor blackColor];
            }
        }
    }];
}

// 9.实现代理，如下：
static NSInteger lastIdx = 0;
- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
    [self setSelectedIndex:index];
    lastIdx = index;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    
   
    [super setSelectedIndex:selectedIndex];
    if(self.axcTabBar.selectIndex == selectedIndex) {
        return;
    }
    
    if(self.axcTabBar){
//        if(selectedIndex == 2) {
//            [self setGameTabbarStyle:YES];
//            //[[NSNotificationCenter defaultCenter] postNotificationName:@"UPDATEGAMEHOMEPAGE" object:nil];
//        } else if(self.axcTabBar.selectIndex == 2) {
//            [self setGameTabbarStyle:NO];
//        }
        self.axcTabBar.selectIndex = selectedIndex;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

// 10.添加适配
- (void)addLayoutTabBar{
    // 使用重载viewDidLayoutSubviews实时计算坐标 （下边的 -viewDidLayoutSubviews 函数）
    // 能兼容转屏时的自动布局
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.axcTabBar.frame = self.tabBar.bounds;
    //[self.axcTabBar viewDidLayoutItems];
}

- (UINavigationController *)selectedNavigaitonController {
    return [self.viewControllers safeObjectAtIndex:self.axcTabBar.selectIndex ];
}

- (void)switchToGameList {

}

- (void)switchToGameMyPet {


}

- (void)switchToExchange {

}

// 未读消息数量变化回调
-(void)redBadgeCountChanged:(NSNotification *)notification
{
    NSDictionary  *dict = [notification userInfo];
    NSInteger nums = [dict[@"nums"]integerValue];
    NSInteger tabBarIndex = [dict[@"tabBarIndex"]integerValue];
    NSString* tip = @"";
    if (nums != 0) {
        tip = [NSString stringWithFormat:@"%ld",nums];
    }
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.axcTabBar setBadge:tip index:tabBarIndex];
        AxcAE_TabBarItem* item = self.axcTabBar.tabBarItems[tabBarIndex];
        item.itemModel.itemBadgeStyle = -1;
        CGRect badgeRect = item.badgeLabel.frame;
        badgeRect.origin.x = 45;
        badgeRect.origin.y = 0;
        item.badgeLabel.frame = badgeRect;
    });
}

@end
