//
//  UIView+BlurView.m
//  ShowLove
//
//  Created by Fly on 15/6/26.
//  Copyright (c) 2015年 Fly. All rights reserved.
//

#import "UIImageView+BlurEffect.h"
//#import "UIImage+ImageEffects.h"

#define IS_IOS8_OR_LATER    (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)

#define BlurViewTag         119

@implementation UIImageView (BlurEffect)

- (void)setImageViewblurEffect:(UIColor*)bgColor{
//    for (UIView* subView in [self subviews]) {
//        if (subView.tag == BlurViewTag ||
//            subView.tag == (BlurViewTag + 1)) {
//            [subView removeFromSuperview];
//        }
//    }
//    if (IS_IOS8_OR_LATER) {
//        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        blurEffectView.backgroundColor = bgColor;
//        blurEffectView.frame = self.bounds;
//        blurEffectView.tag = BlurViewTag;
//        [self addSubview:blurEffectView];
//
//        UIView* maskView = [[UIView alloc] initWithFrame:self.bounds];
//        maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        maskView.backgroundColor = [UIColor blackColor];
//        maskView.alpha = 0.2;
//        maskView.tag = BlurViewTag + 1;
//        [blurEffectView addSubview:maskView];
//
//    }else{
//        [self setImage:[self.image applyBlurWithRadius:16 tintColor:[UIColor colorWithWhite:0.6 alpha:0.2] saturationDeltaFactor:1.0 maskImage:nil]];
//        UIView* maskView = [[UIView alloc] initWithFrame:self.bounds];
//        maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        maskView.backgroundColor = bgColor;
//        maskView.tag = BlurViewTag;
//        [self addSubview:maskView];
//    }
}

- (void)setImageViewblurEffect{
    //[self setImageViewblurEffect:[UIColor clearColor]];
}

@end
