//
//  MXFileUploadApi.h
//  YTKDemo
//
//  文件上传：图片或语音，该方法无上传进度回调
//  Created by aken on 16/9/27.
//  Copyright © 2016年 aken. All rights reserved.
//

#import "YTKRequest.h"
#import "MXFileUploadConfig.h"

@interface MXFileUploadApi : YTKRequest

/*!
 @brief 上传图片
 @param dictionary 附带额外参数
 @param imageData 图片二进制数据
 @return 返回请求对象
 */
- (instancetype)initWithParameter:(NSDictionary *)dictionary
                        imageData:(NSData*)data;

/*!
 @brief 上传语音
 @param dictionary 附带额外参数
 @param imageData 语音二进制数据
 @return 返回请求对象
 */
- (instancetype)initWithParameter:(NSDictionary *)dictionary
                        audioData:(NSData*)data;

- (instancetype)initWithType:(MXFileUploadSupportType)type parameter:(NSDictionary *)dictionary;

/// 网络请求完成后，返回的文件路径
- (NSString *)responseFileUrl;

@end


/// 用于缓放接收文件data
extern NSString * const kMXFileUploadReceiveFormDataKey;