//
//  MXSeparatorLine.m
//  MoPal_Developer
//
//  Created by litiankun on 15/1/31.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MXSeparatorLine.h"

@implementation MXSeparatorLine


// 垂直分割线
+ (id)initVerticalLineHeight:(CGFloat)height orginX:(CGFloat)x orginY:(CGFloat)y {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, y, 0.5, height)];
    line.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];

    return line;
}

// 水平分割线
+ (id)initHorizontalLineWidth:(CGFloat)width orginX:(CGFloat)x orginY:(CGFloat)y {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];

    return line;
}

@end
