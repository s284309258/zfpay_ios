//
//  UIButton+ActionBlock.h
//  MoPal_Developer
//
//  Created by Fly on 15/9/11.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(UIButton* btn);

@interface UIButton (ActionBlock)

- (void)addAction:(ActionBlock)block;
- (void)addAction:(ActionBlock)block forControlEvents:(UIControlEvents)controlEvents;

@end
