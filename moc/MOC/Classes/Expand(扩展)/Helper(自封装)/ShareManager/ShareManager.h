//
//  ShareManager.h
//  AdvertisingMaster
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "WXApi.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShareManager : NSObject
//标题 内容 图片 下载链接
+ (void)shareToWeChatPlatform:(NSString *)title content:(NSString*)content image:(NSString *)image url:(NSString*)url vc:(UIViewController*)vc;


+ (void)shareToWeChatPlatform2:(NSString *)title content:(NSString*)content image:(NSString *)image url:(NSString*)url vc:(UIViewController*)vc;
@end

NS_ASSUME_NONNULL_END
