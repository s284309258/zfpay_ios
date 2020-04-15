//
//  BaseTabBar.m
//  AxcAE_TabBar
//
//  Created by Axc on 2018/6/2.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "BaseTabBar.h"
#import "FBKVOController.h"

@interface BaseTabBar ()
@property (nonatomic, strong) FBKVOController *kvoController;
@end

@implementation BaseTabBar

- (FBKVOController *)kvoController {
    if (!_kvoController) {
        _kvoController = [FBKVOController controllerWithObserver:self];
    }
    
    return _kvoController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self observeBar];
}

- (void)observeBar {
    static BOOL isFirst = YES;
    if(!isFirst) {
        return;
    }
    
    isFirst = NO;
    
    if (@available(iOS 11.0, *)){
        CGRect barFrame = self.tabBar.frame;
        if(safeAreaInsetBottom() <= 0 || CGRectIsEmpty(barFrame)) {
            return;
        }
        
        for (UIView *bar in self.view.subviews) {
            if ([bar isKindOfClass:[UITabBar class]]) {
                //x的位置不变 y的位置你自己调调到UI满意 宽不变 高也不能变 最终只是改变一下y的相对位置
                //view.frame = CGRectMake(view.frame.origin.x, self.view.bounds.size.height-tabbarH, view.frame.size.width, tabbarH);
                [self observeBarFrame:bar frame:barFrame];
            }
        }
    }
}

- (void)observeBarFrame:(UIView *)bar frame:(CGRect)barFrame {
    @weakify(self)
    [self.kvoController observe:bar keyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(id observer, id object, NSDictionary *change) {
        @strongify(self)
        CGRect newFrame = [[change valueForKey:@"new"] CGRectValue];
        if(!CGRectEqualToRect(newFrame, barFrame)) {
            [self unobserveBarFrame:bar];
            bar.frame = barFrame;
            [self observeBarFrame:bar frame:barFrame];
        }
    }];
}

- (void)unobserveBarFrame:(UIView *)bar {
    [self.kvoController unobserve:bar keyPath:@"frame"];
}
@end
