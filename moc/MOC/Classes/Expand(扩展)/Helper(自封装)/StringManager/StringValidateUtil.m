//
//  StringValidateUtil.m
//  MoPal_Developer
//
//  Created by aken on 15/2/4.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "StringValidateUtil.h"

#import "StringUtil.h"

@implementation StringValidateUtil


//利用正则表达式验证邮箱合法性
+ (BOOL)isValidateEmail:(NSString *)email
{
    email = [StringUtil trim:email];
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//验证昵称是否包含非法字符
+ (BOOL)isValidateName:(NSString *)string
{
    //添加不以空格开头，         ^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4E00-\u9FA5]+$
    NSString *stringRegex = @"^(?!_)(?!.*?_$)[a-zA-Z0-9_ \u4E00-\u9FA5]+$";
    NSPredicate *stringTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    return [stringTest evaluateWithObject:string];
}

+ (BOOL)isValidateMoXianNameFormat:(NSString*)string{
    if ([string hasPrefix:@" "] || [string hasSuffix:@" "]) {
        return NO;
    }
    //处理第三方输入法中的 fly Ⓜ 2016.04.11
    if ([string hasPrefix:@"Ⓜ"]) {
        return NO;
    }
    return [self isValidateName:string];
}

#pragma mark 验证是否为正整数
///验证是否为正整数
+ (BOOL)isValidatePositiveNum:(NSString *)string {
    NSString *regex = @"^[1-9]\\d*$";
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

#pragma mark 验证是否为负整数
///验证是否为负整数
+ (BOOL)isValidateNegativeNum:(NSString *)string {
    NSString *regex = @"^-[1-9]\\d*$";
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

#pragma mark 验证是否为整数
///验证是否为整数
+ (BOOL)isValidateIntegerNum:(NSString *)string {
    NSString *regex = @"^-?[1-9]\\d*$";
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

#pragma mark 验证是否为非负整数
///验证是否为非负整数 (正整数+0)
+ (BOOL)isValidateNotNegativeNum:(NSString *)string {
    NSString *regex = @"^[1-9]\\d*|0$";
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

#pragma mark 验证是否为非正整数
///验证是否为非正整数 (负整数+0)
+ (BOOL)isValidateNotIntegerNum:(NSString *)string {
    NSString *regex = @"^-[1-9]\\d*|0$";
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

#pragma mark 验证是否为正浮点数
///验证是否为正浮点数
+ (BOOL)isValidateFloatNum:(NSString *)string {
    NSString *regex = @"^[1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*$";
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

#pragma mark 验证是否为负浮点数
///验证是否为负浮点数
+ (BOOL)isValidateNegativeFloatNum:(NSString *)string {
    NSString *regex = @"^-[1-9]\\d*\\.\\d*|-0\\.\\d*[1-9]\\d*$";
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

//验证昵称是否包含魔线”、“moxian”、“魔線
+ (BOOL)isValidateNameContainMoxian:(NSString *)string
{
    BOOL isContain=NO;
    //special by lhy 魔线 -> 魔线 2016年01月23日
    if ([string hasPrefix:@"魔线"] ||
        [[string lowercaseString] hasPrefix:@"moxian"] ||
        [string hasPrefix:@"魔線"]) {
        isContain=YES;
    }
    return isContain;
}

+ (BOOL)isValidateJobOrSchool:(NSString *)string
{
    NSString *stringRegex = @"^(?!_)(?!.*?_$)[a-zA-Z0-9_ \u4e00-\u9fa5]+$";
    NSPredicate *stringTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    return [stringTest evaluateWithObject:string];
}

+ (BOOL)isValidateLetter:(char)c { // 判断是否全为英文字母
    
    return isalpha(c);
}

//验证电话号码是否合法
+ (BOOL)isValidatePhoneNumber:(NSString *)phoneNumber areaCode:(NSString *)countryCode
{
    //去掉空格
    phoneNumber =[phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];

    if([StringValidateUtil isEmpty:countryCode]){
        return  [phoneNumber length] > 2;
    } else if ([countryCode rangeOfString:@"86"].location != NSNotFound) {
        if (phoneNumber.length == 11) {
            return YES;
        }
    } else {
        return  [phoneNumber length]>2 ;
    }
    return NO;
}
//验证是否是0-9纯数字
+ (BOOL)isValidateNumber:(NSString *)string
{
    NSString *stringRegex = @"^[0-9]*$";
    NSPredicate *stringTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    return [stringTest evaluateWithObject:string];
}


#pragma mark -
#pragma mark - 判断是否为空
+ (BOOL)isEmpty:(NSString *)str {
    return str == nil || (![str isKindOfClass:NSString.class]) || [[StringUtil trim:str] length] == 0 || [[str lowercaseString] isEqualToString:@"null"] || [@"(null)" isEqualToString:str ]  || [@"<null>" isEqualToString:str ] ;
}
#pragma mark -
#pragma mark - 判断是否全为英文字母	@@author xuHui 2011-07-23
+ (BOOL)charIsLetter:(NSString *)word {
    for (int i = 0; i < [word length]; i++) {
        if (!isalpha([word characterAtIndex:i])) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark -
#pragma mark - 判断只能包含数字或字母
+(BOOL)charIsLetterOrNumber:(NSString *)word{

    NSCharacterSet *nonAlphabetChars = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
    
    NSLog(@"%i",[word rangeOfCharacterFromSet:nonAlphabetChars].location == NSNotFound);
    
    if ([word rangeOfCharacterFromSet:nonAlphabetChars].location == NSNotFound) {
        return YES;
    } 
    return NO;
}

#pragma mark -
#pragma mark - 判断是否包含数字		@author xuHui 2011-07-23
+ (BOOL)charIsNum:(NSString *)word {
    for (int i = 0; i < [word length]; i++) {
        if ([word characterAtIndex:i] >= '0' && [word characterAtIndex:i] <= '9') {
            return NO;// @"1"
        }
    }
    
    return YES;// @"a"
}
#pragma mark -
#pragma mark - 判断是否全为数字		@author xuHui 2011-07-26
+ (BOOL)charIsAllNum:(NSString *)word {
    if([[StringUtil convertEmpty:word] length]==0){
        return NO;
    }
    for (int i = 0; i < [word length]; i++) {
        if ([word characterAtIndex:i] < '0' || [word characterAtIndex:i] > '9') {
            return NO;
        }
    }
    
    return YES;
}
#pragma mark -
#pragma mark - 判断是否包含特殊符号	如果没有,则返回YES,有返回NO
+ (BOOL)isSecureString:(NSString *)str {
    NSString *notSecureStr = @"~!@#$%^&*()_+[{]}\\|;:'\",<.>/?";
    
    for (int i = 0; i < [notSecureStr length]; i++) {
        for (int j = 0; j < [str length]; j++) {
            if ([str characterAtIndex:j] == [notSecureStr characterAtIndex:i]) {
                return NO;
            }
        }
    }
    
    return YES;
}
#pragma mark -
#pragma mark - 判断是否含有数字或者特殊字符 @author xuHui 2011-06-23 | 合法:return YES
+ (BOOL)checkIllegalStr:(NSString *)str {
    if (![StringValidateUtil charIsNum:str] || ![StringValidateUtil isSecureString:str]) {
        return NO;
    }
    
    return YES;
}



#pragma mark 判断字符串resource是否以arg结尾
+ (BOOL)endsWith:(NSString *)resource arg:(NSString *)arg {
    if(resource==nil || arg==nil){
        return NO;
    }
    if([arg length]>[resource length]){
        return NO;
    }
    long int index = [resource length]-[arg length];
    
    NSString *substr = [resource substringFromIndex:index];
    if([arg isEqual:substr]){
        return YES;
    }else{
        return NO;
    }
}


#pragma mark 判断字符串resource是否以arg开头
+ (BOOL)startsWith:(NSString *)resource arg:(NSString *)arg {
    if(resource==nil || arg==nil){
        return NO;
    }
    if([arg length]>[resource length]){
        return NO;
    }
    NSString *substr = [resource substringToIndex:[arg length]];
    if([arg isEqual:substr]){
        return YES;
    }else{
        return NO;
    }
}

#pragma mark -
#pragma mark - 忽略大小写比较		2011-7-11 @author:xuHui
+ (BOOL)equalsIgnoreCase:(NSString *)str1 str2:(NSString *)str2 {
    return [str1 compare:str2 options:NSCaseInsensitiveSearch] == NSOrderedSame;
}
@end
