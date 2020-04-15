//
//  UIColor+MoColor.h
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/10/21.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MoColor)

+ (UIColor *)moPlaceHolder;
///#3B3B3B R:59 G:59 B:59 0.23,0.23,0.23
+ (UIColor *)moBlack;
///深灰色 #808080 R:128 G:128 B:128 0.50,0.50,0.50
+ (UIColor *)moDarkGray;
+ (UIColor *)moTextGray;
///输入框提示文字颜色 //#CCCCCC R:204 G:204 B:204 0.8,0.8,0.8
+ (UIColor *)moPlaceholderLight;
//#D9D9D9 R:217 G:217 B:217 0.85,0.85,0.85
+ (UIColor *)moLineLight;
///默认背景色 #F7F7F7 R:247 G:247 B:247 0.97,0.97,0.97
+ (UIColor *)moBackground;
///紫色 #8964CB R:137 G:99 B:200  0.54,0.39,0.78
+ (UIColor *)moPurple;
///红色 255 73 73 1.0,0.29,0.29
+ (UIColor *)moRed;
///外分割线 #e5e5e5 R:229 G:229 B:229  0.9,0.9,0.9
+ (UIColor *)moLineLighter;
/// 0.44,0.76,0.93
+ (UIColor *)moBlue;
///橙色 250 82 30
+ (UIColor *)moOrange;
/// R:204 G:204 B:204
+(UIColor *)moBlueColor;
+ (UIColor *)moSubNameBlue;
+ (UIColor *)gameBackgroundColor;
+ (UIColor *)gameBlueColor;
+ (UIColor *)gameLightBlueColor;
+ (UIColor *)gameTabbarColor;
+ (UIColor *)gameSubTitleColor;
+ (UIColor *)gameCellLineColor;
+ (UIColor *)moGreen;
+ (UIColor *)darkGreen;
+ (UIColor *)separatorLine;

+ (UIColor *)colorWithHexString:(NSString *)color;

/// 从十六进制字符串获取颜色，
/// color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

///#3B3B3B R:59 G:59 B:59 0.23,0.23,0.23
+ (UIColor *)moGold;

+ (UIColor *)moLightGray;

+ (UIColor *)moBackColor;
@end
