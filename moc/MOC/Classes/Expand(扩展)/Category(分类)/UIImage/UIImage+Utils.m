//
//  UIImage+Utils.m
//  HarkLive
//
//  Created by Fly on 15/6/27.
//  Copyright (c) 2015年 Fly. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

+ (UIImage*)createImageWithColor:(UIColor*)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 4.0f, 4.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage*)createImageWithColor:(UIColor*)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (BOOL)isValidMoChatFileSize{
    CGFloat fileSize = [self getImageFileSize];
    return fileSize <= MaxMoChatImageFileSize;
}

- (CGFloat)getImageFileSize{
    
    CGFloat perMBBytes = 1024 * 1024 * 1.0f;
    
    CGFloat scale = [[UIScreen mainScreen] scale] / 2.0f;
    return (self.size.width * self.size.height) / perMBBytes * scale;
//    
//    CGImageRef cgimage = self.CGImage;
//    size_t bpp = CGImageGetBitsPerPixel(cgimage);
//    size_t bpc = CGImageGetBitsPerComponent(cgimage);
//    size_t bytes_per_pixel = bpp / bpc;
//    
//    CGFloat lPixelsPerMB  = perMBBytes/bytes_per_pixel;
//    
//    
//    CGFloat totalPixel = CGImageGetWidth(self.CGImage)*CGImageGetHeight(self.CGImage);
//    
//    
//    CGFloat totalFileMB = totalPixel/lPixelsPerMB;
//    
//    return totalFileMB/4.0f;
}

+ (UIImage *)encodeQRImageWithContent:(NSString *)content size:(CGSize)size {
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    // 3.将字符串转换成NSdata
    NSData *data  = [content dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];
    CGRect extent = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.width/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
//    NSData *stringData = [content dataUsingEncoding: NSUTF8StringEncoding];
//
//    //生成
//    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    [qrFilter setValue:stringData forKey:@"inputMessage"];
//    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
//
//    UIColor *onColor = [UIColor blackColor];
//    UIColor *offColor = [UIColor whiteColor];
//
//    //上色
//    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
//                                       keysAndValues:
//                             @"inputImage",qrFilter.outputImage,
//                             @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
//                             @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
//                             nil];
//
//    CIImage *qrImage = colorFilter.outputImage;
//
//    //绘制
//    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
//    UIGraphicsBeginImageContext(size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
//    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    CGImageRelease(cgImage);
//    return codeImage;
}

- (CGFloat)scaleHeightForScreenWidth {
    CGFloat h = 0;
    h = self.size.height;
    if(self.size.width > SCREEN_WIDTH) {
        h = (SCREEN_WIDTH/self.size.width*self.size.height);
    } else if(self.size.width < SCREEN_WIDTH) {
        h = (SCREEN_WIDTH*self.size.height/self.size.width);
    }
    return h;
}

- (NSString *)scanQRCode {
    CGImageRef ref = self.CGImage;
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];     //2. 扫描获取的特征组
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:ref]];
    //3. 获取扫描结果
    if(features.count == 0) {
        return nil;
    }
    
    CIQRCodeFeature *feature = [features objectAtIndex:0];
    NSString *scannedResult = feature.messageString;
    return scannedResult;
}

@end
