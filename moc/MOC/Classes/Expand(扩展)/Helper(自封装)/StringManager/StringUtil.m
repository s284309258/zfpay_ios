//
//  StringUtil.m
//  Spring
//
//  Created by Johnny Ling on 10-5-31.
//  Copyright 2010 Spring. All rights reserved.
//

#import "StringUtil.h"
#import "StringValidateUtil.h"
#import "CommonCrypto/CommonCryptor.h"
#import <CommonCrypto/CommonDigest.h>

@implementation StringUtil

+ (NSString *)transformToPinyin:(NSString *)ch {
    NSMutableString *mutableString = [NSMutableString stringWithString:ch];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    NSString *pinyinString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    pinyinString = [pinyinString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [pinyinString stringByReplacingOccurrencesOfString:@"'" withString:@""];
}

+ (NSString *)pinYinFirstLetterToUppercase:(NSString *)ch {
    NSString *hanzi = [self transformToPinyin:ch];
    char c = [hanzi characterAtIndex:0];
    
    if(isalpha(c)){ // 如果是英文字母,则大写,否则原字符显示
        hanzi = [[NSString stringWithFormat:@"%c",c] uppercaseString];
    } else {
        hanzi = @"#" ; //[NSString stringWithFormat:@"%c",c];
    }
    
    return hanzi;
}

+(NSString*)getLimitString:(NSString*) text limit:(NSUInteger) limit{
    BOOL bol = text.length > limit;
    NSString* colorString = (bol?@"red":@"gray");
    return [NSString stringWithFormat:@"<font color='%@'>%@</font><font color='gray'>/%@</font>",colorString,@(text.length),@(limit)];
    
}



#pragma mark -
#pragma mark - 转换空字符
+ (NSString *)convertEmpty:(NSString *)str {
	if ([StringValidateUtil isEmpty:str]) {
		return @"";
	}

	return str;
}
#pragma mark 将数字转换成字符,并指定位数,如果数字位数不够,则在前补0
+ (NSString *)patchZero:(NSInteger)number length:(NSInteger)len {
    NSMutableString *numStr = [[NSMutableString alloc] initWithFormat:@"%@",@(number) ];
    //NSString *numStr = [[NSString alloc] initWithFormat:@"%i", number];
    while ([numStr length] < len) {
        //numStr = [[NSString alloc] initWithFormat:@"0%@", numStr];
        [numStr insertString:@"0" atIndex:0];
    }
    
    return [numStr description];
}
/**
 * Convert 'yyyy-mm-dd' string to 'yyyymmdd' string
 * @param yyyy_mm_dd 'yyyy-mm-dd' string
 * @return 'yyyymmdd' string
 */
//+ (NSString *)getYYYYMMDDDateString:(NSString *)yyyy_mm_dd {
//	NSMutableString *result = [[NSMutableString alloc] init];
//	if (yyyy_mm_dd != nil && [yyyy_mm_dd length] == 10 && [yyyy_mm_dd indexOfAccessibilityElement:@"-"] > 3) {
//		NSArray *arr = [yyyy_mm_dd componentsSeparatedByString:@"-"];
//
//		if ([arr count] == 3) {
//			[result appendString:[arr safeObjectAtIndex:0]];
//			[result appendString:[arr safeObjectAtIndex:1]];
//			[result appendString:[arr safeObjectAtIndex:2]];
//		}
//	}
//
//	return result;
//}
/**
 * Convert 'yyyymmdd' string to 'yyyy-mm-dd' string
 * @param yyyymmdd 'yyyymmdd' string
 * @return 'yyyy-mm-dd' string
 */
+ (NSString *)getYYYY_MM_DDDateString:(NSString *)yyyymmdd {
    NSMutableString *result = nil;
    if (yyyymmdd != nil && [yyyymmdd length] == 8) {
        result = [[NSMutableString alloc]init];
        [result appendFormat:@"%@-", [yyyymmdd substringWithRange:NSMakeRange(0, 4)]];
        [result appendFormat:@"%@-", [yyyymmdd substringWithRange:NSMakeRange(4, 2)]];
        [result appendString: [yyyymmdd substringWithRange:NSMakeRange(6, 2)]];
    }else{
        result = [[NSMutableString alloc]initWithString:yyyymmdd];
    }
    return result;
}

#pragma mark -
#pragma mark - 去掉两端空格 @author xuHui 2011-07-13 此方法主要用于封装系统的方法
+ (NSString *)trim:(NSString *)str {
    if(str==nil){
        return @"";
    }else{
        //return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        @try {
            
            NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
            
            NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
            
            
            
            NSArray *parts = [str componentsSeparatedByCharactersInSet:whitespaces];
            
            NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
            
            NSString *newStr = [filteredArray componentsJoinedByString:@""];
            return newStr;
        }
        @catch (NSException *exception) {
            // 注释掉
            //DDLogError(@"%@",[exception reason]);
            return str;
        }
        @finally {
            
        }
    }
}
#pragma mark -
#pragma mark - 将字符串转换为日期 格式:yyyy-MM-dd		2011-7-13 @author:xuHui
+ (NSDate *)convertDateToString:(NSString *)dateStr {
    NSString *_year = [dateStr substringWithRange:NSMakeRange(0, 4)];
    NSString *_month = [dateStr substringWithRange:NSMakeRange(5, 2)];
    NSString *_day = [dateStr substringWithRange:NSMakeRange(8, 2)];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:[_year intValue]];
    [dateComponents setMonth:[_month intValue]];
    [dateComponents setDay:[_day intValue]];
    [dateComponents setHour:23];
    [dateComponents setMinute:59];
    [dateComponents setSecond:59];
    NSDate *returnDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    
    return returnDate;
}
#pragma mark -
#pragma mark - 两个时间相差的年数 | 格式:yyyy-MM-dd			2011-7-13 @author:xuHui
/**
 * ForExample:比较以下两个日期相差的年数
 * NSString *firstDateStr = @"2000-11-11";
 * NSString *secondDateStr = @"2001-11-11";
 * return: +1
 */
+ (NSInteger)compareYearDiffer:(NSString *)firstDateStr secondDate:(NSString *)secondDateStr {
    NSDate *_firstDate = [StringUtil convertDateToString:[StringUtil getYYYY_MM_DDDateString:firstDateStr]];
    NSDate *_secondDate = [StringUtil convertDateToString:[StringUtil getYYYY_MM_DDDateString:secondDateStr]];
    
    NSUInteger unitFlags = NSCalendarUnitYear;
    NSCalendar *chineseClendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *differTime = [chineseClendar components:unitFlags fromDate:_firstDate toDate:_secondDate options:0];
    
    return [differTime year];
}
#pragma mark -
#pragma mark - 两个时间相差的天数			2011-7-13 @author:xuHui
+ (NSUInteger)compareDayDiffer:(NSString *)firstDateStr secondDate:(NSString *)secondDateStr {
    NSDate *_firstDate = [StringUtil convertDateToString:[StringUtil getYYYY_MM_DDDateString:firstDateStr]];
    NSDate *_secondDate = [StringUtil convertDateToString:[StringUtil getYYYY_MM_DDDateString:secondDateStr]];
    
    NSUInteger unitFlags = NSCalendarUnitDay;
    NSCalendar *chineseClendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *differTime = [chineseClendar components:unitFlags fromDate:_firstDate toDate:_secondDate options:0];
    
    return [differTime day];
}
#pragma mark 返回日期字符串的文字描述，如当天是２０１３年５月１４日，而参数是：20130514,则返回值为“今天"，支持的返回值有：前天，昨天，今天，明天，后天，其它返回空字符串
+ (NSString *)formatDateComment:(NSString *)dateStr {
    NSString *str = nil;
    NSUInteger i = [StringUtil compareDayDiffer:[StringUtil formatterDateToString:[NSDate date] reg:@"YYYYMMdd"] secondDate:dateStr];
    switch (i) {
        case -2:{
            str = @"前天" ;
            break;
        }case -1:{
            str = @"昨天" ;
            break;
        }case 0:{
            str = @"今天";
            break;
        }case 1: {
            str = @"明天";
            break;
        }case 2: {
            str = @"后天" ;
            break;
        } default:{
            str = @"" ;
            break;
        }
    }
    
    return str;
}
+ (NSString *)getPrice:(double)d {
    NSNumber *n = [[NSNumber alloc] initWithDouble:d];
    NSString *str = [[NSString alloc] initWithFormat:@"%@%@", @"￥", [n stringValue]];
    return str ;
}
+ (NSString *)getPriceByString:(NSString *)d {
    NSNumber *n = [[NSNumber alloc] initWithDouble:[d doubleValue]];
    NSString *str = [[NSString alloc] initWithFormat:@"%@%@", @"￥", [n stringValue]];
    return str ;
}

#pragma mark 将日期对象格式化成字符串,格式化的格式由日期表达式reg指定,如:@"yyyy-MM-dd" 2011-7-15 @author:liuxianzhen
+ (NSString *)formatterDateToString:(NSDate *)nowDate reg:(NSString *)reg{
    if(nowDate==nil || reg==nil || [reg length]==0){
        return @"";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init] ;
    [formatter setDateFormat:reg];
    NSString * str = [formatter stringFromDate:nowDate];
    return str;
}


#pragma mark 将日期对象格式化成字符串,格式化的格式由日期表达式reg指定,如:@"yyyy-MM-dd" 2011-7-15 @author:liuxianzhen
+ (NSDate *)formatterStringToDate:(NSString *)nowDateStr reg:(NSString *)reg{
    if(nowDateStr==nil || [nowDateStr length]==0 || reg==nil || [reg length]==0){
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init] ;
    [formatter setDateFormat:reg];
    NSDate * date = [formatter dateFromString:nowDateStr];
    return date;
}


#pragma mark 获取对象在数组中的下标位置,如果不存在,返回-1
+ (NSUInteger)indexOfArrayByEquels:(NSArray *)array value:(id)obj {
    int i=-1;
    if(array!=nil && [array count]>0 && obj!=nil){
        BOOL b = NO;
        for (id v in array) {
            i++;
            if(v == obj){
                b = YES;
                break;
            }else if([[v description] isEqual:[obj description]]){
                b = YES;
                break;
            }
        }
        i = b?i:-1;
    }
    return i;
}


#pragma mark 只有booleanStr值为true时,返回值才会是YES,否则都为NO;
+ (BOOL)javaBooleanToIOSBool:(NSString *)booleanStr {
    if([@"true" isEqual:booleanStr] ){
        return YES;
    }else {
        return NO ;
    }
}
#pragma mark 将字符串转换成BOOL类型值，只有字符串为YES或0时，返回值才为YES
+ (BOOL) stringToBool:(NSString *)boolStr {
    if([@"YES" isEqualToString:boolStr]){
        return YES;
    }else{
        return NO;
    }
}


+ (MXGregorianDate)cfGregorianDateForNSDate:(NSDate *)date {
    NSString *s = [StringUtil formatterDateToString:date reg:@"yyyy-MM-dd hh:mm:ss"];
    MXGregorianDate d = [StringUtil stringDateToCFGregorianDate:s];
    return d;
}
#pragma mark
+ (NSDate *)nsDateForCFGregorianDate:(MXGregorianDate)date  {
    date.hour = 11;
    date.minute = 1;
    date.second = 1;
    NSString *s = [StringUtil cfGregorianDateToString:date];
    // 不知道什么原因,直接将字符串类型的日期转换成NS日期类型,会减少一天
    NSDate *d = [StringUtil formatterStringToDate:s reg:@"yyyy-MM-dd hh:mm:ss"];
    if(d==nil){
        d = [StringUtil formatterStringToDate:s reg:@"yyyy-MM-dd"];
    }
    
    return d;
}

+ (MXGregorianDate)stringDateToCFGregorianDate:(NSString *)nowDateStr {
    NSDate *date = [StringUtil formatterStringToDate:nowDateStr reg:@"yyyy-MM-dd hh:mm:ss"];
    if(date==nil){
        date = [StringUtil formatterStringToDate:nowDateStr reg:@"yyyy-MM-dd"];
    }
    MXGregorianDate cfdate ;
    NSInteger unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [cal components:unitFlags fromDate:date];
    cfdate.year = [comp year];
    cfdate.month = [comp month];
    cfdate.day = [comp day];
    return cfdate;
}


+ (NSString *)cfGregorianDateToString:(MXGregorianDate)nowDate {
    return [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",@((NSUInteger)nowDate.year),@(nowDate.month),@(nowDate.day),@(nowDate.hour),@(nowDate.minute),@((NSUInteger)nowDate.second)];
}
+ (NSString *)cfGregorianDateToStringYMD:(MXGregorianDate)nowDate {
    NSString *mStr = nil;
    if(nowDate.month<10){
        mStr = [NSString stringWithFormat:@"0%d",nowDate.month];
    }else{
        mStr = [NSString stringWithFormat:@"%d",nowDate.month];
    }
    NSString *dStr = nil;
    if(nowDate.day<10){
        dStr = [NSString stringWithFormat:@"0%d",nowDate.day];
    }else{
        dStr = [NSString stringWithFormat:@"%d",nowDate.day];
    }
    return [NSString stringWithFormat:@"%@-%@-%@",@((NSUInteger)nowDate.year),mStr,dStr];
}


+ (NSString *)cfGregorianDateToString:(MXGregorianDate)nowDate reg:(NSString *)reg {
    NSString *str = [StringUtil cfGregorianDateToString:nowDate];
    NSDate *d = [StringUtil formatterStringToDate:str reg:reg];
    str = [StringUtil formatterDateToString:d reg:reg];
    return str;
}


#pragma mark 计算reg字符串在str字符出现的个数
+ (NSUInteger)numberForString:(NSString *)str reg:(NSString *)reg {
    NSUInteger t = 0;
    NSUInteger index = [reg length];
    NSRange range =  [str rangeOfString:reg];
    while(range.length>0){
        //DDLogInfo(@"range.location=%d,range.length=%d",range.location,range.length);
        t++;
        str = [str substringFromIndex:range.location+index];
        range =  [str rangeOfString:reg];
    }
    return t;
}


#pragma mark 返回reg字符串在str字符串中最后出现的位置
+ (NSUInteger) lastIndexForString:(NSString *)str reg:(NSString *)reg {
    NSUInteger index = [reg length];
    NSRange range =  [str rangeOfString:reg];
    NSRange afterRange;
    //DDLogInfo(@"%@\r\n----------%@-----------",str,reg);
    int lastIndex = -1;
    while(range.length>0){
        //	DDLogInfo(@"range.location=%d,range.length=%d",range.location,range.length);
        str = [str substringFromIndex:range.location+index];
        afterRange = NSMakeRange(range.location, range.length);
        lastIndex += afterRange.location+afterRange.length;
        range =  [str rangeOfString:reg];
    }
    if(lastIndex>0){
        return lastIndex;
    }else{
        return -1;
    }
    
}


#pragma mark 对字符串的日期进行日期加减,日期格式为:yyyy-MM-dd
+ (NSString *)addDateByStr:(NSString *)dateStr addDay:(NSUInteger)dayNum {
    NSDate *date = [StringUtil formatterStringToDate:dateStr reg:@"yyyy-MM-dd"];
    NSDate *d = [StringUtil addDateByNsdate:date addDay:dayNum];
    NSString *newDateStr = [StringUtil formatterDateToString:d reg:@"yyyy-MM-dd"];
    return newDateStr;
}
#pragma mark 对CF日期进行日期加减，DAYNUM为正数表示加，负数表示减
+ (MXGregorianDate)addDateByCfdate:(MXGregorianDate)cfDate addDay:(NSUInteger)dayNum {
    NSDate *date = [StringUtil nsDateForCFGregorianDate:cfDate];
    NSDate *d = [StringUtil addDateByNsdate:date addDay:dayNum];
    MXGregorianDate newDate = [StringUtil cfGregorianDateForNSDate:d ];
    return newDate;
}
#pragma mark 对NS日期进行日期加减，dayNum为正数表示加，为负数表示减
+ (NSDate *)addDateByNsdate:(NSDate *)date addDay:(NSUInteger)dayNum {
    
    NSTimeInterval interval = dayNum * 24 * 60 * 60;
    NSDate *d = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    return d;
}

#pragma mark 将yyyy-MM-dd HH:mm:ss 格式字符串转换成yyyy.MM.dd
+ (NSString *)getDate:(NSString *)date
{
    if (!date) {
        return nil;
    }
    NSString *str = [date componentsSeparatedByString:@" "][0];
    return [str stringByReplacingOccurrencesOfString:@"-" withString:@"."];
}

#pragma mark 将yyyy-MM-dd HH:mm:ss 格式字符串转换成指定分隔符
+ (NSString *)getDate:(NSString *)date delimiter:(NSString *)delimiter
{
    if (!date) {
        return nil;
    }
    NSString *str = [date componentsSeparatedByString:@" "][0];
    return [str stringByReplacingOccurrencesOfString:@"-" withString:delimiter];
}

#pragma mark 删除指定字符串的结尾字符串
//+ (NSString *)removeEndsWith:(NSString *)resource arg:(NSString *)arg {
//	BOOL isClealIn = [StringValidateUtil endsWith:resource arg:arg];
//	if(isClealIn){
//		NSMutableString *sb = [[NSMutableString alloc] initWithString:resource];
//		NSRange range  = NSMakeRange([sb length]-[arg length], [arg length]);
//		[sb replaceCharactersInRange:range withString:@""];
//		return sb;
//	}else{
//		return resource;
//	}
//
//}


#pragma mark 根据文件路径或URL读取出文件名称
+ (NSString *)fileNameWithFilePath:(NSString *)uri {
    if (uri==nil) {
        return nil;
    }
    NSUInteger lastIndex = [StringUtil lastIndexForString:uri reg:@"/"];
    if (lastIndex==-1) {
        
        return [StringUtil calcMD5forString:uri];
        
    }else {
        return [uri substringFromIndex:lastIndex];
    }
    
}

#pragma mark - MD5加密 calcMD5forString
/**
 * MD5加密
 * @param str 需要加密字符串
 * @return 返回加密过后的字符串
 *
 */
+ (NSString *)calcMD5forString:(NSString*)str {

    if(str == nil || [str length] < 1) return nil;

    const char *value = [str UTF8String];

    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);

    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }

    return outputString ;

}

#pragma mark - MD5基本加密 createMD5
/**
 * MD5基本加密
 * @param signString 需要加密字符串
 * @return 返回加密过后的字符串
 *
 */
+ (NSString *)createMD5:(NSString *)signString {


    if ([StringValidateUtil isEmpty:signString]) {
        return @"";
    }
    const char *cStr =[signString UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];

}

//#pragma mark - kCCEncrypt 加密
//+ (NSString *)encryptWithText:(NSString *)sText
//{
//    //kCCEncrypt 加密
//    return [self encrypt:sText encryptOrDecrypt:kCCEncrypt key:@"des"];
//}
//
//#pragma mark - kCCDecrypt 解密
//+ (NSString *)decryptWithText:(NSString *)sText
//{
//    //kCCDecrypt 解密
//    return [self encrypt:sText encryptOrDecrypt:kCCDecrypt key:@"des"];
//}

#pragma mark - base64和DES和AES相结合
//+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key
//{
//    const void *dataIn;
//    size_t dataInLength;
//
//    if (encryptOperation == kCCDecrypt)//传递过来的是decrypt 解码
//    {
//        //解码 base64
//        NSData *decryptData = [Base64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];//转成utf-8并decode
//        dataInLength = [decryptData length];
//        dataIn = [decryptData bytes];
//    }
//    else  //encrypt
//    {
//        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
//        dataInLength = [encryptData length];
//        dataIn = (const void *)[encryptData bytes];
//    }
//
//    /*
//     DES加密 ：用CCCrypt函数加密一下，然后用base64编码下，传过去
//     DES解密 ：把收到的数据根据base64，decode一下，然后再用CCCrypt函数解密，得到原本的数据
//     */
//    //CCCryptorStatus ccStatus;
//    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
//    size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
//    size_t dataOutMoved = 0;
//
//    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
//    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
//    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
//
//    NSString *initIv = @"12345678";
//    const void *vkey = (const void *) [key UTF8String];
//    const void *iv = (const void *) [initIv UTF8String];
//
//    //CCCrypt函数 加密/解密
//    //CCCryptorStatus ccStatus =
//                     CCCrypt(encryptOperation,//  加密/解密
//                       kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
//                       kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
//                       vkey,  //密钥    加密和解密的密钥必须一致
//                       kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
//                       iv, //  可选的初始矢量
//                       dataIn, // 数据的存储单元
//                       dataInLength,// 数据的大小
//                       (void *)dataOut,// 用于返回数据
//                       dataOutAvailable,
//                       &dataOutMoved);
//
//    NSString *result = nil;
//
//    if (encryptOperation == kCCDecrypt)//encryptOperation==1  解码
//    {
//        //得到解密出来的data数据，改变为utf-8的字符串
//        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved] encoding:NSUTF8StringEncoding];
//    }
//    else //encryptOperation==0  （加密过程中，把加好密的数据转成base64的）
//    {
//        //编码 base64
//        NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
//        result = [Base64 stringByEncodingData:data];
//    }
//
//    return result;
//}

/// 将汉字转换成字母,如果原字符为字母,则不转换;如果原字符不是汉字,则不转换,首写字母转换为大写
+ (NSString *)chinasesCharToLetter:(NSString *)str {
    if(str == nil){
        return nil;
    }
    
    if ([StringValidateUtil charIsLetter:str]) {
        return str;
    }

    NSString *outputPinyin = [[[self transformToPinyin:str] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] uppercaseString];
    
    return outputPinyin;
}
//
///// 获取字符串的第一个字符并转换成大字返回,如果为空字符串直接返回NULL,如果第一个字符不是字母,则返回"#"
//+ (NSString *)firstUppercaseCharWithString : (NSString *)str {
//    if(str==nil || [str length]<=0){
//        return nil;
//    }
//    char c = [str characterAtIndex:0];
//    if([StringValidateUtil isValidateLetter:c]){
//        return [[NSString stringWithFormat:@"%c",c] uppercaseString];
//    }else {
//        return @"#";
//    }
//}
//


//判断中文字节长度
+ (NSUInteger)asciiLengthOfString: (NSString *) text
{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}
+ (NSUInteger)caculateChinese: (NSString *) text
{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        if(!isascii(uc))
            asciiLength += 2;
    }
    return asciiLength;
}

#pragma mark - 格式化字符串为多样式
+ (BOOL)isEmpty:(NSString *)str {
    return str == nil ||
    (![str isKindOfClass:[NSString class]]) ||
    [[StringUtil trim:str] length] == 0 ||
    [[str lowercaseString] isEqualToString:@"null"] ||
    [@"(null)" isEqualToString:str ]  ||
    [@"<null>" isEqualToString:str ] ;
}

#pragma mark - 计算显示字符串的宽度或高度

+ (CGSize)getSizeOfTextInfo:(NSString *)textInfo andFontSize:(CGFloat)fontSize andWidth:(CGFloat)width
{
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    if ((!textInfo) || (textInfo.length == 0)) {
        size.height = 0;
        size.width = 0;
        return size;
    }
    CGRect rect = [textInfo boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:Nil];
    return rect.size;
}

+ (CGSize)getSizeOfTextInfo:(NSString *)textInfo andFontSize:(CGFloat)fontSize andHeight:(CGFloat)height {
    CGSize size = CGSizeMake(CGFLOAT_MAX, height);
    CGRect rect = [textInfo boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:Nil];
    return rect.size;
}

+ (NSAttributedString*)stringWithAsciiLengthCount:(NSString*)content withMaxCount:(NSUInteger)maxCount{
    NSUInteger asciiLength = [StringUtil asciiLengthOfString:content];
    NSString* countString = $str(@"%@/%@",@(asciiLength),@(maxCount));
    NSMutableAttributedString* resultString = [[NSMutableAttributedString alloc] initWithString:countString];
    
    if (asciiLength > maxCount) {
        [resultString addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, [$str(@"%@",@(asciiLength)) length])];
    }
    return resultString;
}

+ (BOOL)isGroupApp {
    
    //CFBundleIdentifier
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    if ([@"com.moxian.mopal.group" isEqualToString:app_build]) {
        return YES;
    }else {
        return NO;
    }
}

+ (NSString *)replaceUnicodeToChinese:(NSString*)originalString{
    
    NSString *tempStr1 = [originalString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData
                                                           options:NSPropertyListImmutable
                                                                     format:NULL
                                                           error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

+(NSString *)integerToString:(NSInteger )num{
    return [NSString stringWithFormat:@"%ld",num];
}

+(NSString *)floatToString:(float )num{
    return [NSString stringWithFormat:@"%.2lf",num];
}

//匹配中文，英文字母和数字及_: ^[\u4e00-\u9fa5_a-zA-Z0-9]+$
+(BOOL)regexStr:(NSString *)str{
    NSString *regex = @"^[\u4e00-\u9fa5_a-zA-Z0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:str];
    return isValid;
}

+(NSString* )errorString{
    return @"非法字符";
}

+(NSMutableAttributedString*)addStrokeStyle:(NSString*) text textColor:(UIColor *)textColor font:(UIFont*)font strokeColor:(UIColor *)strokeColor{
    NSDictionary* dict =  @{
                            NSStrokeColorAttributeName:strokeColor,
                            NSStrokeWidthAttributeName : [NSNumber numberWithFloat:-5],
                            NSForegroundColorAttributeName:textColor,
                            NSFontAttributeName:font
                            };
    return [[NSMutableAttributedString alloc] initWithString:text attributes:dict];
}
@end
