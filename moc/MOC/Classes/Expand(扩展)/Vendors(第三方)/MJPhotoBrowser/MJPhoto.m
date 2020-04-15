//
//  MJPhoto.m
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <QuartzCore/QuartzCore.h>
#import "MJPhoto.h"

@interface MJPhoto ()

@property (nonatomic, strong) UIImage *backImage;

@end

@implementation MJPhoto

#pragma mark 截图

//fly 2015.10.21 修改placeHolder图片
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.placeholder = [UIImage imageNamed:@"register_head"];
    }
    return self;
}
- (UIImage *)capture:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)setSrcImageView:(UIImageView *)srcImageView
{
    _srcImageView = srcImageView;
    self.backImage = srcImageView.image;
    if (srcImageView.clipsToBounds) {
        _capture = [self capture:srcImageView];
    }
}


@end