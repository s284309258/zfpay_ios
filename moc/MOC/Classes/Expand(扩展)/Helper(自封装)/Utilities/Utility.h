//
//  Utility.h
//
//
//  Created by vera on 15/5/29.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject

/**
 判断是否有网络
 */
+ (BOOL)isNetworkReachaility;
/**
 *  格式化分享,收藏,下载 次数
 *
 *  @param aShare    分享
 *  @param aDownLoad 收藏
 *  @param aFavorite 下载
 *
 *  @return <#return value description#>
 */
+ (NSString *)formatShareAndDownloadAndFavoriteWithShare:(NSString *)aShare
                                                DownLoad:(NSString *)aDownLoad
                                                Favorite:(NSString *)aFavorite;

/**
 *  单价的格式化
 *
 *  @param price <#price description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)formatPrice:(NSString *)price;

/**
 *  格式化appName
 *
 *  @param aName     <#aName description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)formatName:(NSString *)aName withIndexPath:(NSIndexPath *)aIndexPath;

/**
 *  剩余时间计算
 *
 *  @param aExpireDatetimeStr <#aExpireDatetimeStr description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)formatSurplusTime:(NSString *)aExpireDatetimeStr;

/**
 *  格式化两个时间的区间 06/23-07/01
 *
 *  @param aStart_timeStr 2015-06-23
 *  @param aEnd_timeStr   2015-07-01
 *
 *  @return 06/23-07/01
 */
+ (NSString *)formatTwoTime:(NSString *)aStart_timeStr withEndTime:(NSString *)aEnd_timeStr;
///分解时间 2015-07-22 08:33 -> 2015 07 22 08 33 把年月日分解出来
+ (NSArray *)resolveTimeStr:(NSString *)aTimeStr;
///分解时间 2015-07-22 08:33:30 -> 2015 07 22 08 33 30把年月日分解出来
+ (NSArray *)resolveTimeSecStr:(NSString *)aTimeStr;
///格式化两个时间的区间 2015-07-22 08:33 - 2015-07-22 08:33 -> 2015-07-22 ～ 2015-07-22
+ (NSString *)formatTwoTimeEx:(NSString *)aStart_timeStr withEndTime:(NSString *)aEnd_timeStr;
///去除年份 2015-07-22 08:33  -> 07-22 08:33
+ (NSString *)formatRemoveYear:(NSString *)timeStr;
///格式化年月日 2015-07-22 08:33  -> 2015/07/22 08:33
+ (NSString *)formatSingleTime:(NSString *)timeStr;
/**
 *  格式化两个时间的区间 2015-07-22 08:33 - 2015-07-22 08:33
 *
 *  @param aStart_timeStr 2015-07-22 08:33
 *  @param aEnd_timeStr   2015-07-22 08:33
 *
 *  @return 2015-07-22 08:33 - 2015-07-22 08:33
 */
+ (NSString *)formatTwoTimes:(NSString *)aStart_timeStr withEndTime:(NSString *)aEnd_timeStr;
/**
 *  计算剩余大概时间
 *
 *  @param aStart_timeStr <#aStart_timeStr description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)formatOneTime:(NSString *)aStart_timeStr;

/**
 *  根据传入NSDate获取时间的年月日时分秒(星期几)等。。。。。
 *
 *  @param aCurrentDate <#aCurrentDate description#>
 *  @param dayDelay     <#dayDelay description#>
 */
+ (NSArray *)getDateType:(NSDate *)aCurrentDate withDelay:(int)dayDelay;

/**
 *  根据传入aWeekNum返回星期几
 *
 *  @param weekNum <#weekNum description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)getWeekType:(NSInteger)aWeekNum;

/**
 *  格式化文件大小
 *
 *  @param aFileSize <#aFileSize description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)formatFileSize:(NSString *)aFileSize;

///计算文字高度
+ (CGFloat)calcTextRectText:(NSString *)aText withWidth:(CGFloat)aWidth withAttributes:(NSDictionary *)aDict;

///计算文字宽度
+ (CGFloat)calcTextWidthText:(NSString *)aText withWidth:(CGFloat)aWidth withAttributes:(NSDictionary *)aDict;

/**
 *  格式化支付宝返回完成代码
 *
 *  @param aResultStatus <#aResultStatus description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)formatAlipayResultStatus:(NSString *)aResultStatus;
/**
 *  格式化微信支付返回代码
 *
 *  @param aResultStatus <#aResultStatus description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)formatweChatpayResultStatus:(int)aErrCode;

///日期字符转Date
+ (NSDate *)formatDateStrToDate:(NSString *)dateStr;
///日期转字符串
+ (NSString *)formatDateToString:(NSDate *)date;
///日期字符转Date 格式化到秒
+ (NSDate *)formatDateStrToDateEx:(NSString *)dateStr;
///日期字符转Date 格式化到年月日
+ (NSDate *)formatDateStrToDateYMD:(NSString *)dateStr;
///日期转字符串 格式化到秒
+ (NSString *)formatDateToStringEx:(NSDate *)date;

///把时间蹉转化成date类型
+ (NSDate *)formatTimeIntervalToDate:(NSString *)dateStr;
///把date转化成时间蹉
+ (NSTimeInterval)formatDateToTimeInterval:(NSString *)dateStr;
///把标准时间转化成当前时区的时间
+ (NSDate *)getNowDateFromatStandardDate:(NSDate *)standardDate;
/// 剩余时间 -- 天 小时 分钟后结束
+ (NSString *)formatRemainTime:(NSDate *)aDate;
///计算两个时间之间的间隔时间 天 小时 分钟 结束
+ (NSString *)formatRemainBeginTime:(NSDate *)beginDate withEndTime:(NSDate *)endDate;
/// 剩余时间 -- 天 小时 分钟后开始
+ (NSString *)formatRemainTimeBegin:(NSDate *)aDate;
///计算两个时间之间的间隔时间 天 小时 分钟 开始
+ (NSString *)formatRemainBeginTimeBegin:(NSDate *)beginDate withEndTime:(NSDate *)endDate;

///获取字符串中的url字符数组
+ (NSArray *)getUrlsStr:(NSString *)string;

///获取字符串中某个url的range
+ (NSArray *)getRangesOfString:(NSString *)searchString inString:(NSString *)str;

+ (NSString *)formatStrinToUrlString:(NSString *)string;

+ (BOOL)isLink:(NSString *)string;

+ (NSAttributedString *)formatOHAttributText:(NSString*)txt withFont:(UIFont *)font;

///把www开头转换成http开头
+ (NSString *)formatWwwToHttp:(NSString *)urlStr;

@end
