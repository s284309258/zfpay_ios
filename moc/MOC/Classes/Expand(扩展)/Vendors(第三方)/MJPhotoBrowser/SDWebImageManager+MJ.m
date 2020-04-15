//
//  SDWebImageManager+MJ.m
//  FingerNews
//
//  Created by mj on 13-9-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "SDWebImageManager+MJ.h"

@implementation SDWebImageManager (MJ)
+ (void)downloadWithURL:(NSURL *)url
{
    // cmp不能为空
    
    [SDWebImageManager.sharedManager loadImageWithURL:url options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
    }];
}
@end
