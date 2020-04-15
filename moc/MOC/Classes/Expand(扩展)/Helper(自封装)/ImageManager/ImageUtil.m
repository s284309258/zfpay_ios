//
//  RootViewController.h
//  pictureProcess
//
//  Created by Ibokan on 12-9-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageUtil.h"
#import "DocumentManager.h"

#define compressionRate 0.6

@implementation ImageUtil

static CGContextRef CreateRGBABitmapContext (CGImageRef inImage)// 返回一个使用RGBA通道的位图上下文 
{
	CGContextRef context = NULL; 
	CGColorSpaceRef colorSpace; 
	void *bitmapData; //内存空间的指针，该内存空间的大小等于图像使用RGB通道所占用的字节数。
	size_t bitmapByteCount;
	size_t bitmapBytesPerRow;
    
	size_t pixelsWide = CGImageGetWidth(inImage); //获取横向的像素点的个数
	size_t pixelsHigh = CGImageGetHeight(inImage); //纵向
    
	bitmapBytesPerRow	= (pixelsWide * 4); //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit(0-255)的空间
	bitmapByteCount	= (bitmapBytesPerRow * pixelsHigh); //计算整张图占用的字节数
    
	colorSpace = CGColorSpaceCreateDeviceRGB();//创建依赖于设备的RGB通道
	
	bitmapData = malloc(bitmapByteCount); //分配足够容纳图片字节数的内存空间
    
	context = CGBitmapContextCreate (bitmapData, pixelsWide, pixelsHigh, 8, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
    //创建CoreGraphic的图形上下文，该上下文描述了bitmaData指向的内存空间需要绘制的图像的一些绘制参数
    
	CGColorSpaceRelease( colorSpace ); 
    //Core Foundation中通过含有Create、Alloc的方法名字创建的指针，需要使用CFRelease()函数释放
    
	return context;
}

static unsigned char *RequestImagePixelData(UIImage *inImage) 
// 返回一个指针，该指针指向一个数组，数组中的每四个元素都是图像上的一个像素点的RGBA的数值(0-255)，用无符号的char是因为它正好的取值范围就是0-255
{
	CGImageRef img = [inImage CGImage]; 
	CGSize size = [inImage size];
    
	CGContextRef cgctx = CreateRGBABitmapContext(img); //使用上面的函数创建上下文
	
	CGRect rect = {{0,0},{size.width, size.height}};
    
	CGContextDrawImage(cgctx, rect, img); //将目标图像绘制到指定的上下文，实际为上下文内的bitmapData。
	unsigned char *data = CGBitmapContextGetData (cgctx); 
    
	CGContextRelease(cgctx);//释放上面的函数创建的上下文
	return data;
}

static void changeRGBA(int *red,int *green,int *blue,int *alpha, const float* f)//修改RGB的值
{
    int redV = *red;
    int greenV = *green;
    int blueV = *blue;
    int alphaV = *alpha;
    
    *red = f[0] * redV + f[1] * greenV + f[2] * blueV + f[3] * alphaV + f[4];
    *green = f[0+5] * redV + f[1+5] * greenV + f[2+5] * blueV + f[3+5] * alphaV + f[4+5];
    *blue = f[0+5*2] * redV + f[1+5*2] * greenV + f[2+5*2] * blueV + f[3+5*2] * alphaV + f[4+5*2];
    *alpha = f[0+5*3] * redV + f[1+5*3] * greenV + f[2+5*3] * blueV + f[3+5*3] * alphaV + f[4+5*3];
    
    if (*red > 255) 
    {
        *red = 255;
    }
    if(*red < 0)
    {
        *red = 0;
    }
    if (*green > 255) 
    {
        *green = 255;
    }
    if (*green < 0) 
    {
        *green = 0;
    }
    if (*blue > 255) 
    {
        *blue = 255;
    }
    if (*blue < 0) 
    {
        *blue = 0;
    }
    if (*alpha > 255) 
    {
        *alpha = 255;
    }
    if (*alpha < 0) 
    {
        *alpha = 0;
    }
}



+ (UIImage*)imageWithImage:(UIImage*)inImage withColorMatrix:(const float*) f
{
   UIImageOrientation ori = inImage.imageOrientation ;
    inImage = [UIImage imageWithCGImage:inImage.CGImage scale:1.0 orientation:UIImageOrientationUp];
	CGImageRef inImageRef = [inImage CGImage];
	size_t w = CGImageGetWidth(inImageRef);
	size_t h = CGImageGetHeight(inImageRef);
    
	unsigned char *imgPixel = RequestImagePixelData(inImage);
	
	int wOff = 0;
	int pixOff = 0;
	
    
	for(GLuint y = 0;y< h;y++)//双层循环按照长宽的像素个数迭代每个像素点
	{
		pixOff = wOff;
		
		for (GLuint x = 0; x<w; x++) 
		{
			int red = (unsigned char)imgPixel[pixOff];
			int green = (unsigned char)imgPixel[pixOff+1];
			int blue = (unsigned char)imgPixel[pixOff+2];
            int alpha = (unsigned char)imgPixel[pixOff+3];
            changeRGBA(&red, &green, &blue, &alpha, f);
            
            //回写数据
			imgPixel[pixOff] = red;
			imgPixel[pixOff+1] = green;
			imgPixel[pixOff+2] = blue;
            imgPixel[pixOff+3] = alpha;
            
           
			pixOff += 4; //将数组的索引指向下四个元素
		}
        
		wOff += w * 4;
	}
    
	NSInteger dataLength = w * h * 4;
    
    //下面的代码创建要输出的图像的相关参数
	CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, imgPixel, dataLength, NULL);

	int bitsPerComponent = 8;
	int bitsPerPixel = 32;
	NSInteger bytesPerRow = 4 * w;
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
	CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
	
	
	CGImageRef imageRef = CGImageCreate(w, h, bitsPerComponent, bitsPerPixel, bytesPerRow,colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);//创建要输出的图像
	
	UIImage *myImage = [UIImage imageWithCGImage:imageRef];
	myImage = [UIImage imageWithCGImage:myImage.CGImage scale:1.0 orientation:ori];
	CFRelease(imageRef);
	CGColorSpaceRelease(colorSpaceRef);
	CGDataProviderRelease(provider);
	return myImage;
}

//根据屏幕宽度来等比缩放
+ (UIImage *)imageForSreenWidth:(UIImage*)image
{
    if (image == nil) {
        return nil;
    }
    
    CGFloat h = image.size.height;
    if(image.size.width > SCREEN_WIDTH) {
        h = (SCREEN_WIDTH/image.size.width*image.size.height);
    } else if(image.size.width < SCREEN_WIDTH) {
        h = (SCREEN_WIDTH*image.size.height/image.size.width);
    }
    
    CGSize newSize = CGSizeMake(SCREEN_WIDTH, h);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, [[UIScreen mainScreen] scale]);//根据当前大小创建一个基于位图图形的环境
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];//根据新的尺寸画出传过来的图片
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//从当前环境当中得到重绘的图片
    
    UIGraphicsEndImageContext();//关闭当前环境
    
    return newImage;
}

//根据指定宽度来等比缩放
+ (UIImage *)imageForSreenWidth:(CGFloat)width image:(UIImage*)image
{
    if (image == nil || width <= 0) {
        return image;
    }
    
    CGFloat h = image.size.height;
    if(image.size.width > width) {
        h = (width/image.size.width*image.size.height);
    } else if(image.size.width < width) {
        h = (width*image.size.height/image.size.width);
    }
    
    CGSize newSize = CGSizeMake(width, h);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, [[UIScreen mainScreen] scale]);//根据当前大小创建一个基于位图图形的环境
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];//根据新的尺寸画出传过来的图片
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//从当前环境当中得到重绘的图片
    
    UIGraphicsEndImageContext();//关闭当前环境
    
    return newImage;
}

+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
   
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}
// 将UIView生成一个Image
+ (UIImage*)imageWithUIView:(UIColor*)color withSize:(CGSize)size {
    //创建一个画圈的View
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor=color;
    //创建一个bitmap的context
    //并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //[view.layer drawInContext:currnetContext];
    [view.layer renderInContext:currnetContext];
    //从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    //使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}
// 将UIView生成一个带圆角的Image
+ (UIImage*)imageWithUIView:(UIColor*)color withSize:(CGSize)size withCornerRadius:(CGFloat)radius {
    //创建一个画圈的View
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor=color;
    if (radius > 0.0f) {
        view.layer.cornerRadius=radius;
        view.layer.borderWidth = 0.5f;
        view.layer.borderColor = [UIColor separatorLine].CGColor;
    }
    
    //创建一个bitmap的context
    //并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //[view.layer drawInContext:currnetContext];
    [view.layer renderInContext:currnetContext];
    //从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    //使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 横向拉伸图片(类似android 9图的方法)
+ (UIImage*)imagewithStretch:(NSString*)imageUrl withSize:(CGSize)size{
    UIImage *image = [UIImage imageNamed:imageUrl];
    CGFloat top = size.height/2; // 顶端盖高度
    CGFloat bottom = size.height/2 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        // 伸缩后重新赋值
        image = [image resizableImageWithCapInsets:insets];

     return image;
}

#pragma mark - 横向拉伸图片(类似android 9图的方法)
/**
 * @param image 图片
 * @param size 尺寸大小
 * @return image
 */
+ (UIImage*)imageWithStretchImage:(UIImage*)image withSize:(CGSize)size {
    CGFloat top = size.height/2; // 顶端盖高度
    CGFloat bottom = size.height/2 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 伸缩后重新赋值
    return[image resizableImageWithCapInsets:insets];
    
}


#pragma mark - 纵向拉伸图片(类似android 9图的方法)
/**
 * @param image 图片
 * @param size 尺寸大小
 * @return image
 */
+ (UIImage*)imageWithStretchHoriImage:(UIImage*)image withSize:(CGSize)size {
    CGFloat top = 10; // 顶端盖高度
    CGFloat bottom = 10 ; // 底端盖高度
    CGFloat left = size.width/2; // 左端盖宽度
    CGFloat right = size.width/2; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 伸缩后重新赋值
    return[image resizableImageWithCapInsets:insets];
    
}

#pragma mark - 等比例压缩
/**
 * 等比例压缩:如果宽>高，则按宽/size.width来计算比例；反之亦然
 * @param image 图片
 * @param size 尺寸大小
 * @author ltk
 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image withImageSizeScaledToSize:(CGSize)newSize {
    
    if (image==nil) {
        return nil;
    }
    
    int h = image.size.height;
    int w = image.size.width;
    
    
    float b = newSize.width/w < newSize.height/h ? newSize.width/w : newSize.height/h;
    
    CGSize itemSize = CGSizeMake(floor(b*w), floor(b*h));
    
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);

    
    CGRect imageRect = CGRectMake(0, 0, floor(b*w), floor(b*h));
    
    [image drawInRect:imageRect];//根据新的尺寸画出传过来的图片
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//从当前环境当中得到重绘的图片
    
    UIGraphicsEndImageContext();//关闭当前环境
    
    return newImage;
    
}

+(NSString*)saveImageDataToCache:(NSData*)imageData{
    if (imageData) {
        NSString* tempPath = NSTemporaryDirectory();
        NSDate* date = [[NSDate alloc]init];
        NSTimeInterval interval = [date timeIntervalSinceNow];
        NSString* tempImageName = [NSString stringWithFormat:@"%f.png",interval];
        NSString* tempFile = [tempPath stringByAppendingPathComponent:tempImageName];
        return [imageData writeToFile:tempFile atomically:YES]?tempFile:@"";
    }
    return @"";
}

+(NSData*)turnUIImageToNSData:(UIImage*)image{
    NSData *data = nil;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    return data;
}

+(NSString*)saveImageToCache:(UIImage*)image{
    if (image) {
        NSData* data = [self turnUIImageToNSData:image];
        if (data && data != nil) {
            return [self saveImageDataToCache:data];
        }
    }
    return @"";
}


+(NSString*)writeToLocalWithPhoto:(UIImage*)image withName:(NSString*)imageName {
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //更改到待操作的目录下
    
    NSString* filePath = [DocumentManager cacheDocDirectory];
    
    [fileManager changeCurrentDirectoryPath:[[DocumentManager cacheDocDirectory] stringByExpandingTildeInPath]];
    
    //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    
    NSString *path = [filePath stringByAppendingPathComponent:imageName];
    path = [NSString stringWithFormat:@"%@.jpg",path];
    
    //创建数据缓冲     NSMutableData *writer = [[NSMutableData alloc] init];
    
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        
        data = UIImageJPEGRepresentation(image, 1);
        
    } else {
        
        data = UIImagePNGRepresentation(image);
    }
    BOOL isSuccess = [data writeToFile:path atomically:YES];
    if (isSuccess) {
        return path;
    }else{
        return nil;
    }
}

+ (NSData*)compressionImage:(UIImage*)image length:(NSInteger)length {
    
    return UIImageJPEGRepresentation(image, 0.4);
//    NSData *tempData = nil;
//    CGFloat compression = 1.0;
//    CGFloat maxCompression = 0.6f;
//
//    //当图片大小大于length并且压缩比例大于0.6时，图片循环压缩，
//    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
//    while ([imageData length] / 1024.0 > length &&
//           compression > maxCompression) {
//        compression -= 0.1;
//        imageData = UIImageJPEGRepresentation(image, compression);
//    }
//    
//    tempData = imageData;
//    return tempData;
}

// 图片加灰
+ (UIImage *)grayImage:(UIImage *)sourceImage
{
    int bitmapInfo = kCGImageAlphaNone;
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,      // bits per component
                                                  0,
                                                  colorSpace,
                                                  bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    CGContextRelease(context);
    return grayImage;
}

@end
