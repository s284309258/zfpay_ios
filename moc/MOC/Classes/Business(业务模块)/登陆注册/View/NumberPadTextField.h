//
//  NumberPadTextField.h
//  MoRadioFilterDemo
//
//  Created by fly on 16/1/9.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  重写了delegate方法，为了处理输入数字类型里的TextField
 */

@interface NumberPadTextField : UITextField

/**
 *  可以输入的字符长度 Default:20 text.length < maxLength
 */
@property (nonatomic, assign) NSUInteger maxInputLength;

/**
 *  除了可以输入数字外的特殊字符,必须使是NSString类型
 */
@property (nonatomic, copy  ) NSSet<NSString   *> *specialCharacters;

@end
