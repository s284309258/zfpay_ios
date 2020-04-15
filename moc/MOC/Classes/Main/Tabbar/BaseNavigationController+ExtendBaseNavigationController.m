//
//  BaseNavigationController+ExtendBaseNavigationController.m
//  Moxian
//
//  Created by 王 刚 on 14-4-23.
//  Copyright (c) 2014年 Moxian. All rights reserved.
//

#import "BaseNavigationController+ExtendBaseNavigationController.h"

@implementation BaseNavigationController (ExtendBaseNavigationController)

- (NSString *)iconImageNormal;
{
	return [[self.viewControllers safeObjectAtIndex:0] iconImageNormal];
}

- (NSString *)iconImageSelected{
    return [[self.viewControllers safeObjectAtIndex:0] iconImageSelected];
}


- (NSString *)tabTitle
{
	return [[self.viewControllers safeObjectAtIndex:0] tabTitle];
}


@end
