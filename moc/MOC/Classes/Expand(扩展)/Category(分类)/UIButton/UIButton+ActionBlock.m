//
//  UIButton+ActionBlock.m
//  MoPal_Developer
//
//  Created by Fly on 15/9/11.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "UIButton+ActionBlock.h"
#import <objc/runtime.h>

@implementation UIButton (ActionBlock)

static char ActionTag;

- (void)addAction:(ActionBlock)block
{
    objc_setAssociatedObject(self, &ActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addAction:(ActionBlock)block forControlEvents:(UIControlEvents)controlEvents
{
    objc_setAssociatedObject(self, &ActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:controlEvents];
}

- (void)action:(id)sender
{
    ActionBlock blockAction = (ActionBlock)objc_getAssociatedObject(self, &ActionTag);
    if (blockAction)
    {
        blockAction(self);
    }
}

@end
