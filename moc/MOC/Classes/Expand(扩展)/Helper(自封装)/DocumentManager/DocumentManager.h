//
//  DocumentManager.h
//  MoPal_Developer
//
//  文件操作
//  Created by aken on 15/3/25.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocumentManager : NSObject

/**
 *  缓存目录
 *
 *  @return 目录路径
 */
+ (NSString *)cacheDocDirectory;

/**
 *  临时图片文件存放路径
 *
 *  @param tempImageString 文件名
 *
 *  @return 完整的本地路径
 */
+ (NSString*)fileSavePath:(NSString*)tempImageString;

/**
 *  聊天缓存目录
 *
 *  @return 目录路径
 */
+ (NSString *)chatCacheDocDirectory:(NSString*)name;
@end
