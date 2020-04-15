//
//  FlagImgView.m
//  MOC
//
//  Created by mac on 2019/6/24.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "FlagImgView.h"

@implementation FlagImgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"起飞点"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressEffect:) name:@"JumpAtHere" object:nil];
    }
    return self;
}

- (void)pressEffect:(NSNotification *)noti {
    NSInteger index = [noti.object integerValue];
    if(index == 0) {
        CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        anima.toValue = [NSNumber numberWithFloat:10];
        anima.duration = 0.25;
        anima.autoreverses = YES;
        anima.repeatCount = 1;
        [self.layer addAnimation:anima forKey:@"position.y"];
        return;
    }
}
@end
