//
//  UIView+Swizzling.m
//  Lcwl
//
//  Created by mac on 2019/1/11.
//  Copyright © 2019 lichangwanglai. All rights reserved.
//

#import "UIView+Swizzling.h"
#import "UIImageView+WebCache.h"
#import "UIView+WebCache.h"
#import <objc/runtime.h>
#import "QNManager.h"

@implementation UIView (Swizzling)
+ (void)load {
    Method originalMethod = class_getInstanceMethod([UIView class], NSSelectorFromString(@"sd_internalSetImageWithURL:placeholderImage:options:context:setImageBlock:progress:completed:"));
    Method swapMethod = class_getInstanceMethod([UIView class], NSSelectorFromString(@"sd_SwizzlingSetImageWithURL:placeholderImage:options:operationKey:setImageBlock:progress:completed:"));
    method_exchangeImplementations(originalMethod, swapMethod);
}

- (void)sd_SwizzlingSetImageWithURL:(nullable NSURL *)url
                  placeholderImage:(nullable UIImage *)placeholder
                           options:(SDWebImageOptions)options
                      operationKey:(nullable SDWebImageContext *)operationKey
                     setImageBlock:(nullable SDSetImageBlock)setImageBlock
                          progress:(nullable SDImageLoaderProgressBlock)progressBlock
                         completed:(nullable SDExternalCompletionBlock)completedBlock {
    NSURL *fixUrl = url;
    if ([fixUrl isKindOfClass:[NSString class]]) {
        fixUrl = [NSURL URLWithString:fixUrl];
    }else{
        if(fixUrl.host.length == 0) {
           fixUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,url.absoluteString]];
       }
    }
          
    [self sd_SwizzlingSetImageWithURL:fixUrl placeholderImage:placeholder options:options operationKey:operationKey setImageBlock:setImageBlock progress:progressBlock completed:completedBlock];
}
@end
