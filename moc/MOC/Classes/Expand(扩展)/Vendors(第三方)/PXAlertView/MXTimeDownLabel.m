//
//  MXTimeDownLabel.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/9/12.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MXTimeDownLabel.h"
#import "NSDate+Utilities.h"
#import "NSDate+Formatter.h"
#import "NSDateFormatter+Category.h"
#import "NSString+DateFormatter.h"

@implementation MXTimeDownLabel
{
    dispatch_source_t timer;
}

- (instancetype)init {
    if(self = [super init]) {
        self.prefix = @"剩余时间：";
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%@ dealloc",[self class]);
}

- (void)clear
{
    if (timer) {
        dispatch_source_cancel(timer);
    }
}

- (void)setEndTime:(NSString *)endTime
{
    _endTime = endTime;
    [self useTimerRefreshTime];
}

#pragma mark - 刷新剩余时间
-(void)useTimerRefreshTime
{
    NSDateFormatter *dateFormatter = [NSDateFormatter formatterYYMMDDHHMMSS];
    NSDate *dd = [dateFormatter dateFromString:[_endTime yyyyMMddHHmmss]];
    NSDate *currentDate = [NSDate date];
    if(self.curTime) {
        currentDate = [dateFormatter dateFromString:[self.curTime yyyyMMddHHmmss]];
    } else {
        NSString *currentTime = [currentDate dateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
        currentDate = [dateFormatter dateFromString:[currentTime yyyyMMddHHmmss]];
    }
    
    __block NSInteger timeout = [dd timeIntervalSince1970] - [currentDate timeIntervalSince1970]; //倒计时时间
    
    if (timeout > 0 && _timeStart) {
        _timeStart();
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //没秒执行
    dispatch_source_set_event_handler(timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            @weakify(self)
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                //设置界面的按钮显示 根据自己需求设置
                self.text = @"";
                if (_timeOver) {
                    _timeOver();
                }
            });
        } else {
            
            NSString *strTime = @"";
            if(self.type == TimeDownTypeMMSS) {
                NSInteger minutes = timeout / 60;
                NSInteger seconds = timeout % 60;
                strTime = [NSString stringWithFormat:@"%@%@分%.2ld秒",self.prefix,@(minutes), (long)seconds];
            } else if(self.type == TimeDownTypeHHMMSS) {
                CGFloat interval = timeout;
                
                NSInteger day = interval / 3600 / 24;
                interval -= day*(3600*24);
                
                NSInteger hour = interval / 3600;
                interval -= hour*3600;
                
                NSInteger minutes = interval / 60;
                interval -= minutes*60;
                
                NSInteger seconds = interval;
                
                strTime = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",(long)hour,(long)minutes, (long)seconds];
            } else {
                CGFloat interval = timeout;
                
                NSInteger day = interval / 3600 / 24;
                interval -= day*(3600*24);
                
                NSInteger hour = interval / 3600;
                interval -= hour*3600;
                
                NSInteger minutes = interval / 60;
                interval -= minutes*60;
                
                NSInteger seconds = interval;
                
                strTime = [NSString stringWithFormat:@"%@%@天%@小时%@分%.2ld秒",self.prefix,@(day),@(hour),@(minutes), (long)seconds];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.text = strTime;
            });
            timeout--;
        }
    });
    dispatch_resume(timer);
}

@end
