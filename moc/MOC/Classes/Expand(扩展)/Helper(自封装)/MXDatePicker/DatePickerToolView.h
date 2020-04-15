//
//  DatePickerToolView.h
//  MoPal_Developer
//
//  Created by lhy on 15/11/10.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ok)(void);
typedef void(^cancel)(void);

@interface DatePickerToolView : UIView
///确定回调
@property(copy, nonatomic)ok okBlock;
///取消回调
@property(copy, nonatomic)cancel cancelBlock;

@end
