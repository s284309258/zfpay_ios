//
//  CALayer+Swizzling.m
//  Lcwl
//
//  Created by mac on 2019/1/14.
//  Copyright © 2019 lichangwanglai. All rights reserved.
//

#import "CALayer+Swizzling.h"
#import <objc/runtime.h>
#import "QNManager.h"
#import "CALayer+YYWebImage.h"

@implementation CALayer (Swizzling)
+ (void)load {
    Method originalMethod = class_getInstanceMethod([CALayer class], NSSelectorFromString(@"setImageWithURL:placeholder:options:manager:progress:transform:completion:"));
    Method swapMethod = class_getInstanceMethod([CALayer class], NSSelectorFromString(@"sd_SwizzlingSetImageWithURL:placeholder:options:manager:progress:transform:completion:"));
    method_exchangeImplementations(originalMethod, swapMethod);
}

- (void)sd_SwizzlingSetImageWithURL:(NSURL *)imageURL
            placeholder:(UIImage *)placeholder
                options:(YYWebImageOptions)options
                manager:(YYWebImageManager *)manager
               progress:(YYWebImageProgressBlock)progress
              transform:(YYWebImageTransformBlock)transform
             completion:(YYWebImageCompletionBlock)completion {
    NSURL *fixUrl = imageURL;
    if(fixUrl.host.length == 0) {
        fixUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,imageURL.absoluteString]];
    }
    [self sd_SwizzlingSetImageWithURL:fixUrl placeholder:placeholder options:options manager:manager progress:progress transform:transform completion:completion];
}
@end
