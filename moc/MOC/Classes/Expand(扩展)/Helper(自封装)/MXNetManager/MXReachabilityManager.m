//
//  MXReachabilityManager.m
//  MoPal_Developer
//
//  Created by aken on 16/6/1.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import "MXReachabilityManager.h"
#import "AFNetworkReachabilityManager.h"

@implementation MXReachabilityManager

+ (BOOL)isNetWorkReachable {
    return  [AFNetworkReachabilityManager sharedManager].isReachable;
}
@end
