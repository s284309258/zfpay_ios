//
//  AutoChangeLabelCount.h
//  MoPal_Developer
//
//  自动根据用户输入的字数来计算剩下可输入字数
//  Created by aken on 15/2/2.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoChangeLabelCount : NSObject

/**
 * 自动根据用户输入的字数来计算剩下可输入字数
 *
 *  @param sender           textfield/textView
 *  @param limitLabel       要显示的label
 *  @param titleLimitNumber 限制长度
 */
+(void)textEditChanged:(id)sender leftLimitLabel:(UILabel*)limitLabel  limitNumber:(NSInteger)titleLimitNumber;


/**
 * 自动根据用户输入的字数来累加起来，超过指定的数，则变红色
 *
 *  @param sender           textfield/textView
 *  @param limitLabel       要显示的label
 *  @param titleLimitNumber 限制长度
 */
+(void)textEditChanged:(id)sender increaseLimitLabel:(UILabel*)limitLabel  limitNumber:(NSInteger)titleLimitNumber;



@end
