//
//  XWMoneyTextField.h
//  XWMoneyTextField
//
//  Created by smile.zhang on 16/3/10.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWMoneyTextFieldLimit.h"

@interface XWMoneyTextField : UITextField

//扩大点击区域
@property (nonatomic,assign) CGFloat expendDx;
@property (nonatomic,assign) CGFloat expendDy;

- (XWMoneyTextFieldLimit *)limit;

@end
