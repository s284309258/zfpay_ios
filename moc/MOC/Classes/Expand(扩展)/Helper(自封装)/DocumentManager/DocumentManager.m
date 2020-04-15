//
//  DocumentManager.m
//  MoPal_Developer
//
//  Created by aken on 15/3/25.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "DocumentManager.h"
#import "UserModel.h"

@implementation DocumentManager


#pragma mark - 缓存目录
+ (NSString *)cacheDocDirectory {
    
    NSString *tempPath=nil;
    
    if (tempPath==nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        tempPath = [[paths safeObjectAtIndex:0] stringByAppendingPathComponent:@"Lcwl"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = FALSE;
        BOOL isDirExist = [fileManager fileExistsAtPath:tempPath isDirectory:&isDir];
        if(!(isDirExist && isDir)){
            
            [[NSFileManager defaultManager] createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        
    }
    return tempPath;
}

#pragma mark - 临时图片文件存放路径
+ (NSString*)fileSavePath:(NSString*)tempImageString {
//    return nil;
    NSString* filePath = [DocumentManager cacheDocDirectory];
    UserModel *userModel= AppUserModel;
    NSString* userCachesPath = [filePath stringByAppendingPathComponent:userModel.user_id];



    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:userCachesPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {

        [fileManager createDirectoryAtPath:userCachesPath withIntermediateDirectories:YES attributes:nil error:nil];
        // 作日志用
    }

    [fileManager changeCurrentDirectoryPath:[[DocumentManager cacheDocDirectory] stringByExpandingTildeInPath]];

    NSString *path = [userCachesPath stringByAppendingPathComponent:tempImageString];
    path = [NSString stringWithFormat:@"%@.jpg",path];
    return path;
}
+ (NSString *)chatCacheDocDirectory:(NSString*)name{
    
    NSString *tempPath=nil;
    
    if (tempPath==nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        tempPath = [[[paths safeObjectAtIndex:0] stringByAppendingPathComponent:@"Lcwl"] stringByAppendingPathComponent:name];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = FALSE;
        BOOL isDirExist = [fileManager fileExistsAtPath:tempPath isDirectory:&isDir];
        if(!(isDirExist && isDir)){
            
            [[NSFileManager defaultManager] createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        
    }
    return tempPath;
}
@end
