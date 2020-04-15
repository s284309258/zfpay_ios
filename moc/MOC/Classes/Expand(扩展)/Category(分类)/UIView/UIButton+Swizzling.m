//
//  UIButton+Swizzling.m
//  Lcwl
//
//  Created by mac on 2019/2/16.
//  Copyright © 2019 lichangwanglai. All rights reserved.
//

#import "UIButton+Swizzling.h"
#import "UIImageView+YYWebImage.h"
#import "YYWebImageOperation.h"
#import "_YYWebImageSetter.h"
#import "YYKitMacro.h"
#import "QNManager.h"
#import <objc/runtime.h>

@implementation UIButton (Swizzling)
+ (void)load {
    Method originalMethod = class_getInstanceMethod([UIButton class], NSSelectorFromString(@"sd_setImageWithURL:forState:placeholderImage:options:completed:"));
    Method swapMethod = class_getInstanceMethod([UIButton class], NSSelectorFromString(@"yy_SwizzlingSetImageWithURL:forState:placeholderImage:options:completed:"));
    method_exchangeImplementations(originalMethod, swapMethod);
}

- (void)yy_SwizzlingSetImageWithURL:(NSURL *)imageURL
                        forState:(UIControlState)state
                        placeholderImage:(UIImage *)placeholder
                            options:(SDWebImageOptions)options
                         completed:(SDExternalCompletionBlock)completed {
    NSURL *fixUrl = imageURL;
    if(fixUrl.host.length == 0) {
        fixUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,imageURL.absoluteString]];
    }
    [self yy_SwizzlingSetImageWithURL:fixUrl forState:state placeholderImage:placeholder options:options completed:completed];
}
@end
