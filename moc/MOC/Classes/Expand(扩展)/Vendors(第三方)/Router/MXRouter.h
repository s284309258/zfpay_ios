//
//  MXRouter.h
//  MoPal_Developer
//
//  Created by yang.xiangbao on 16/3/28.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXRouter : NSObject

+ (MXRouter *)sharedInstance;

- (void)configureCurrentVC:(UIViewController *)vc;

+ (void)openURL:(NSString *)URLPattern;

+ (void)openURL:(NSString *)URLPattern parameters:(NSDictionary *)parameters;

- (void)popViewController;

- (UIViewController *)getTopViewController;

- (UINavigationController *)getTopNavigationController;

- (CGFloat)tabbarHeight;

- (NSInteger)curSelectedIndex;
@end
