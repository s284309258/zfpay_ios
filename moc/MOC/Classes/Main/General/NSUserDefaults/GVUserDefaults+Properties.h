//
//  GVUserDefaults+Properties.h
//  MoPal_Developer
//
//  Created by Fly on 15/8/14.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "GVUserDefaults.h"
@interface GVUserDefaults (Properties)


@property (assign, nonatomic) NSString             *didLoadTopicDynamicIds;
@property (assign, nonatomic) BOOL                 didShowSayHiHint;


//@property (assign, nonatomic) MXMoXianServerDomain serverType;
//@property (assign, nonatomic) DebugLocation        debugLocation;
@property (strong, nonatomic) NSString             *locationAddress;

//最后一次更新地理位置的时间
@property (assign, nonatomic) NSTimeInterval       lastUpdateLocation;
//最后一次更新版本更新,最少三天才请求一次
@property (assign, nonatomic) NSTimeInterval       lastCheckAppVersion;
@property (copy,   nonatomic) NSString             *lastAppVersion;

@property (assign, nonatomic) BOOL                 isOpenNetWorkLog;
@property (assign, nonatomic) BOOL                 isOpenGTFuncation;

@property (assign, nonatomic) NSUInteger            errorRequestCount;
@property (assign, nonatomic) BOOL                  systemStatusIsValid;


- (void)resetErrorCount;

@end
