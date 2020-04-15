//
//  StringValidateUtil.h
//  MoPal_Developer
//
//  Created by aken on 15/2/4.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringValidateUtil : NSObject

+ (BOOL)isValidateEmail:(NSString *)email;//利用正则表达式验证邮箱合法性
+ (BOOL)isValidateName:(NSString *)string;//验证昵称是否包含非法字符

///验证是否为正整数
+ (BOOL)isValidatePositiveNum:(NSString *)string;
///验证是否为负整数
+ (BOOL)isValidateNegativeNum:(NSString *)string;
///验证是否为整数
+ (BOOL)isValidateIntegerNum:(NSString *)string;
///验证是否为非负整数 (正整数+0)
+ (BOOL)isValidateNotNegativeNum:(NSString *)string;
///验证是否为非正整数 (负整数+0)
+ (BOOL)isValidateNotIntegerNum:(NSString *)string;
///验证是否为正浮点数
+ (BOOL)isValidateFloatNum:(NSString *)string;
///验证是否为负浮点数
+ (BOOL)isValidateNegativeFloatNum:(NSString *)string;

//验证昵称是否包含非法字符(中间可以包含空格)，并且不能以空格开头或者结尾
+ (BOOL)isValidateMoXianNameFormat:(NSString*)string;
//验证昵称是否包含魔线”、“moxian”、“魔線
+ (BOOL)isValidateNameContainMoxian:(NSString *)string;
/// 验证电话号码是否合法,国家码如果为空,默认为判断电话号码长度大于2位数
+ (BOOL)isValidatePhoneNumber:(NSString *)phoneNumber areaCode:(NSString *)countryCode;//验证电话号码是否合法
+ (BOOL)isValidateNumber:(NSString *)string;
+ (BOOL)isValidateJobOrSchool:(NSString *)string;
+ (BOOL)isValidateLetter:(char)c ; // 判断是否为英文字母

#pragma mark -
#pragma mark - 判断是否为空
+ (BOOL)isEmpty:(NSString *)str;
#pragma mark -
#pragma mark - 判断是否全为英文字母	@author xuHui 2011-07-23
+ (BOOL)charIsLetter:(NSString *)word;
#pragma mark -
#pragma mark - 判断是否包含数字		@author xuHui 2011-07-23
+ (BOOL)charIsNum:(NSString *)word;
#pragma mark -
#pragma mark - 判断是否全为数字		@author xuHui 2011-07-26
+ (BOOL)charIsAllNum:(NSString *)word;
#pragma mark -
#pragma mark - 判断是否包含特殊符号	@author xuHui 2011-07-23
+ (BOOL)isSecureString:(NSString *)str;
#pragma mark -
#pragma mark - 判断是否含有数字或者特殊字符 @author xuHui 2011-06-23 | 合法:return YES
+ (BOOL)checkIllegalStr:(NSString *)str;

#pragma mark -
#pragma mark - 判断只能包含数字或字母
+(BOOL)charIsLetterOrNumber:(NSString *)word;


#pragma mark 判断字符串resource是否以arg结尾
+ (BOOL)endsWith:(NSString *)resource arg:(NSString *)arg ;
#pragma mark 判断字符串resource是否以arg开头
+ (BOOL)startsWith:(NSString *)resource arg:(NSString *)arg ;

#pragma mark -
#pragma mark - 忽略大小写比较		2011-7-11 @author:xuHui
+ (BOOL)equalsIgnoreCase:(NSString *)str1 str2:(NSString *)str2;

@end
