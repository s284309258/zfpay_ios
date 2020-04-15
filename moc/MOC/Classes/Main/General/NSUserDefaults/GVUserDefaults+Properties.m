//
//  GVUserDefaults+Properties.m
//  MoPal_Developer
//
//  Created by Fly on 15/8/14.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "GVUserDefaults+Properties.h"

@implementation GVUserDefaults (Properties)

@dynamic didLoadTopicDynamicIds;
@dynamic didShowSayHiHint;
//@dynamic serverType;
@dynamic lastUpdateLocation;
//@dynamic debugLocation;
@dynamic locationAddress;
@dynamic lastAppVersion;
@dynamic lastCheckAppVersion;
@dynamic isOpenNetWorkLog;
@dynamic isOpenGTFuncation;
@dynamic errorRequestCount;
@dynamic systemStatusIsValid;

- (void)resetErrorCount{
    self.errorRequestCount = 0;
//    MLog("<--->%@",@(self.errorRequestCount));
}


@end
