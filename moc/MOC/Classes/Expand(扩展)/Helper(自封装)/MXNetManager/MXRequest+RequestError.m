//
//  MXBaseRequest+RequestError.m
//  MoPromo_Develop
//
//  Created by yang.xiangbao on 15/9/7.
//  Copyright (c) 2015年 MoPromo. All rights reserved.
//

#import "MXRequest+RequestError.h"

#import "MXReachabilityManager.h"


@implementation MXRequest (RequestError)

- (NSString *)requestError
{
    NSString *error;
    BOOL isReachable =[MXReachabilityManager isNetWorkReachable];
    if(!isReachable) {
        error = [self requestServerErrorString];
    } else {
        error = [self requestNetWorkErrorString];
    }
    
    return error;
}

@end
