//
//  MXBackButton.m
//  Moxian
//
//  Created by litiankun on 14-4-27.
//  Copyright (c) 2014年 Moxian. All rights reserved.
//

#import "MXBackButton.h"

@implementation MXBackButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setImage:[UIImage imageNamed:@"public_back"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"public_back"] forState:UIControlStateHighlighted];
    }
    return self;
}

// XIB默认的初始化方法
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self setImage:[UIImage imageNamed:@"public_back"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"public_back"] forState:UIControlStateHighlighted];
    }
    return self;
}

// 重置图片的位置和大小
- (void)layoutSubviews
{
    [super layoutSubviews];
    UIImageView *imageView = [self imageView];
    CGRect imageFrame = imageView.frame;
    // ltk M 2014-06-13 如果将此button添加到leftBarButtonItem上面的话，imageView的图标的X坐标就要调一下，不然往右偏
    if (IOS6_Later) {
        imageFrame.origin.x = -5;
    }else{
        imageFrame.origin.x = -10;
    }
//    imageFrame.size.width = 22;
//    imageFrame.size.height = 22;
//    imageFrame.origin.y = self.frame.size.height/2 - 22/2;
    //yangjiale
    imageFrame.size.width = 8;
    imageFrame.size.height = 15;
    imageFrame.origin.y = self.frame.size.height/2 - 15/2;
    imageView.frame = imageFrame;
    //end
    
    
}
@end
