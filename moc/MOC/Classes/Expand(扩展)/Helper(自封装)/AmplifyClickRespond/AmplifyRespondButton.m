//
//  AmplifyRespondButton.m
//  MoPal_Developer
//
//  Created by xgh on 15/9/16.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "AmplifyRespondButton.h"

@implementation AmplifyRespondButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _expendDx = -10;
        _expendDy = -10;
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    //expand the clickable area
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, _expendDx, _expendDy);
    return CGRectContainsPoint(bounds, point);
}
@end
