//
//  MX24HourPicker.h
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/6/11.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectTimeBlock)(NSArray *hourMin);

@interface MX24HourPicker : UIView

@property (nonatomic, strong) SelectTimeBlock selectTime;

- (void)showToView:(UIView*)view;
- (void)pickerSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end
