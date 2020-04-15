//
//  MXFileManager.m
//  YTKDemo
//
//  Created by aken on 16/9/29.
//  Copyright © 2016年 aken. All rights reserved.
//

#import "MXFileManager.h"
#import "MXFileUploadApi.h"
#import "MXFileUploadConfig.h"
#import "MXFileUploadApi.h"

#import <AFHTTPSessionManager.h>
#import "YTKBatchRequest.h"

@interface MXFileManager()

@end

@implementation MXFileManager {
    
    AFHTTPSessionManager *_manager;
}

+ (instancetype)manager {
    return [[[self class] alloc] init];
}

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
    
        _manager = [AFHTTPSessionManager manager];
    }
    
    return self;
}

- (void)uploadImageWithDictionary:(NSDictionary *)dictionary
                         fromData:(NSData *)bodyData
                         progress:(void (^)(NSProgress *uploadProgress))uploadProgressBlock
                          success:(void (^)(id responseObject))successBlock
                          failure:(void (^)(NSError *error))failureBlock {
    
    NSCParameterAssert(bodyData);
    
    [_manager POST:[self uploadUrl] parameters:dictionary constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        NSDictionary *dict = [MXFileUploadConfig supportUploadFileTypeConfig:MXFileUploadSupportTypeImage];
        [formData appendPartWithFileData:bodyData
                                    name:dict[kMXFileUploadSupportFormKey]
                                fileName:dict[kMXFileUploadSupportNameKey]
                                mimeType:dict[kMXFileUploadSupportTypeKey]];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        uploadProgressBlock(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

- (void)uploadImageWithDictionary:(NSDictionary *)dictionary
                         fromData:(NSData *)bodyData
                          success:(void (^)(id responseObject))successBlock
                          failure:(void (^)(NSError *error))failureBlock {
    
    NSCParameterAssert(bodyData);
    
    MXFileUploadApi *api = [[MXFileUploadApi alloc] initWithParameter:dictionary imageData:bodyData];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *dic = (NSDictionary*)request.responseJSONObject;
        successBlock(dic);
        
    } failure:^(YTKBaseRequest *request) {
       failureBlock(request.error);;
    }];

    
}

- (void)uploadAudioWithDictionary:(NSDictionary *)dictionary
                        audioData:(NSData *)bodyData
                          success:(void (^)(id responseObject))successBlock
                          failure:(void (^)(NSError *error))failureBlock {
    
    NSCParameterAssert(bodyData);
    
    MXFileUploadApi *api = [[MXFileUploadApi alloc] initWithParameter:dictionary audioData:bodyData];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *dic = (NSDictionary*)request.responseJSONObject;
        successBlock(dic);
        
    } failure:^(YTKBaseRequest *request) {
        failureBlock(request.error);;
    }];
    
}

- (void)uploadMultipleImageWithDictionary:(NSDictionary *)dictionary
                               imagesData:(NSArray *)imagesData
                                  success:(void (^)(id responseObject))successBlock
                                  failure:(void (^)(id errors))failureBlock {
    
    NSCParameterAssert(imagesData);
    
    NSMutableArray *requestArray=[NSMutableArray array];
    
    for (NSData *imageData in imagesData) {
        
        MXFileUploadApi *api = [[MXFileUploadApi alloc] initWithParameter:dictionary imageData:imageData];
        [requestArray addObject:api];
    }
    
    
    YTKBatchRequest *batches = [[YTKBatchRequest alloc] initWithRequestArray:requestArray];
    
    [batches startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        
        NSMutableArray *imageArray=nil;
        NSArray *requests = batchRequest.requestArray;
        
        if (requests.count > 0) {
            
            imageArray=[NSMutableArray array];
            
            for (MXFileUploadApi *mApi in  requests) {
                
                [imageArray addObject:[mApi responseFileUrl]];
            }
        }
        
        successBlock(imageArray);

    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        
        NSMutableArray *imageArray=nil;
        NSArray *requests = batchRequest.requestArray;
        
        if (requests.count > 0) {
            
            imageArray=[NSMutableArray array];
            
            for (MXFileUploadApi *api in  requests) {
                
                if (api.error) {
                    [imageArray addObject:api.error];
                }
            }
        }
        
        failureBlock(imageArray);
        
    }];
}

#pragma mark - Private
- (NSString*)uploadUrl {
    return [MXFileUploadConfig uploadServiceUrl];
}

@end
