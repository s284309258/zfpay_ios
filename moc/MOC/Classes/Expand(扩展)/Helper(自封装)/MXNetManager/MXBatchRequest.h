//
//  MXBatchRequest.h
//  MoPal_Developer
//
//  批量请求接口
//  Created by aken on 16/10/13.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MXRequest;

@interface MXBatchRequest : NSObject

- (instancetype)initWithRequestArray:(NSArray<MXRequest *> *)requestArray;

- (void)startToBatchRequestWithSuccess:(void (^)(id responseObject))successBlock
                               failure:(void (^)(id errors))failureBlock;

@end
