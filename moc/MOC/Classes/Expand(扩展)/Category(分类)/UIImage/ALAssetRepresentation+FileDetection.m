//
//  ALAssetRepresentation+FileDetection.m
//  MoPal_Developer
//
//  Created by Fly on 15/10/31.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import "ALAssetRepresentation+FileDetection.h"

@implementation ALAssetRepresentation (FileDetection)

- (BOOL)isValidMoChatFileSize{
    CGFloat fileSize = [self getImageFileSize];
    return fileSize <= MaxMoChatImageFileSize;
}

- (CGFloat)getImageFileSize{
    CGFloat fileSize = [self size]/1024/1024.0f;
    return fileSize;
}

@end
