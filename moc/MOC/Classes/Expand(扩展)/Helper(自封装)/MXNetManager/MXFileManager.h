//
//  MXFileManager.h
//  YTKDemo
//
//  文件管理：上传和下载
//  Created by aken on 16/9/29.
//  Copyright © 2016年 aken. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXFileManager : NSObject

+ (MXFileManager *)manager;

///---------------------
/// 单文件上传
///---------------------

/*!
 @brief 上传图片,无上传进度回调
 @param dictionary 额外参数
 @param bodyData 图片二进制
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)uploadImageWithDictionary:(NSDictionary *)dictionary
                         fromData:(NSData *)bodyData
                          success:(void (^)(id responseObject))successBlock
                          failure:(void (^)(NSError *error))failureBlock;

/*!
 @brief 上传语音，无上传进度回调
 @param dictionary 额外参数
 @param bodyData 语音二进制
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)uploadAudioWithDictionary:(NSDictionary *)dictionary
                         audioData:(NSData *)bodyData
                          success:(void (^)(id responseObject))successBlock
                          failure:(void (^)(NSError *error))failureBlock;

///---------------------
/// 图片上传，带进度回调
///---------------------

/*!
 @brief 上传图片，带上传进度回调
 @param dictionary 额外参数
 @param bodyData 图片二进制
 @param uploadProgressBlock 进度回调
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)uploadImageWithDictionary:(NSDictionary *)dictionary
                         fromData:(NSData *)bodyData
                         progress:(void (^)(NSProgress *uploadProgress))uploadProgressBlock
                          success:(void (^)(id responseObject))successBlock
                     failure:(void (^)(NSError *error))failureBlock;

///---------------------
/// 多图片上传
///---------------------

/*!
 @brief 多图片上传，无上传进度回调
 @param dictionary 额外参数
 @param bodyData 二进制图片数组
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)uploadMultipleImageWithDictionary:(NSDictionary *)dictionary
                         imagesData:(NSArray *)imagesData
                          success:(void (^)(id responseObject))successBlock
                          failure:(void (^)(id errors))failureBlock;

@end
