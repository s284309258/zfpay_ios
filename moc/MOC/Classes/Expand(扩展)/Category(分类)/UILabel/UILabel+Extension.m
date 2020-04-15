//
//  UILabel+Extension.m
//  Lcwl
//
//  Created by mac on 2018/12/2.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "UILabel+Extension.h"
#import <POP.h>

@implementation UILabel (Extension)
-(void)count:(CGFloat)toValue completion:(CompletionBlock)block
{
    [self pop_removeAllAnimations];
    POPBasicAnimation *anim = [POPBasicAnimation animation];
    anim.duration = 1;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //NSLog(@"Animation type is %@",self.animationType);
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        Block_Exec(block,@(toValue));
    };
    
    NSArray *contentArr = [self.text componentsSeparatedByString:@" "];
    NSString *prefix = (contentArr.count > 1 ? [contentArr firstObject] : @"");
    NSString *value = (contentArr.count <= 1 ? [contentArr firstObject] : [contentArr safeObjectAtIndex:1]);
    
    POPAnimatableProperty * prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) {
        // read value
        prop.readBlock = ^(id obj, CGFloat values[]) {
            values[0] = [[obj description] floatValue];
        };
        // write value
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            [obj setText:[NSString stringWithFormat:@"%@ %.4f   ",prefix,values[0]]];
        };
        // dynamics threshold
        prop.threshold = 0.0001;
    }];
    
    anim.property = prop;
    
    anim.fromValue = @([value floatValue]);
    anim.toValue = @(toValue);
    
    [self pop_addAnimation:anim forKey:@"counting"];
}

- (void)addGestureRecognizer:(nullable id)target action:(nullable SEL)action {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}
@end
