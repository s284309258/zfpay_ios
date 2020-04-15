//
//  XWMoneyTextFieldLimit.h
//  XWMoneyTextField
//
//  Created by smile.zhang on 16/3/10.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol XWMoneyTextFieldLimitDelegate;

@interface XWMoneyTextFieldLimit : NSObject <UITextFieldDelegate>

@property (nonatomic, assign) id <XWMoneyTextFieldLimitDelegate> delegate;
@property (nonatomic, strong) NSString *max; // 默认99999.99

@property (nonatomic, assign) BOOL  isPureInt;//是否必须整形，如果为YES则不能输入小数点

- (void)valueChange:(id)sender;

@end

@protocol XWMoneyTextFieldLimitDelegate <NSObject>

- (void)valueChange:(id)sender;

@end
