//
//  UIImage+Color.m
//  MoPromo_Develop
//
//  Created by yang.xiangbao on 15/5/19.
//  Copyright (c) 2015年 MoPromo. All rights reserved.
//

#import "UIImage+Color.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[color colorWithAlphaComponent:.1] CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size alpha:(CGFloat)alpha
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[color colorWithAlphaComponent:alpha] CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)jsq_imageMaskedWithColor:(UIColor *)maskColor
{
    NSParameterAssert(maskColor != nil);
    
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextScaleCTM(context, 1.0f, -1.0f);
        CGContextTranslateCTM(context, 0.0f, -(imageRect.size.height));
        
        CGContextClipToMask(context, imageRect, self.CGImage);
        CGContextSetFillColorWithColor(context, maskColor.CGColor);
        CGContextFillRect(context, imageRect);
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *path = [paths[0] stringByAppendingPathComponent:@"bubble9.png"];
//    [UIImagePNGRepresentation(newImage) writeToFile:path atomically:YES];
    return newImage;
}


//加模糊效果，image是图片，blur是模糊度

+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    
    //模糊度,
    if (!image) {
        return nil;
    }
    if ((blur < 0.1f) || (blur > 2.0f)) {
        
        blur = 0.5f;
        
    }
    //boxSize必须大于0
    
    int boxSize = (int)(blur * 100);
    
    boxSize -= (boxSize % 2) + 1;
    
    NSLog(@"boxSize:%i",boxSize);
    
    //图像处理
    
    CGImageRef img = image.CGImage;
    
    //图像缓存,输入缓存，输出缓存
    
    vImage_Buffer inBuffer, outBuffer;
    
    vImage_Error error;
    
    //像素缓存
    
    void *pixelBuffer;
    
    
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    
    // provider’s data.
    
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    
    inBuffer.width = CGImageGetWidth(img);
    
    inBuffer.height = CGImageGetHeight(img);
    
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    
    //像数缓存，字节行*图片高
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    
    outBuffer.data = pixelBuffer;
    
    outBuffer.width = CGImageGetWidth(img);
    
    outBuffer.height = CGImageGetHeight(img);
    
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果
    
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    vImage_Buffer outBuffer2;
    
    outBuffer2.data = pixelBuffer2;
    
    outBuffer2.width = CGImageGetWidth(img);
    
    outBuffer2.height = CGImageGetHeight(img);
    
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    
    //颜色空间DeviceRGB
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    
    CGContextRef ctx = CGBitmapContextCreate(
                                             
                                             outBuffer.data,
                                             
                                             outBuffer.width,
                                             
                                             outBuffer.height,
                                             
                                             8,
                                             
                                             outBuffer.rowBytes,
                                             
                                             colorSpace,
                                             
                                             CGImageGetBitmapInfo(image.CGImage));
    
    
    
    //根据上下文，处理过的图片，重新组件
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    
    
    //clean up
    
    CGContextRelease(ctx);
    
    CGColorSpaceRelease(colorSpace);
    
    
    
    free(pixelBuffer);
    
    free(pixelBuffer2);
    
    CFRelease(inBitmapData);
    
    
    
//    CGColorSpaceRelease(colorSpace);
    
    CGImageRelease(imageRef);
    
    
    
    return returnImage;
    
}


@end
