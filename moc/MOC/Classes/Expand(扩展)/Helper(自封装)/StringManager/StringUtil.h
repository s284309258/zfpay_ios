//
//  StringUtil.h
//  Spring
//
//  Created by Johnny Ling on 10-5-31.
//  Copyright 2010 Spring. All rights reserved.
//

#import <Foundation/Foundation.h>

#define $str(...)   [NSString stringWithFormat:__VA_ARGS__]

typedef struct {
    SInt32 year;
    SInt8 month;
    SInt8 day;
    SInt8 hour;
    SInt8 minute;
    double second;
} MXGregorianDate;

@interface StringUtil : NSObject


/// 获取汉字的首个拼音字母,并且转换为大写,如果不是拼音字母,则原字符显示
+ (NSString *)pinYinFirstLetterToUppercase:(NSString *)ch;

+ (NSString *)transformToPinyin:(NSString *)ch ;
#pragma mark - 判断是否为空
+ (BOOL)isEmpty:(NSString *)str;

+(NSString*)getLimitString:(NSString*) text limit:(NSUInteger) limit;
/**
 * 如果str为nil/(null)/null时,转换成空字符
 * @param str 转换字符串对象
 * @return 参数empty为YES时,返回空字符串,否则返回字符串本身
 */
+ (NSString *)convertEmpty:(NSString *)str;
/**
 * 将数字转换成字符,并指定位数,如果数字位数不够,则在前补0
 * @param number  数字,如:10
 * @param len  位数, 如:4
 * @return 指定位数的数字字符串 如:0010
 */
+ (NSString *)patchZero:(NSInteger)number length:(NSInteger)len;
/**
 * Convert 'yyyy-mm-dd' string to 'yyyymmdd' string
 * @param yyyy_mm_dd 'yyyy-mm-dd' string
 * @return 'yyyymmdd' string
 */
//+ (NSString *)getYYYYMMDDDateString:(NSString *)yyyy_mm_dd;
/**
 * Convert 'yyyymmdd' string to 'yyyy-mm-dd' string
 * @param yyyymmdd 'yyyymmdd' string
 * @return 'yyyy-mm-dd' string
 */
+ (NSString *)getYYYY_MM_DDDateString:(NSString *)yyyymmdd;


/**
 * 去掉两端空格
 * @author xuHui 2011-07-13 此方法主要用于封装系统的方法
 */
+ (NSString *)trim:(NSString *)str;
#pragma mark -
#pragma mark - 将字符串转换为日期 格式:yyyy-MM-dd		2011-7-13 @author:xuHui
+ (NSDate *)convertDateToString:(NSString *)dateStr;


#pragma mark 返回日期字符串的文字描述，如当天是2013年5月14日，而参数是：20130514,则返回值为“今天"，支持的返回值有：前天，昨天，今天，明天，后天，其它返回空字符串
+ (NSString *)formatDateComment:(NSString *)dateStr ;
/**
 * ForExample:比较以下两个日期相差的年数
 * NSString *firstDateStr = @"2000-11-11";
 * NSString *secondDateStr = @"2001-11-11";
 * return: +1
 */
+ (NSInteger)compareYearDiffer:(NSString *)firstDateStr secondDate:(NSString *)secondDateStr;
#pragma mark -
#pragma mark - 两个时间相差的天数			2011-7-13 @author:xuHui
+ (NSUInteger)compareDayDiffer:(NSString *)firstDateStr secondDate:(NSString *)secondDateStr;
/**
 * 将数字加上金额的字符开头
 */
+ (NSString *)getPrice:(double)d;
+ (NSString *)getPriceByString:(NSString *)d;
#pragma mark 将日期对象格式化成字符串,格式化的格式由日期表达式reg指定,如:@"yyyy-MM-dd" 2011-7-15 @author:liuxianzhen
+ (NSString *)formatterDateToString:(NSDate *)nowDate reg:(NSString *)reg;
#pragma mark 将日期对象格式化成字符串,格式化的格式由日期表达式reg指定,如:@"yyyy-MM-dd" 2011-7-15 @author:liuxianzhen
+ (NSDate *)formatterStringToDate:(NSString *)nowDateStr reg:(NSString *)reg;

+ (MXGregorianDate)cfGregorianDateForNSDate:(NSDate *)date ;
+ (NSDate *)nsDateForCFGregorianDate:(MXGregorianDate)date ;
#pragma mark 获取对象在数组中的下标位置,如果不存在,返回-1
+ (NSUInteger)indexOfArrayByEquels:(NSArray *)array value:(id)obj ;

+ (BOOL)javaBooleanToIOSBool:(NSString *)booleanStr ;

#pragma mark 将字符串转换成BOOL类型值，只有字符串为YES或0时，返回值才为YES
+ (BOOL) stringToBool:(NSString *)boolStr ;

+ (MXGregorianDate)stringDateToCFGregorianDate:(NSString *)nowDateStr ;
+ (NSString *)cfGregorianDateToString:(MXGregorianDate)nowDate ;
+ (NSString *)cfGregorianDateToStringYMD:(MXGregorianDate)nowDate ;
+ (NSString *)cfGregorianDateToString:(MXGregorianDate)nowDate reg:(NSString *)reg ;

#pragma mark 计算reg字符串在str字符出现的个数
+ (NSUInteger)numberForString:(NSString *)str reg:(NSString *)reg ;
#pragma mark 返回reg字符串在str字符串中最后出现的位置
+ (NSUInteger) lastIndexForString:(NSString *)str reg:(NSString *)reg ;

#pragma mark 对字符串的日期进行日期加减,日期格式为:yyyy-MM-dd
+ (NSString *)addDateByStr:(NSString *)dateStr addDay:(NSUInteger)dayNum ;
#pragma mark 对NS日期进行日期加减，dayNum为正数表示加，为负数表示减
+ (NSDate *)addDateByNsdate:(NSDate *)date addDay:(NSUInteger)dayNum ;
#pragma mark 对CF日期进行日期加减，DAYNUM为正数表示加，负数表示减
+ (MXGregorianDate)addDateByCfdate:(MXGregorianDate)cfDate addDay:(NSUInteger)dayNum ;

#pragma mark 将yyyy-MM-dd HH:mm:ss 格式字符串转换成yyyy.MM.dd
+ (NSString *)getDate:(NSString *)date;
#pragma mark 将yyyy-MM-dd HH:mm:ss 格式字符串转换成指定分隔符
+ (NSString *)getDate:(NSString *)date delimiter:(NSString *)delimiter;

#pragma mark 删除指定字符串的结尾字符串
//+ (NSString *)removeEndsWith:(NSString *)resource arg:(NSString *)arg ;

#pragma mark 根据文件路径或URL读取出文件名称
+ (NSString *)fileNameWithFilePath:(NSString *)uri ;

/*****************************************************************************加密操作***************************************************************/

#pragma mark - MD5加密
/**
 * MD5加密
 * @param str 需要加密字符串
 * @return 返回加密过后的字符串
 *
 */
+ (NSString *)calcMD5forString:(NSString*)str;

/**
 * MD5基本加密
 * @param signString 需要加密字符串
 * @return 返回加密过后的字符串
 *
 */
+ (NSString *)createMD5:(NSString *)signString;

#pragma mark - kCCEncrypt 加密
/**
 * kCCEncrypt 加密
 * @param sText  要加密的字符串
 * @return 加密后的字条串
 */
//+ (NSString *)encryptWithText:(NSString *)sText;

#pragma mark - kCCDecrypt 解密
/**
 * kCCDecrypt 解密
 * @param sText  要解密的字符串
 * @return 解密后的字条串
 */
//+ (NSString *)decryptWithText:(NSString *)sText;

/// 将汉字转换成字母,如果原字符为字母,则不转换;如果原字符不是汉字,则不转换,首写字母转换为大写
+ (NSString *)chinasesCharToLetter:(NSString *)str ;

/// 获取字符串的第一个字符并转换成大字返回,如果为空字符串直接返回NULL,如果第一个字符不是字母,则返回"Other"
//+ (NSString *)firstUppercaseCharWithString : (NSString *)str ;

+ (NSUInteger)asciiLengthOfString: (NSString *) text;//判断中文字节长度

+ (NSUInteger)caculateChinese: (NSString *) text;


//+(NSString*)makeUpAttributeString:(NSString*)string;
//+(NSString*)makeUpAttributeString:(NSString *)string withFontSize:(NSMutableArray*)fontArray;

#pragma mark - 计算显示字符串的宽度或高度
/**
 abstact:根据文本内容获取其显示大小
 textInfo:文本内容
 fontSize:字体大小
 width:所在view的宽度
 */
+ (CGSize)getSizeOfTextInfo:(NSString *)textInfo andFontSize:(CGFloat)fontSize andWidth:(CGFloat)width;
/*!
 @function getSizeOfTextInfo:andFontSize:andHeight:
 @abstract 计算固定高度显示文字的宽度
 @param (NSString*)textInfo: 文字信息
 @param (CGFloat)fontSize: 字体大小
 @param (CGFloat)height: 显示字体控件高度
 @return 显示字体控件的Size
 */
+ (CGSize)getSizeOfTextInfo:(NSString *)textInfo andFontSize:(CGFloat)fontSize andHeight:(CGFloat)height;

/**
 *  获取内容的字数，如果超过最大数（Ascii长度），数字显示为异常色
 *
 *  @param content  文本的内容
 *  @param maxCount 最大的字数
 *
 *  @return 显示的富文本
 */
+ (NSAttributedString*)stringWithAsciiLengthCount:(NSString*)content withMaxCount:(NSUInteger)maxCount;

+ (BOOL)isGroupApp;

/**
 *  把字符串中的unicode字符转换为中文字符 
 */
+ (NSString *)replaceUnicodeToChinese:(NSString*)originalString;

+(NSString *)integerToString:(NSInteger )num;

+(NSString *)floatToString:(float )num;
//匹配中文，英文字母和数字及_:
+(BOOL )regexStr:(NSString *)str;
//匹配中文，英文字母和数字及_: 错误提示
+(NSString* )errorString;

+(NSMutableAttributedString*)addStrokeStyle:(NSString*) text textColor:(UIColor *)textColor font:(UIFont*)font strokeColor:(UIColor *)strokeColor;

@end
