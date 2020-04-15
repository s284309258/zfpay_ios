//
//  MXBatchRequest.m
//  MoPal_Developer
//
//  Created by aken on 16/10/13.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import "MXBatchRequest.h"
#import "YTKBatchRequest.h"
#import "MXRequest.h"

@implementation MXBatchRequest {
    
    NSArray<YTKRequest *> *_requestArray;
}

- (instancetype)initWithRequestArray:(NSArray<YTKRequest *> *)requestArray {
    self = [super init];
    if (self) {
        
        _requestArray = [requestArray copy];
    }
    return self;
}

- (void)startToBatchRequestWithSuccess:(void (^)(id responseObject))successBlock
                               failure:(void (^)(id errors))failureBlock {
    
    YTKBatchRequest * request = [[YTKBatchRequest alloc] initWithRequestArray:_requestArray];
    
    [request startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
        
        NSArray *requests = batchRequest.requestArray;
        if (successBlock) {
            successBlock(requests);
        }
        
    } failure:^(YTKBatchRequest *batchRequest) {
        
        NSArray *requests = batchRequest.requestArray;
        if (failureBlock) {
            failureBlock(requests);
        }
    }];
}


@end
