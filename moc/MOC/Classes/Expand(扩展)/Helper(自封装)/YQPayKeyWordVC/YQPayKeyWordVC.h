//
//  YQPayKeyWordVC.h
//  Youqun
//
//  Created by 王崇磊 on 16/6/1.
//  Copyright © 2016年 W_C__L. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    NormalPayType,
    QuotaPayType
} PayType;

@interface YQPayKeyWordVC : UIViewController

- (void)showInViewController:(UIViewController *)vc;

- (void)showInViewController:(UIViewController *)vc tiltle:(NSString *)title subtitle:(NSString *)subtitle block:(void (^)(NSString *))block;

- (void)showInViewController:(UIViewController *)vc type:(PayType)type dataDict:(NSDictionary*)data  block:(void (^)(NSString *))block;

@end
