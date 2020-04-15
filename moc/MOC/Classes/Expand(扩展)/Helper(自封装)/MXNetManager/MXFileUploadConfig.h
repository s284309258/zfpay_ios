//
//  MXFileUploadConfig.h
//  YTKDemo
//
//  文件上传相关属性配置
//  Created by aken on 16/9/29.
//  Copyright © 2016年 aken. All rights reserved.
//

#import <Foundation/Foundation.h>

// 上传文件所支持的类型
typedef CF_ENUM(NSInteger, MXFileUploadSupportType) {
    MXFileUploadSupportTypeImage = 0,
    MXFileUploadSupportTypeAudio = 1,
    MXFileUploadSupportTypeZipFile = 2
};


@interface MXFileUploadConfig : NSObject

/// 上传文件服务器url
+ (NSString*)uploadServiceUrl;

/*!
 @brief 上传文件所支持的类型
 @param type 上传文件所支持的类型附带额外参数
 @return 返回上传配置
 */
+ (NSDictionary*)supportUploadFileTypeConfig:(MXFileUploadSupportType)type;

@end

/// 用于支持上传文件的key
extern NSString * const kMXFileUploadSupportNameKey;
extern NSString * const kMXFileUploadSupportTypeKey;
extern NSString * const kMXFileUploadSupportFormKey;