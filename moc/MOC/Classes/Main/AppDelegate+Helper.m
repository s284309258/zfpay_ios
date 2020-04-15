//
//  AppDelegate+Helper.m
//  Lcwl
//
//  Created by 王刚  on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "AppDelegate+Helper.h"
//#import "RegisterPhoneViewController.h"
//#import "LoginPhoneViewController.h"
//#import "LcwlChat.h"
#import "AppAgentConfig.h"
//#import "RegisterManager.h"
//#import "DoraemonManager.h"
//#import "IntroductionVC.h"
//#import "RegisterVC.h"
//#import "ForgetPwdVC.h"

#import "LoginVC.h"
#import "NSObject+LoginHelper.h"
#import "IQKeyboardManager.h"
//#import <ShareSDK/ShareSDK.h>
@interface AppDelegate ()<WXApiDelegate>

@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundUpdateTask;
//@property (nonatomic, strong) IntroductionVC *introductionVC;
@property (nonatomic, assign) BOOL isComeFromThird;
@property (nonatomic, strong, readwrite) UserModel *currentAppUserInfosModel;

@end

@implementation AppDelegate (Helper)

- (void)showAlertUnlockView {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:Lang(@"请求解封") message:Lang(@"您的账号已被冻结，请求好友解封才能登陆") preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = Lang(@"登录用户手机号码");
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = Lang(@"求助好友手机号码");
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = Lang(@"冻结用户备注");
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:Lang(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField1 = alertController.textFields.firstObject;
        UITextField *textField2 = [alertController.textFields safeObjectAtIndex:1];
        UITextField *textField3 = alertController.textFields.lastObject;
        
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
        [param setValue:textField1.text forKey:@"userMobile"];
        [param setValue:textField2.text forKey:@"helpUserMobile"];
        [param setValue:textField3.text forKey:@"userRemark"];
        
        NSString *url = [NSString stringWithFormat:@"%@/unblock/assign",LcwlServerRoot];
        [MXNet Post:^(MXNet *net) {
            net.apiUrl(url).params(param).useHud(self.window)
            .finish(^(id data) {
                NSDictionary* dict = (NSDictionary*)data;
                if (![dict[@"code"] boolValue]) {
                    
                }
                [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
            }).failure(^(id error){
                
            })
            .execute();
        }];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:Lang(@"取消") style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}

- (void)appInit {
//    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
//
//        //微信
//        [platformsRegister setupWeChatWithAppId:@"wxc56ded44f31fb7e7" appSecret:@"8dffa2c0f33fe4a28702bdb1c2510547"];
//
//        //抖音
//        //[platformsRegister setupDouyinByAppKey:@"wx617c77c82218ea2c" appSecret:@"c7253e5289986cf4c4c74d1ccc185fb1"];
//
//    }];
    
     [WXApi registerApp:@"wxc56ded44f31fb7e7"];
    
    MLog();
    self.currentAppUserInfosModel = [UserModel modelFromCache];
    self.router = [MXRouter sharedInstance];
    if (self.currentAppUserInfosModel) {
        [NotifyHelper showHUDAddedTo:self.window animated:YES];
        [self login:@{@"token":self.currentAppUserInfosModel.token,@"login_type":@"token"} completion:^(BOOL success, NSString *error) {
            if (success) {
                if (!self.mainVC) {
                    self.mainVC = [[MainViewController alloc] init];
                }
                if (self.mainVC != self.window.rootViewController) {
                    
                    [self.window setRootViewController:self.mainVC];
                }
                
//                #ifdef OPEN_DISTRIBUTION
//                if([AppDelegate isTestDistribution]) {
//                    [self socialLogin:@{@"login_type":@"account",@"password":@"111111",@"account":@"haha99"} superView:nil completion:^(BOOL success, NSString *error) {
//                        [NotifyHelper hideHUDForView:self.window animated:YES];
//                        if (success) {
//                            
//                        }else{
//                            
//                        }
//                    }];
//                }
//                #endif
            }else{
                [NotifyHelper hideHUDForView:self.window animated:YES];
                LoginVC* vc  = [[LoginVC alloc] init];
                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
                [self.window setRootViewController:nav];
            }
        }];
    }
    
    //[[AFNetworkReachabilityManager sharedManager] startMonitoring];
    if(IOS11_Later) {
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
    }
    [UIScrollView appearance].keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
}

-(void)testApp{
//    NSString* str = @"<div class=\"tradingview-widget-container\"><div id=\"tradingview_88835\" style=\"height:100vw;\"><div id=\"tradingview_bdfea-wrapper\" style=\"position: relative;box-sizing: content-box;width: 100%;height: 100%;margin: 0 auto !important;padding: 0 !important;font-family:Arial,sans-serif;overflow: hidden;border-radius: 3px;\"><div style=\"width: 100%;height: 100%;background: transparent;padding: 0 !important;\"><iframe id=\"tradingview_bdfea\" src=\"https://s.tradingview.com/widgetembed/?frameElementId=tradingview_bdfea&amp;symbol=BITFINEX%3AETHUSD&amp;interval=D&amp;symboledit=1&amp;saveimage=1&amp;toolbarbg=f1f3f6&amp;studies=%5B%5D&amp;theme=Light&amp;style=1&amp;timezone=Asia%2FShanghai&amp;studies_overrides=%7B%7D&amp;overrides=%7B%7D&amp;enabled_features=%5B%5D&amp;disabled_features=%5B%5D&amp;locale=zh_CN&amp;utm_source=moc5.moc8888.com&amp;utm_medium=widget_new&amp;utm_campaign=chart&amp;utm_term=BITFINEX%3AETHUSD\" style=\"width: 100%; height: 100%; margin: 0 !important; padding: 0 !important;\" frameborder=\"0\" allowtransparency=\"true\" scrolling=\"no\" allowfullscreen=\"\"></iframe></div></div></div><div class=\"tradingview-widget-copyright\" style=\"width: 100%;\"><a href=\"https://cn.tradingview.com/symbols/BITFINEX-ETHUSD/\" rel=\"noopener\" target=\"_blank\"><span class=\"blue-text\">ETHUSD图表</span></a>由TradingView提供</div><script type=\"text/javascript\" src=\"https://s3.tradingview.com/tv.js\"></script><script type=\"text/javascript\">new TradingView.widget({\"autosize\": true,\"symbol\": \"BITFINEX:ETHUSD\",\"interval\": \"D\",\"timezone\": \"Asia/Shanghai\", \"theme\": \"Light\",\"style\": \"1\",\"locale\": \"zh_CN\",\"toolbar_bg\": \"#f1f3f6\",\"enable_publishing\": false,\"allow_symbol_change\": true,\"container_id\": \"tradingview_88835\"});</script></div>";
//    
//       [MXRouter openURL:@"lcwl://MBWebVC" parameters:@{@"content":str}];
}





- (BOOL)applicationFinishLaunching {
    MLog();
    //#ifdef DEBUG
    //    [[DoraemonManager shareInstance] addH5DoorBlock:^(NSString *h5Url) {
    //        //使用自己的H5容器打开这个链接
    //    }];
    //
    //    [[DoraemonManager shareInstance] install];
    //#endif
    
    [AppAgentConfig configApplicationForCapacity];
    [self initKeyboardUtil];
    [self appWindow];
    
    return YES;
}

- (void)appWindow {
    
    [self setupLoginLogic];
    
}

#pragma mark - 检查Token
- (BOOL)checkToken {
    NSString* token = self.currentAppUserInfosModel.token;
    return ![StringUtil isEmpty:token];
}

#pragma mark - 退出登录逻辑处理
- (void)loginOutLogic {
    BaseNavigationController *nav = (BaseNavigationController *)self.window.rootViewController;
    if([nav isKindOfClass:[BaseNavigationController class]] && [[nav.viewControllers lastObject] isKindOfClass:[LoginVC class]]) {
        return;
    }
    
    LoginVC *vc = [[LoginVC alloc]init];
    nav= [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self.window setRootViewController:nav];
}

#pragma mark - 登录逻辑处理
- (void)setupLoginLogic {
    // 在iOS9下会crash 因为没有检测到rootVC
    if ([self checkToken]) {
        self.window.rootViewController = [[UIViewController alloc] init];
    }
    
    if ([self checkToken]) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.backgroundColor = [UIColor whiteColor];
        self.mainVC = [[MainViewController alloc] init];
        [self.window setRootViewController:self.mainVC];
        
        //        [[RegisterManager sharedInstance] login:nil completion:^(id array, NSString *error) {
        //            if (!array) {
        //                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        //
        //                //退出
        //                StartPageVC *startVC = [[StartPageVC alloc] init];
        //                @weakify(self);
        //                startVC.didSelectedEnter = ^ (NSInteger index){
        //                    @strongify(self);
        //                    if (index == 0) {
        //                        [self enterRegisterPage];
        //                    }else if(index == 1){
        //                        [self enterLoginPage];
        //                    }
        //                };
        //                BaseNavigationController *nav= [[BaseNavigationController alloc] initWithRootViewController:startVC];
        //                [self.window setRootViewController:nav];
        //            }else{
        ////                [NotifyHelper showMessageWithMakeText:error];
        //            }
        //        } ];
    }else{
        //        IntroductionVC* vc = [[IntroductionVC alloc]init];
        //        vc.didSelectedEnter = ^{
        //            StartPageVC *startVC = [[StartPageVC alloc] init];
        //            @weakify(self);
        //            startVC.didSelectedEnter = ^ (NSInteger index){
        //                @strongify(self);
        //                if (index == 0) {
        //                     [self enterRegisterPage];
        //                }else if(index == 1){
        //                     [self enterLoginPage];
        //                }
        //            };
        //            BaseNavigationController *nav= [[BaseNavigationController alloc] initWithRootViewController:startVC];
        //            [self.window setRootViewController:nav];
        //        };
        //        BaseNavigationController *nav= [[BaseNavigationController alloc] initWithRootViewController:vc];
        //        [self.window setRootViewController:nav];
        
        //        RegisterVC *vc = [[RegisterVC alloc]init];
        
        //        ForgetPwdVC *vc = [[ForgetPwdVC alloc]init];
        
        LoginVC *vc = [[LoginVC alloc]init];
        BaseNavigationController *nav= [[BaseNavigationController alloc] initWithRootViewController:vc];
        
        
        [self.window setRootViewController:nav];
    }
}

-(void)enterRegisterPage{
    //    RegisterPhoneViewController * registerVC = [[RegisterPhoneViewController alloc] init];
    //    @weakify(self);
    //    registerVC.didSelectedEnter = ^ (NSInteger index){
    //        @strongify(self);
    //        self.mainVC = [[MainViewController alloc] init];
    //        //BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:self.mainVC];
    //        [self.window setRootViewController:self.mainVC];
    //    };
    //
    //    [(BaseNavigationController *)self.window.rootViewController pushViewController:registerVC animated:YES];
    
}

-(void)enterLoginPage{
    LoginVC* vc  = [[LoginVC alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self.window setRootViewController:nav];
    
}



-(void)initKeyboardUtil{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    //控制整个功能是否启用。
    manager.enable = YES;
    //控制点击背景是否收起键盘
    manager.shouldResignOnTouchOutside = YES;
    //控制键盘上的工具条文字颜色是否用户自定义。  注意这个颜色是指textfile的tintcolor
    //    manager.shouldToolbarUsesTextFieldTintColor = YES;
    //中间位置是否显示占位文字
    //    manager.shouldShowTextFieldPlaceholder = YES;
    //设置占位文字的字体
    manager.placeholderFont = [UIFont boldSystemFontOfSize:17];
    //控制是否显示键盘上的工具条。
    manager.enableAutoToolbar = YES;
}

@end
