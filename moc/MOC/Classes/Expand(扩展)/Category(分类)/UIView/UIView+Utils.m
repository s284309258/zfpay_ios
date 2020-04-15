//
//  UIView+Utils.m
//  xue
//
//  Created by Fly on 15/7/20.
//  Copyright (c) 2015年 kungstrate.com. All rights reserved.
//

#import "UIView+Utils.h"
#import <POP.h>

@implementation UIView (Utils)

- (void)setCircleView{
    [self setViewCornerRadius:CGRectGetWidth(self.bounds)/2.0f];
}

- (void)setViewCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setPurpleBorderStyle{
    [self setViewCornerRadius:4.0f];
    self.layer.borderWidth = 1.0f;
    //self.layer.borderColor = [UIColor moPurple].CGColor;
}

- (UIImage *)convertViewToImage {
    CGSize size = self.bounds.size;
    //下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)convertViewToImageWithCornerRadius:(CGFloat)cornerRadius {
    CGSize size = self.bounds.size;
    //下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);

    [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius] addClip];
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    //[self drawRect:self.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)convertViewToImageWithBorder:(UIColor *)color width:(CGFloat)width cornerRadius:(CGFloat)cornerRadius {
    CGSize size = self.bounds.size;
    //下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius] addClip];
    //[self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    [color set];
    [path addClip];
    [path stroke];
    
    [self drawRect:self.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)shake {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 0.6;
    animation.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:animation forKey:nil];
}

- (void)addAlpha:(CGFloat)toValue duration:(CGFloat)duration block:(CompletionBlock)block {
    POPBasicAnimation *alphaAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alphaAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //alphaAnim.fromValue          = @(1);
    alphaAnim.toValue            = @(toValue);
    alphaAnim.duration           = duration;
    alphaAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        Block_Exec(block, nil);
    };
    [self pop_addAnimation:alphaAnim forKey:@"view.alpha"];
}

- (void)moveX:(CGFloat)toValue duration:(CGFloat)duration block:(CompletionBlock)block {
    POPBasicAnimation *positionAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    positionAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    positionAnim.toValue            = @(toValue);
    positionAnim.duration           = duration;
    positionAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        Block_Exec(block, nil);
    };
    [self pop_addAnimation:positionAnim forKey:@"positionY"];
}

- (void)moveY:(CGFloat)toValue block:(CompletionBlock)block {
    POPBasicAnimation *positionAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    positionAnim.toValue            = @(toValue);
    positionAnim.duration           = 0.25f;
    positionAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        Block_Exec(block, nil);
    };
    [self pop_addAnimation:positionAnim forKey:@"positionY"];
}

- (void)scaleXY:(CGSize)toValue duration:(CGFloat)duration comletion:(CompletionBlock)block {
    POPBasicAnimation *scaleAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //scaleAnim.fromValue          = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    scaleAnim.toValue            = [NSValue valueWithCGSize:toValue];
    scaleAnim.duration           = duration;
    scaleAnim.removedOnCompletion = YES;
    @weakify(self);
    scaleAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        @strongify(self);
        Block_Exec(block,self);
    };
    
    [self pop_addAnimation:scaleAnim forKey:@"scaleXY"];
}

- (void)rotation:(NSNumber *)toValue delay:(CGFloat)delay comletion:(CompletionBlock)block {
    POPBasicAnimation *rotationAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotationAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //rotationAnim.beginTime = CACurrentMediaTime() + 0.1;
    rotationAnim.duration = 1;
    rotationAnim.toValue = toValue;//[NSNumber numberWithFloat:M_PI/4];
    @weakify(self);
    rotationAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        @strongify(self);
        Block_Exec(block,self);
    };
    [self.layer pop_addAnimation:rotationAnim forKey:@"rotation"];
}

- (void)position:(CGPoint)toValue delay:(CGFloat)delay comletion:(CompletionBlock)block {
    POPBasicAnimation *positionAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    positionAnim.fromValue          = [NSValue valueWithCGPoint:self.layer.position];
    positionAnim.toValue            = [NSValue valueWithCGPoint:toValue];
    positionAnim.duration           = 1-delay;
    @weakify(self);
    positionAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        @strongify(self);
        Block_Exec(block,self);
    };
    [self.layer pop_addAnimation:positionAnim forKey:@"positionY"];
}

//仿网易圈圈点赞动画效果
- (void)like {
    [self shake];
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:self];
    UIView *view1 = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
    UIView *view2 = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
    view1.alpha = 0.5;
    view2.alpha = 0.8;
    view1.frame = self.bounds;
    view2.frame = self.bounds;
    view1.layer.position = self.layer.position;
    view2.layer.position = self.layer.position;
    view1.transform = CGAffineTransformMakeScale(0.7, 0.7);
    view2.transform = CGAffineTransformMakeScale(0.9, 0.9);
    [[self superview] addSubview:view1];
    [[self superview] addSubview:view2];
    
    [view1 addAlpha:0 duration:1 block:nil];
    [view1 rotation:[NSNumber numberWithFloat:-M_PI/4] delay:0 comletion:nil];
    [view1 position:CGPointMake(view1.centerX-15, view1.centerY-30) delay:0 comletion:^(id data) {
        [view1 removeFromSuperview];
    }];
    
    [view2 addAlpha:0 duration:1 block:nil];
    [view2 rotation:[NSNumber numberWithFloat:M_PI/4] delay:0.3 comletion:nil];
    [view2 position:CGPointMake(view2.centerX+20, view2.centerY-40) delay:0.3 comletion:^(id data) {
        [view2 removeFromSuperview];
    }];
    
    
}

- (void)addDashedBorder:(UIColor *)color corner:(CGFloat)corner {
    CAShapeLayer *border = [CAShapeLayer layer];
    
    //虚线的颜色
    border.strokeColor = color.CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:corner];
    
    //设置路径
    border.path = path.CGPath;
    
    border.frame = self.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    
    if(corner > 0) {
        self.layer.cornerRadius = 5.f;
        self.layer.masksToBounds = YES;
    }
    
    [self.layer addSublayer:border];
}

- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius,cornerRadius)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                             type:(UIRectCorner)corners {
    
    //    UIRectCorner type = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    
    //1. 加一个layer 显示形状
    CGRect rect = CGRectMake(borderWidth/2.0, borderWidth/2.0,
                             CGRectGetWidth(self.frame)-borderWidth, CGRectGetHeight(self.frame)-borderWidth);
    CGSize radii = CGSizeMake(cornerRadius, borderWidth);
    
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = borderColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    shapeLayer.lineWidth = borderWidth;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    [self.layer addSublayer:shapeLayer];
    
    
    
    
    //2. 加一个layer 按形状 把外面的减去
    CGRect clipRect = CGRectMake(0, 0,
                                 CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    CGSize clipRadii = CGSizeMake(cornerRadius, borderWidth);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:clipRect byRoundingCorners:corners cornerRadii:clipRadii];
    
    CAShapeLayer *clipLayer = [CAShapeLayer layer];
    clipLayer.strokeColor = borderColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    clipLayer.lineWidth = 1;
    clipLayer.lineJoin = kCALineJoinRound;
    clipLayer.lineCap = kCALineCapRound;
    clipLayer.path = clipPath.CGPath;
    
    self.layer.mask = clipLayer;
}
@end
