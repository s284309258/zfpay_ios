//
//  UIFont+MoFont.m
//  MoPromo_Develop
//
//  Created by yang.xiangbao on 15/10/21.
//  Copyright © 2015年 MoPromo. All rights reserved.
//

#import "UIFont+MoFont.h"
#import "MXCache.h"

@implementation UIFont (MoFont)

+ (UIFont *)font19
{
    static NSString *fontKey = @"font19";
    UIFont *font = [MXCache valueForKey:fontKey];
    if (!font) {
        font = [UIFont systemFontOfSize:19.f];
        [MXCache setValue:font forKey:fontKey];
    }
    
    return font;
}

+ (UIFont *)font17
{
    static NSString *fontKey = @"font17";
    UIFont *font = [MXCache valueForKey:fontKey];
    if (!font) {
        font = [UIFont systemFontOfSize:17.f];
        [MXCache setValue:font forKey:fontKey];
    }
    
    return font;
}

+ (UIFont *)font14
{
    static NSString *fontKey = @"font14";
    UIFont *font = [MXCache valueForKey:fontKey];
    if (!font) {
        font = [UIFont systemFontOfSize:14.f];
        [MXCache setValue:font forKey:fontKey];
    }
    
    return font;
}

+ (UIFont *)font15
{
    static NSString *fontKey = @"font15";
    UIFont *font = [MXCache valueForKey:fontKey];
    if (!font) {
        font = [UIFont systemFontOfSize:15.f];
        [MXCache setValue:font forKey:fontKey];
    }
    
    return font;
}


+ (UIFont *)font12
{
    static NSString *fontKey = @"font12";
    UIFont *font = [MXCache valueForKey:fontKey];
    if (!font) {
        font = [UIFont systemFontOfSize:12.f];
        [MXCache setValue:font forKey:fontKey];
    }
    
    return font;
}

+ (UIFont *)font11
{
    static NSString *fontKey = @"font11";
    UIFont *font = [MXCache valueForKey:fontKey];
    if (!font) {
        font = [UIFont systemFontOfSize:11.f];
        [MXCache setValue:font forKey:fontKey];
    }
    
    return font;
}


+ (UIFont *)font18
{
    static NSString *fontKey = @"font18";
    UIFont *font = [MXCache valueForKey:fontKey];
    if (!font) {
        font = [UIFont systemFontOfSize:18.f];
        [MXCache setValue:font forKey:fontKey];
    }
    
    return font;
}
+ (UIFont *)boldFont19
{
    static NSString *fontKey = @"boldFont19";
    UIFont *font = [MXCache valueForKey:fontKey];
    if (!font) {
         font = [UIFont systemFontOfSize:19 weight:UIFontWeightMedium];
        [MXCache setValue:font forKey:fontKey];
    }
    
    return font;
}

+ (UIFont *)boldFont17
{
    static NSString *fontKey = @"boldFont17";
    UIFont *font = [MXCache valueForKey:fontKey];
    if (!font) {
         font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
        [MXCache setValue:font forKey:fontKey];
    }
    
    return font;
}

+ (UIFont *)boldFont14
{
    static NSString *fontKey = @"boldFont14";
    UIFont *font = [MXCache valueForKey:fontKey];
    if (!font) {
        font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [MXCache setValue:font forKey:fontKey];
    }
    
    return font;
}

+ (UIFont *)boldFont12
{
    static NSString *fontKey = @"boldFont12";
    UIFont *font = [MXCache valueForKey:fontKey];
    if (!font) {
         font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [MXCache setValue:font forKey:fontKey];
    }
    
    return font;
}

+ (UIFont *)boldFont11
{
    static NSString *fontKey = @"boldFont11";
    UIFont *font = [MXCache valueForKey:fontKey];
    if (!font) {
         font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
        [MXCache setValue:font forKey:fontKey];
    }
    
    return font;
}

@end
