//
//  CALayer+XibBorderColor.m
//  Lcwl
//
//  Created by mac on 2018/12/17.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "CALayer+XibBorderColor.h"
#import <UIKit/UIKit.h>

@implementation CALayer (XibBorderColor)
-(void)setBorderXibColor:(UIColor*)color{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderXibColor{
    return [UIColor colorWithCGColor:self.borderColor];
}
@end
