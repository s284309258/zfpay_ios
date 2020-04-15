//
//  QNManager.h
//  Lcwl
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QiniuSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNManager : NSObject
+ (QNManager *)shared;
@property(nonatomic, copy) NSString *qnHost;

- (void)uploadImage:(UIImage *)image completion:(CompletionBlock)block;
- (void)uploadImages:(NSArray *)images assets:(NSArray *)assets completion:(CompletionBlock)block;
- (void)uploadAssets:(NSArray *)assets completion:(CompletionBlock)block;
- (void)uploadVideo:(PHAsset *)asset completion:(CompletionBlock)block;
- (void)uploadAudio:(NSString *)filePath completion:(CompletionBlock)block;
@end

NS_ASSUME_NONNULL_END
