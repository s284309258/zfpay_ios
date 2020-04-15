//
//  UIViewController+Extension.m
//  Lcwl
//
//  Created by mac on 2018/12/6.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "ArrowheadMenu.h"// 箭头菜单
#import "UIColor+MoColor.h"

@implementation UIViewController (Extension)
- (void)showPopMenu:(NSArray *)titleArr iconArr:(NSArray *)iconArr sender:(UIButton *)sender {
    ArrowheadMenu *menu = [[ArrowheadMenu alloc] initCustomArrowheadMenuWithTitle:titleArr icon:iconArr menuUnitSize:CGSizeMake(155, 38) menuFont:[UIFont fontWithName:@"Helvetica" size:15.f] menuFontColor:[UIColor blackColor] menuBackColor:[UIColor whiteColor] menuSegmentingLineColor:[UIColor moLineLight] distanceFromTriggerSwitch:0 menuArrowStyle:MenuArrowStyleTriangle menuPlacements:ShowAtBottom showAnimationEffects:ShowAnimationZoom];
    
    
    menu.delegate = self;
    [menu presentMenuView:sender];
}
@end
