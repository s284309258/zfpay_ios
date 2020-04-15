//
//  UIColor+MoColor.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/10/21.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import "UIColor+MoColor.h"
#import "MXCache.h"

@implementation UIColor (MoColor)


+ (UIColor *)moPlaceHolder
{
    static NSString *fontKey = @"moPlaceHolder";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithRed:150.0/255.0 green:153.0/255.0 blue:152.0/255.0 alpha:1.0f];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)moBlack
{
    static NSString *fontKey = @"moBlack";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1.0f];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)moGreen
{
    static NSString *fontKey = @"moGreen";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#399481"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)darkGreen
{
    static NSString *fontKey = @"darkGreen";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#069E7D"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}


+ (UIColor *)moTextGray
{
    static NSString *fontKey = @"moTextGray";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#9BA6BA"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)moDarkGray
{
    static NSString *fontKey = @"moDarkGray";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithRed:.50f green:.50f blue:.50f alpha:1.0f];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)moPlaceholderLight
{
    static NSString *fontKey = @"moPlaceholderLight";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithRed:.8f green:.8f blue:.8f alpha:1.0f];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)moLineLight
{
    static NSString *fontKey = @"moLineLight";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithRed:.85f green:.85f blue:.85f alpha:1.0f];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)moBackground
{
    static NSString *fontKey = @"moBackground";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#FAFAFA"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)moPurple
{
    static NSString *fontKey = @"moPurple";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithRed:.54f green:.39f blue:.78f alpha:1.0f];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)moBlue
{
    static NSString *fontKey = @"moBlue";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#85A6DD"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)moBlueColor
{
    static NSString *fontKey = @"moBlueColor";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithRed:60.0/255.0 green:106.0/255.0 blue:228.0/255.0 alpha:1.0];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}
+ (UIColor *)moRed
{
    static NSString *fontKey = @"moRed";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithRed:1.f green:.29f blue:.29f alpha:1.0f];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)moLineLighter//229 229 229
{
    static NSString *fontKey = @"moLineLighter";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#AEAEAE"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)moOrange
{
    static NSString *fontKey = @"moOrange";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#FF6E27"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)moSubNameBlue
{
    static NSString *fontKey = @"moSubNameBlue";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#3C4783"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

//+ (UIColor *)moOrange {
//    static NSString *fontKey = @"moOrange";
//    UIColor *color = [MXCache valueForKey:fontKey];
//    if (!color) {
//        color = [UIColor colorWithRed:0.98 green:0.32 blue:0.12 alpha:1.0f];
//        [MXCache setValue:color forKey:fontKey];
//    }
//    
//    return color;
//}

/////////////Game////////////
+ (UIColor *)gameBackgroundColor {
    static NSString *fontKey = @"gameBackgroundColor";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#15178A"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)gameBlueColor {
    static NSString *fontKey = @"gameBlueColor";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#52A7FF"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)gameLightBlueColor {
    static NSString *fontKey = @"gameLightBlueColor";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#4866BE"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)gameTabbarColor {
    static NSString *fontKey = @"gameTabbarColor";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#111c3d"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)gameSubTitleColor {
    static NSString *fontKey = @"gameSubTitleColor";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#B6BAE2"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)gameCellLineColor {
    static NSString *fontKey = @"gameCellLineColor";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#4968BE"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)separatorLine {
    static NSString *fontKey = @"separatorLine";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithRed:.9f green:.9f blue:.9f alpha:1.0f];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
        {
        return [UIColor clearColor];
        }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
        {
        cString = [cString substringFromIndex:2];
        }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
        {
        cString = [cString substringFromIndex:1];
        }
    if ([cString length] != 6)
        {
        return [UIColor clearColor];
        }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

+ (UIColor *)moGold{
    static NSString *fontKey = @"moGold";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#EA940E"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}

+ (UIColor *)moLightGray{
    static NSString *fontKey = @"moLightGray";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#999999"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}


+ (UIColor *)moBackColor{
    static NSString *fontKey = @"moBackColor";
    UIColor *color = [MXCache valueForKey:fontKey];
    if (!color) {
        color = [UIColor colorWithHexString:@"#F3F4F5"];
        [MXCache setValue:color forKey:fontKey];
    }
    
    return color;
}
@end
