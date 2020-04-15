//
//  MXTimeDownLabel.h
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/9/12.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TimeDownType) {
    TimeDownTypeMMSS = 0,
    TimeDownTypeYYMMDDHHMMSS,
    TimeDownTypeHHMMSS
};

typedef void (^TimeOverBlock) (void);

@interface MXTimeDownLabel : UILabel

//该值应该是赋服务器的时间，如果没有取当前系统时间
@property (nonatomic, copy) NSString *curTime;
/// 倒计时结束时间
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) TimeOverBlock timeStart;
@property (nonatomic, copy) TimeOverBlock timeOver;
@property (nonatomic, assign) TimeDownType type;
@property (nonatomic, copy) NSString *prefix;
- (void)clear;

@end
