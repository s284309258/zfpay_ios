//
//  MXFileUploadApi.m
//  YTKDemo
//
//  Created by aken on 16/9/27.
//  Copyright © 2016年 aken. All rights reserved.
//

#import "MXFileUploadApi.h"

#import "AFNetworking.h"


NSString * const kMXFileUploadReceiveFormDataKey = @"MXFileUploadReceiveFormDataKey";

@interface MXFileUploadApi()

@property (nonatomic, copy)   NSMutableDictionary *paramDictionary;
@property (nonatomic, assign) MXFileUploadSupportType supportType;
@property (nonatomic, copy)   NSData *rawData;

@end

@implementation MXFileUploadApi


- (instancetype)initWithParameter:(NSDictionary *)dictionary
                        imageData:(NSData*)data  {
    
    NSCParameterAssert(dictionary);
    
    self.rawData = data;
    
    return [self initWithType:MXFileUploadSupportTypeImage parameter:dictionary];
}


- (instancetype)initWithParameter:(NSDictionary *)dictionary
                        audioData:(NSData*)data {
    
    NSCParameterAssert(dictionary);
    
    self.rawData = data;
    
    return [self initWithType:MXFileUploadSupportTypeAudio parameter:dictionary];
}


- (instancetype)initWithType:(MXFileUploadSupportType)type parameter:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        
        self.supportType = type;
        NSCParameterAssert(dictionary);
        
        if (dictionary) {

            self.paramDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary];
        }
    }
    
    return self;
}

- (NSString *)requestUrl {
    
    return [MXFileUploadConfig uploadServiceUrl];
}

- (YTKRequestMethod)requestMethod {
    
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {

    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return self.paramDictionary;
}

- (AFConstructingBlock)constructingBodyBlock {
    
    __block NSData *imageData = self.rawData;
    
    return ^(id<AFMultipartFormData> formData) {
        
        NSDictionary *dict = [MXFileUploadConfig supportUploadFileTypeConfig:self.supportType];
        [formData appendPartWithFileData:imageData
                                    name:dict[kMXFileUploadSupportFormKey]
                                fileName:dict[kMXFileUploadSupportNameKey]
                                mimeType:dict[kMXFileUploadSupportTypeKey]];
    };
}

- (NSString *)responseFileUrl {
    NSDictionary *dict = self.responseJSONObject;
    return (dict[@"data"] ?: @"");
}


@end
