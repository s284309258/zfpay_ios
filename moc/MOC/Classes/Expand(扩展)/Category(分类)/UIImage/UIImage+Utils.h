//
//  UIImage+Utils.h
//  HarkLive
//
//  Created by Fly on 15/6/27.
//  Copyright (c) 2015年 Fly. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MaxMoChatImageFileSize      10.0

@interface UIImage (Utils)

+ (UIImage*)createImageWithColor:(UIColor*)color;
+ (UIImage*)createImageWithColor:(UIColor*)color size:(CGSize)size;
- (BOOL)isValidMoChatFileSize;
- (CGFloat)getImageFileSize;
- (NSString *)scanQRCode;
+ (UIImage *)encodeQRImageWithContent:(NSString *)content size:(CGSize)size;
- (CGFloat)scaleHeightForScreenWidth;
@end
