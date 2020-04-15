//
//  MXFileUploadConfig.m
//  YTKDemo
//
//  Created by aken on 16/9/29.
//  Copyright © 2016年 aken. All rights reserved.
//

#import "MXFileUploadConfig.h"

//static NSString * const kMXUploadFileUrl = @"http://file.test.moxian.com/mo_common_fileuploadservice/m2/upload";

NSString * const kMXFileUploadSupportNameKey = @"MXFileUploadSupportNameKey";
NSString * const kMXFileUploadSupportTypeKey = @"MXFileUploadSupportTypeKey";
NSString * const kMXFileUploadSupportFormKey = @"MXFileUploadSupportFormKey";

@implementation MXFileUploadConfig


+ (NSString*)uploadServiceUrl {
    
    return @"";
}

+ (NSDictionary*)supportUploadFileTypeConfig:(MXFileUploadSupportType)type {
    
    NSDictionary *dictionary = @{kMXFileUploadSupportNameKey:@"jpg",
                                 kMXFileUploadSupportTypeKey:@"image/jpeg",
                                 kMXFileUploadSupportFormKey:@"uploadFile"};
    
    switch (type) {
        case MXFileUploadSupportTypeImage:
            return dictionary;
        case MXFileUploadSupportTypeAudio:
            dictionary = @{kMXFileUploadSupportNameKey:@"amr",
                           kMXFileUploadSupportTypeKey:@"audio/amr",
                           kMXFileUploadSupportFormKey:@"uploadFile"};
            return dictionary;
        case MXFileUploadSupportTypeZipFile:
            dictionary = @{kMXFileUploadSupportNameKey:@"zip",
                           kMXFileUploadSupportTypeKey:@"multipart/form-data",
                           kMXFileUploadSupportFormKey:@"uploadFile"};
            return dictionary;
            
        default:
            return dictionary;
    }
}



@end
