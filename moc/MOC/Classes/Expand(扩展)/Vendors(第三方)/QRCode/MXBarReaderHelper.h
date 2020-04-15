//
//  MXBarReaderHelper.h
//  MoPal_Developer
//
//  Created by yuhx on 15/7/22.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    AddFriendType = 1,       //朋友
    AddShop,                 //商家
    AddGroup,                //群二维码
    SweepActivity,           //扫描活动
    SweepCardOneTime,        //扫卡单次
    SweepCodeOneMoreTime,    //扫码多次
    ThirdParty,              //第三方
    MoxianUrl,                //扫描m.moxian.com
    Grabs                    //扫描商家二维码送积分
} SweepType; // 扫描类型
@class MXBarReaderVC;

@interface MXBarReaderHelper : NSObject

- (instancetype)initWithBarReaderVC:(MXBarReaderVC*)barReaderVC;

#pragma mark-处理扫描数据
- (void)dealWithReadingData:(NSString *)qrCode;

+(NSString *)makeGroupQRCode:(NSString *)groupid invite:(NSString *)inviteId;

@end
