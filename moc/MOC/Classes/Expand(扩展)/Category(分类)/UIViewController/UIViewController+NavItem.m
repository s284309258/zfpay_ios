//
//  UIViewController+NavItem.m
//  MXPay
//
//  Created by yang.xiangbao on 15/8/1.
//  Copyright (c) 2015年 moxiangroup. All rights reserved.
//

#import "UIViewController+NavItem.h"

@implementation UIViewController (NavItem)

- (UIButton *)navButtonFrame:(CGRect)frame
                       title:(NSString *)title
                      action:(SEL)action
{
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    navBtn.frame = frame;
    navBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [navBtn setTitle:title forState:UIControlStateNormal];
    [navBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [navBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [navBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [navBtn setEnabled:NO];
    
    return navBtn;
}

- (void)setDefaultBackBnt:(ActionBlock)block {
    UIButton *backBnt = [[UIButton alloc] init];
    backBnt.frame = CGRectMake(0, 0, 60, 40);
    [backBnt addAction:block];
    [backBnt setImage:[UIImage imageNamed:@"public_back"] forState:UIControlStateNormal];
    [backBnt setImageEdgeInsets:UIEdgeInsetsMake(0, -35, 0, 0)];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBnt];
    self.navigationItem.leftBarButtonItem = barBtnItem;
}
@end
