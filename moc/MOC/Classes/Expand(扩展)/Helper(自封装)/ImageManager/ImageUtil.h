//
//  RootViewController.h
//  pictureProcess
//
//  Created by Ibokan on 12-9-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface ImageUtil : NSObject 

/**
 *
 *  @param inImage  原始图片
 *  @param f    滤镜参数
 *  @return 通过滤镜之后生成的图片
 */
+(UIImage *)imageWithImage:(UIImage*)inImage withColorMatrix:(const float*)f;
+(UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

///根据屏幕宽度来等比缩放
+ (UIImage *)imageForSreenWidth:(UIImage*)image;
///根据指定宽度来等比缩放
+ (UIImage *)imageForSreenWidth:(CGFloat)width image:(UIImage*)image;
// 将UIView生成一个Image
+(UIImage*)imageWithUIView:(UIColor*)color withSize:(CGSize)size;

// 将UIView生成一个带圆角的Image
+(UIImage*)imageWithUIView:(UIColor*)color withSize:(CGSize)size withCornerRadius:(CGFloat)radius;

// 横向拉伸图片(类似android 9图的方法)
+(UIImage*)imagewithStretch:(NSString*)imageUrl withSize:(CGSize)size;


/**
 * 横向拉伸图片(类似android 9图的方法)
 * @param image 图片
 * @param size 尺寸大小
 * @return image
 */
+(UIImage*)imageWithStretchImage:(UIImage*)image withSize:(CGSize)size;
/**
 * 纵向拉伸图片(类似android 9图的方法)
 * @param image 图片
 * @param size 尺寸大小
 * @return image
 */
+(UIImage*)imageWithStretchHoriImage:(UIImage*)image withSize:(CGSize)size ;

/**
 * 等比例压缩:如果宽>高，则按宽/size.width来计算比例；反之亦然
 * @param image 图片
 * @param size 尺寸大小
 * @date 2014-05-26
 * @author ltk
 */
+(UIImage*)imageWithImageSimple:(UIImage*)image withImageSizeScaledToSize:(CGSize)newSize;

/**
 * 保存图片到本地
 * @param imageData 图片数据对象
 * @param size 尺寸大小
 * @date 2014-06-30
 * @author wg
 */
+(NSString*)saveImageDataToCache:(NSData*)imageData;
/**
 * 图片转化为NSData对象
 * @param image 图片
 * @date 2014-06-30
 * @author wg
 */
+(NSData*)turnUIImageToNSData:(UIImage*)image;
/**
 * 图片转化为NSData对象
 * @param image 图片
 * @date 2014-06-30
 * @author wg
 */
+(NSString*)saveImageToCache:(UIImage*)image;

+(NSString*)writeToLocalWithPhoto:(UIImage*)image withName:(NSString*)imageName;

+ (NSData*)compressionImage:(UIImage*)image length:(NSInteger)length ;

// 图片加灰
+ (UIImage *)grayImage:(UIImage *)sourceImage;

@end
