//
//  MXRouter.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 16/3/28.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import "MXRouter.h"
#import "MRRouter.h"
#import "MainViewController.h"
#import "TextChangeVC.h"
#import "PublishDynamic.h"

@interface MXRouter ()

@property (nonatomic, weak  ) UIViewController *vc;

@end

@implementation MXRouter

+ (MXRouter *)sharedInstance {
    static MXRouter *router;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[MXRouter alloc] init];
    });
    return router;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self configureRouter];
        });
    }
    return self;
}

- (void)configureCurrentVC:(UIViewController *)vc {
    self.vc = vc;
}

- (UINavigationController *)nav:(NSDictionary *)dict {
    return self.vc.navigationController;
}

- (UINavigationController *)getTopNavigationController {
    MainViewController *rootViewController = (MainViewController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
    return [rootViewController selectedNavigaitonController];
}

- (UIViewController *)getTopViewController {
    UINavigationController *naviViewController = [self getTopNavigationController];
    return [naviViewController.viewControllers lastObject];
}

- (void)popViewController {
    UIViewController *topVC = [self getTopViewController];
    [topVC.navigationController popViewControllerAnimated:YES];
}

- (UIViewController *)rootViewController {
    // 获取根式控制器rootViewController，并将rootViewController设置为当前主控制器（防止菜单弹出时，部分被导航栏或标签栏遮盖）
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootVC = window.rootViewController;
    rootVC.definesPresentationContext = YES;
    return rootVC;
}

//获取当前选中的tab
- (NSInteger)curSelectedIndex {
    MainViewController *rootViewController = (MainViewController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
    if([rootViewController isKindOfClass:[MainViewController class]]) {
        return rootViewController.axcTabBar.selectIndex;
    }
    return -1;
}


- (CGFloat)tabbarHeight {
    MainViewController *mainViewController = (MainViewController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
    return mainViewController.axcTabBar.height;
}

+ (void)openURL:(NSString *)URLPattern {
    [MRRouter openURL:URLPattern];
}

+ (void)openURL:(NSString *)URLPattern parameters:(NSDictionary *)parameters {
    [MRRouter openURL:URLPattern parameters:parameters];
}

- (void)configureRouter {
    @weakify(self)

    [MRRouter registerURL:@"lcwl://PublishDynamic" executingBlock:^id(NSString *sourceURL, NSDictionary *param) {
        
        PublishDynamic* vc = [[PublishDynamic alloc] init];
        vc.photosArr = [param valueForKey:@"photosArr"];
        vc.model = [param valueForKey:@"model"];
        vc.block = [param valueForKey:@"block"];
        vc.curSelectVideo = [[param valueForKey:@"curSelectVideo"] boolValue];
        vc.curSelectImages = [param valueForKey:@"photosArr"];
        vc.curSelectAssets = [param valueForKey:@"assets"];
        vc.type = [[param valueForKey:@"type"] integerValue];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [nav setDefinesPresentationContext:YES];
        [nav setModalPresentationStyle:UIModalPresentationCurrentContext];
        
        UIViewController *weakSelf = [param valueForKey:@"weakSelf"];
        if(weakSelf != nil && [weakSelf isKindOfClass:[UIViewController class]]) {
            [weakSelf presentViewController:nav animated:YES completion:nil];
        } else {
            [[self rootViewController] presentViewController:nav animated:YES completion:nil];
        }
        
        return nil;
    }];
    
    [MRRouter registerURL:@"lcwl://TextChangeVC" executingBlock:^id(NSString *sourceURL, NSDictionary *param) {
        
        TextChangeVC *vc = [[TextChangeVC alloc] init];
        vc.title = [param objectForKey:@"title"];
        vc.placeholder = [param objectForKey:@"placeholder"];
        vc.text = [param objectForKey:@"text"];
        vc.tipInfo = [param objectForKey:@"tipInfo"];
        vc.block = [param valueForKey:@"CompletionBlock"];
        [[self nav:param] pushViewController:vc animated:YES];
        return nil;
    }];
//    
//    [MRRouter registerURL:@"lcwl://MBWebVC" executingBlock:^id(NSString *sourceURL, NSDictionary *parameters) {
//        @strongify(self)
//        MBWebVC *vc = [[MBWebVC alloc] init];
//        
//        if (parameters[@"title"]) {
//            vc.navTitle = parameters[@"title"];
//        }
//        
//        if (parameters[@"url"]) {
//            vc.url = [NSURL URLWithString:parameters[@"url"]];
//        }
//        
//        if (parameters[@"baseUrl"]) {
//            vc.baseUrl = [NSURL URLWithString:parameters[@"baseUrl"]];
//        }
//        
//        if (parameters[@"content"]) {
//            vc.content = parameters[@"content"];
//        }
//        
//        if (parameters[@"lucencyNavi"]) {
//            vc.lucencyNavi = [parameters[@"lucencyNavi"] boolValue];
//        }
//        
//        if (parameters[@"webTitleWillDynamicChange"]) {
//            vc.webTitleWillDynamicChange = [parameters[@"webTitleWillDynamicChange"] boolValue];
//        }
//        
//        if (parameters[@"backgroundColor"]) {
//            vc.view.backgroundColor = parameters[@"backgroundColor"];
//        }
//        [[self nav:parameters] pushViewController:vc animated:YES];
//        
//        return nil;
//    }];
    
    [MRRouter sharedInstance].defaultExecutingBlock = ^(id object, NSDictionary *parameters) {
        @strongify(self)
        if (!object) {
            NSLog(@"controller 跳转失败");
            return;
        }
        
        UIViewController *vc = object;
        if (object && [object isKindOfClass:[NSString class]]) {
            vc = [[NSClassFromString(object) alloc] init];
            if (!vc) {
                NSLog(@"controller 跳转失败");
                return;
            }
        } else if (![object isKindOfClass:[UIViewController class]]) {
            NSLog(@"controller 跳转失败");
            return;
        }
        
        [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if([vc respondsToSelector:NSSelectorFromString(key)] && obj != nil) {
                [vc setValue:obj forKey:key];
            }
        }];
        
        [[self nav:parameters] pushViewController:vc animated:YES];
    };
    
    [self onlineRouter];
}

/**
 *  用于动态修改跳转
 */
- (void)onlineRouter {
    
}

@end
