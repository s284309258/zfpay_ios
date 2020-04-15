//
//  ALAssetRepresentation+FileDetection.h
//  MoPal_Developer
//
//  Created by Fly on 15/10/31.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

@interface ALAssetRepresentation (FileDetection)

#define MaxMoChatImageFileSize      10.0

- (BOOL)isValidMoChatFileSize;
- (CGFloat)getImageFileSize;

@end
