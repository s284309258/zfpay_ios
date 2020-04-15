//
//  UIImageView+Swizzling.m
//  Lcwl
//
//  Created by mac on 2019/1/14.
//  Copyright © 2019 lichangwanglai. All rights reserved.
//

#import "UIImageView+Swizzling.h"
#import "UIImageView+YYWebImage.h"
#import "YYWebImageOperation.h"
#import "_YYWebImageSetter.h"
#import "YYKitMacro.h"
#import "QNManager.h"
#import <objc/runtime.h>

@implementation UIImageView (Swizzling)
+ (void)load {
    Method originalMethod = class_getInstanceMethod([UIImageView class], NSSelectorFromString(@"setImageWithURL:placeholder:options:manager:progress:transform:completion:"));
    Method swapMethod = class_getInstanceMethod([UIImageView class], NSSelectorFromString(@"yy_SwizzlingSetImageWithURL:placeholder:options:manager:progress:transform:completion:"));
    method_exchangeImplementations(originalMethod, swapMethod);
}

- (void)yy_SwizzlingSetImageWithURL:(NSURL *)imageURL
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
    [self yy_SwizzlingSetImageWithURL:fixUrl placeholder:placeholder options:options manager:manager progress:progress transform:transform completion:completion];
}
@end
