//
//  MXButton.h
//  Moxian
//  此按钮为本app所有的公共类,特别说明：
//  1.所有按钮的图片尺寸大小基本上为44 x 44
//  2.默认给按钮的大小是22 x 22
//  3.可以根据MXImagePositionStyle枚举来控制按钮图标的位置

//  Created by litiankun on 14-5-9.
//  Copyright (c) 2014年 Moxian. All rights reserved.
//

#import <UIKit/UIKit.h>


// 此处的image position指的是按钮中的imageView的图标位置
// 位置:左、居中、右、自定义偏移
typedef enum {
    MX_IMAGE_POSITION_LEFT = 1,
    MX_IMAGE_POSITION_CENTER,
    MX_IMAGE_POSITION_RIGHT,
    MX_IMAGE_POSITION_CUSTOM,
    MX_IMAGE_POSITION_VERTICAL_CENTER
} MXImagePositionStyle;

// 按钮背景图片样式
// 尺寸:小、中、大
typedef enum {
    MX_BACKGROUND_IMAGE_SMALL = 1,
    MX_BACKGROUND_IMAGE_MIDDLE,
    MX_BACKGROUND_IMAGE_LARGE
} MXButtonBackgroundImageStyle;

typedef enum {
    MXButtonBorderStyleGray = 0,
    MXButtonBorderStylePurple
} MXButtonBorderStyle;


@interface MXButton : UIButton
// 位置方向
@property (nonatomic) MXImagePositionStyle imagePositionStyle;
// 长和宽
@property (nonatomic) CGSize contentSize;
// 偏移x y
@property (nonatomic) CGPoint imageOffset;

//
@property (nonatomic,readwrite) MXButtonBorderStyle currentBorderStyle;
@property (nonatomic,readwrite)BOOL isHaveCircle;
@property (nonatomic,readwrite)BOOL defaultPurple;

/**
 * 根据按钮状态来加载小图,因为是9图,所以传尺寸参数
 * @param: controlState //按钮状态
 * @param: size // 尺寸大小
 */
+ (UIImage*)backgroundImageOfSmallImage:(UIControlState) controlState withCGSize:(CGSize) size;

/**
 * 根据按钮状态来加载中图,因为是9图,所以传尺寸参数
 * @param: controlState //按钮状态
 * @param: size // 尺寸大小
 */
+ (UIImage*)backgroundImageOfMiddleImage:(UIControlState) controlState withCGSize:(CGSize) size;

/**
 * 根据按钮状态来加载大图,因为是9图,所以传尺寸参数
 * @param: controlState //按钮状态
 * @param: size // 尺寸大小
 */
+ (UIImage*)backgroundImageOfLargeImage:(UIControlState) controlState withCGSize:(CGSize) size;


// 根据枚举来加载按钮图片背景
- (void)loadBackgroundImageWithStyle:(MXButtonBackgroundImageStyle) backgroundImageStyle;

// 画边框线
- (void)drawCircle;

- (void)setDefaultPurple;
@end
