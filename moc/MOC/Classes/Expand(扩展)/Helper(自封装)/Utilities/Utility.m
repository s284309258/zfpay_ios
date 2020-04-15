//
//  Utility.m
//
//
//  Created by vera on 15/5/29.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "Utility.h"
//#import "Reachability.h"
#import <UIKit/UIKit.h>

@implementation Utility

/**
 判断是否有网络
 */
+ (BOOL)isNetworkReachaility
{
    //    Reachability *reachaility = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    //获取当前的网络状态
    //    NetworkStatus status = [reachaility currentReachabilityStatus];
    
    /*
     kNotReachable       没有网络
     kReachableViaWWAN   2G/3G
     kReachableViaWiFi   WIFI
     */
    
    //没有网络
    //    if (status == kNotReachable)
    //    {
    //        return NO;
    //    }
    //
    
    
    return YES;
}

- (void)test
{
    //注册网络发生变化的通知
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkHaveStatusChange:) name:kReachabilityChangedNotification object:nil];
    //
    //    Reachability *reachaility = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    //    //启动监测
    //    [reachaility startNotifier];
}

//当网络发生变化的时候会触发这个方法
- (void)networkHaveStatusChange:(NSNotification *)notification
{

}
+ (NSString *)formatShareAndDownloadAndFavoriteWithShare:(NSString *)aShare
                                                DownLoad:(NSString *)aDownLoad
                                                Favorite:(NSString *)aFavorite
{
    return [NSString stringWithFormat:@"分享: %zd次 收藏: %zd次 下载: %zd次",[aShare intValue],[aFavorite intValue], [aDownLoad intValue]];
}

+ (NSString *)formatPrice:(NSString *)price
{
    return [NSString stringWithFormat:@"￥%.2f",[price floatValue]];
}

+ (NSString *)formatName:(NSString *)aName withIndexPath:(NSIndexPath *)aIndexPath
{
    return [NSString stringWithFormat:@"%zd.%@",aIndexPath.row+1,aName];
}

+ (NSString *)formatSurplusTime:(NSString *)aExpireDatetimeStr
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
    NSDate * expireDate = [dateFormat dateFromString:aExpireDatetimeStr];
    NSDate * currentDate = [NSDate date];
    NSTimeInterval intimer = [expireDate timeIntervalSinceDate:currentDate];
    NSInteger hours = intimer/3600;
    NSInteger minute = (intimer - hours*3600)/60;
    NSInteger second = (intimer - hours*3600 - minute*60);
    return [NSString stringWithFormat:@"剩余:%02zd:%02zd:%02zd",hours,minute,second];
}

+ (NSArray *)resolveTimeStr:(NSString *)aTimeStr
{
    if ([StringUtil isEmpty:aTimeStr]) {
        return nil;
    }
    //年月日
    NSString * YMDStr = [[aTimeStr componentsSeparatedByString:@" "] firstObject];
    NSArray * YMDArr = [YMDStr componentsSeparatedByString:@"-"];
    //时分
    NSString * TimeStr = [[aTimeStr componentsSeparatedByString:@" "] lastObject];
    NSArray * TimeArr = [TimeStr componentsSeparatedByString:@":"];
    
    NSMutableArray * YMDHMMarr = [NSMutableArray arrayWithArray:YMDArr];
    [YMDHMMarr addObjectsFromArray:TimeArr];
    return YMDHMMarr;
}

+ (NSArray *)resolveTimeSecStr:(NSString *)aTimeStr {
    if ([StringUtil isEmpty:aTimeStr]) {
        return nil;
    }
    //年月日
    NSString * YMDStr = [[aTimeStr componentsSeparatedByString:@" "] firstObject];
    NSArray * YMDArr = [YMDStr componentsSeparatedByString:@"-"];
    //时分秒
    NSString * TimeStr = [[aTimeStr componentsSeparatedByString:@" "] lastObject];
    NSArray * TimeArr = [TimeStr componentsSeparatedByString:@":"];
    
    NSMutableArray * YMDHMMarr = [NSMutableArray arrayWithArray:YMDArr];
    [YMDHMMarr addObjectsFromArray:TimeArr];
    return YMDHMMarr;
}

+ (NSString *)formatTwoTime:(NSString *)aStart_timeStr withEndTime:(NSString *)aEnd_timeStr
{
    NSString *startTime = [aStart_timeStr componentsSeparatedByString:@" "][0];
    NSArray *startTimeArr = [startTime componentsSeparatedByString:@"-"];
    
    NSString *endTime = [aEnd_timeStr componentsSeparatedByString:@" "][0];
    NSArray *endTimeArr = [endTime componentsSeparatedByString:@"-"];
    
    return [NSString stringWithFormat:@"%@/%@ - %@/%@",startTimeArr[1],startTimeArr[2],endTimeArr[1],endTimeArr[2]];
}

+ (NSString *)formatTwoTimeEx:(NSString *)aStart_timeStr withEndTime:(NSString *)aEnd_timeStr
{
    NSString *startTime = [aStart_timeStr componentsSeparatedByString:@" "][0];
    NSString *endTime = [aEnd_timeStr componentsSeparatedByString:@" "][0];
    
    return [NSString stringWithFormat:@"%@ ～ %@",startTime,endTime];
}
///去除年份 2015-07-22 08:33  -> 07-22 08:33
+ (NSString *)formatRemoveYear:(NSString *)timeStr {
    NSArray * timeArr = [self resolveTimeStr:timeStr];
    if (timeArr.count == 5) {
        return [NSString stringWithFormat:@"%@-%@ %@:%@",timeArr[1],timeArr[2],timeArr[3],timeArr[4]];
    } else {
        return timeStr;
    }
    
}
///格式化年月日 2015-07-22 08:33  -> 2015/07/22 08:33
+ (NSString *)formatSingleTime:(NSString *)timeStr {
    NSArray * timeArr = [self resolveTimeStr:timeStr];
    if (timeArr.count == 5) {
        return [NSString stringWithFormat:@"%@/%@/%@ %@:%@",timeArr[0],timeArr[1],timeArr[2],timeArr[3],timeArr[4]];
    } else {
        return timeStr;
    }
    
}
+ (NSString *)formatTwoTimes:(NSString *)aStart_timeStr withEndTime:(NSString *)aEnd_timeStr
{
    return [NSString stringWithFormat:@"%@ ～ %@",aStart_timeStr,aEnd_timeStr];
}

+ (NSString *)formatOneTime:(NSString *)aStart_timeStr
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *startTime = [dateFormat dateFromString:aStart_timeStr];
    return [self formatRemainTime:startTime];
}

/// 剩余时间 -- 天 小时 分钟后结束
+ (NSString *)formatRemainTime:(NSDate *)aDate
{
    NSDate * currentDate = [NSDate date];
    currentDate = [self getNowDateFromatStandardDate:currentDate];
    NSTimeInterval intimer = [aDate timeIntervalSinceDate:currentDate];
    NSInteger day = intimer/(24*3600);
    NSInteger hours = (intimer - day*24*3600)/3600;
    NSInteger minute = (intimer - hours*3600 - day*24*3600)/60;
    return [NSString stringWithFormat:@"%ld天%ld小时%ld分钟后结束",(long)day,(long)hours,(long)minute];
}

+ (NSString *)formatRemainBeginTime:(NSDate *)beginDate withEndTime:(NSDate *)endDate {
    NSTimeInterval intimer = [endDate timeIntervalSinceDate:beginDate];
    NSInteger day = intimer/(24*3600);
    NSInteger hours = (intimer - day*24*3600)/3600;
    NSInteger minute = (intimer - hours*3600 - day*24*3600)/60;
    return [NSString stringWithFormat:@"%ld天%ld小时%ld分钟后结束",(long)day,(long)hours,(long)minute];
}

+ (NSString *)formatRemainTimeBegin:(NSDate *)aDate
{
    NSDate * currentDate = [NSDate date];
    currentDate = [self getNowDateFromatStandardDate:currentDate];
    NSTimeInterval intimer = [aDate timeIntervalSinceDate:currentDate];
    NSInteger day = intimer/(24*3600);
    NSInteger hours = (intimer - day*24*3600)/3600;
    NSInteger minute = (intimer - hours*3600 - day*24*3600)/60;
    return [NSString stringWithFormat:@"%ld天%ld小时%ld分钟后开始",(long)day,(long)hours,(long)minute];
}

+ (NSString *)formatRemainBeginTimeBegin:(NSDate *)beginDate withEndTime:(NSDate *)endDate {
    NSTimeInterval intimer = [endDate timeIntervalSinceDate:beginDate];
    NSInteger day = intimer/(24*3600);
    NSInteger hours = (intimer - day*24*3600)/3600;
    NSInteger minute = (intimer - hours*3600 - day*24*3600)/60;
    return [NSString stringWithFormat:@"%ld天%ld小时%ld分钟后开始",(long)day,(long)hours,(long)minute];
}

+ (NSString *)getWeekType:(NSInteger)aWeekNum
{
    NSString * weekStyle;
    switch (aWeekNum) {
        case 0:
            weekStyle = MXLang(@"WeekType_7", @"星期日");
            break;
        case 1:
            weekStyle = MXLang(@"WeekType_1", @"星期一");
            break;
        case 2:
            weekStyle = MXLang(@"WeekType_2", @"星期二");
            break;
        case 3:
            weekStyle = MXLang(@"WeekType_3", @"星期三");
            break;
        case 4:
            weekStyle = MXLang(@"WeekType_4", @"星期四");
            break;
        case 5:
            weekStyle = MXLang(@"WeekType_5", @"星期五");
            break;
        case 6:
            weekStyle = MXLang(@"WeekType_6", @"星期六");
            break;
        default:
            break;
    }
    return weekStyle;
}

+ (NSArray *)getDateType:(NSDate *)aCurrentDate withDelay:(int)dayDelay{
    //    //dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    //    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];
    
    //设置成中国阳历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = nil;
    
    // 年月日时分秒周 格式化单位
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:aCurrentDate];
    
    //获取星期对应的长整形字符串
    long weekNumber = [comps weekday];
    
    //获取日期对应的长整形字符串
    long day=[comps day];
    
    //获取年对应的长整形字符串
    long year=[comps year];
    
    //获取月对应的长整形字符串
    long month=[comps month];
    
    //获取小时对应的长整形字符串
    long hour=[comps hour];
    
    //获取月对应的长整形字符串
    long minute=[comps minute];
    
    //获取秒对应的长整形字符串
    long second=[comps second];
    
    return @[@(year),@(month),@(day),@(hour),@(minute),@(second),@(weekNumber)];
}

+ (NSString *)formatCategoryWith:(NSString *)aCategory
{
    NSString * result = @"";
    if ([aCategory isEqualToString:@"Game"]) {
        result = @"游戏";
    }
    else if ([aCategory isEqualToString:@"Pastime"])
        result = @"娱乐";
    else if ([aCategory isEqualToString:@"Education"])
        result = @"教育";
    else if ([aCategory isEqualToString:@"Tool"])
        result = @"工具";
    else if ([aCategory isEqualToString:@"Photography"])
        result = @"图片管理";
    else if ([aCategory isEqualToString:@"Ability"])
        result = @"应用";
    else if ([aCategory isEqualToString:@"Weather"])
        result = @"气温";
    else if ([aCategory isEqualToString:@"Music"])
        result = @"音乐";
    else if ([aCategory isEqualToString:@"News"])
        result = @"新闻";
    else if ([aCategory isEqualToString:@"Refer"])
        result = @"漫画";
    else if ([aCategory isEqualToString:@"Social"])
        result = @"社交";
    return result;
}

+ (NSString *)formatMark:(NSString *)aStarCurrent
{
    return [NSString stringWithFormat:@"评分:%0.1f",[aStarCurrent floatValue]];
}
/**
 *  格式化现价
 *
 *  @param aCurrentPrice <#aCurrentPrice description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)formatCurrentPrice:(NSString *)aCurrentPrice
{
    return [NSString stringWithFormat:@"现价%0.2f",[aCurrentPrice floatValue]];
}

+ (NSString *)formatFileSize:(NSString *)aFileSize
{
    return [NSString stringWithFormat:@"%@MB",aFileSize];
}

+ (NSString *)formatAppType:(NSString *)aPriceTrend
{
    NSString * appStr;
    if ([aPriceTrend isEqualToString:@"limited"]) {
        appStr = @"限免中";
    }
    else if ([aPriceTrend isEqualToString:@"free"])
    {
        appStr = @"免费中";
    }
    else if ([aPriceTrend isEqualToString:@"sales"])
    {
        appStr = @"降价中";
    }
    else
        appStr = @"其它";
    return appStr;
}

+ (NSString *)formatAppTypeEx:(NSString *)aPriceTrend
{
    NSString * appStr;
    if ([aPriceTrend isEqualToString:@"limited"]) {
        appStr = @"限免";
    }
    else if ([aPriceTrend isEqualToString:@"free"])
    {
        appStr = @"免费";
    }
    else if ([aPriceTrend isEqualToString:@"sales"])
    {
        appStr = @"降价";
    }
    else
        appStr = @"其它";
    return appStr;
}

+ (CGFloat)calcTextRectText:(NSString *)aText withWidth:(CGFloat)aWidth withAttributes:(NSDictionary *)aDict;
{
    CGSize size = [aText boundingRectWithSize:CGSizeMake(aWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:aDict context:nil].size;
    return ceil(size.height);
}

+ (CGFloat)calcTextWidthText:(NSString *)aText withWidth:(CGFloat)aWidth withAttributes:(NSDictionary *)aDict {
    CGSize size = [aText boundingRectWithSize:CGSizeMake(aWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:aDict context:nil].size;
    return ceil(size.width);
}

/**
 *  格式化支付宝返回结果状态
 *
 *  @param aResultStatus <#aResultStatus description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)formatAlipayResultStatus:(NSString *)aResultStatus
{
    NSString * resultStatus;
    if ([aResultStatus isEqualToString:@"9000"]) {
        resultStatus = @"订单支付成功";
    }
    else if ([aResultStatus isEqualToString:@"8000"])
    {
        resultStatus = @"正在处理中";
    }
    else if ([aResultStatus isEqualToString:@"4000"])
    {
        resultStatus = @"订单支付失败";
    }
    else if ([aResultStatus isEqualToString:@"6001"])
    {
        resultStatus = @"用户中途取消";
    }
    else if ([aResultStatus isEqualToString:@"6002"])
    {
        resultStatus = @"网络连接出错";
    }
    else
        resultStatus = @"其它";
    return resultStatus;
}

/*
 WXSuccess           = 0,   // 支付成功
 WXErrCodeCommon     = -1,  // 普通错误编码
 WXErrCodeUserCancel = -2,  // 用户取消
 WXErrCodeSentFail   = -3,  // 发送错误
 WXErrCodeAuthDeny   = -4,  // 没有权限
 WXErrCodeUnsupport  = -5,  // 不支持支付
 */
+ (NSString *)formatweChatpayResultStatus:(int)aErrCode
{
    NSString * resultStatus;
    if (aErrCode == 0) {
        resultStatus = @"订单支付成功";
    }
    else if (aErrCode == -1)
    {
        resultStatus = @"普通错误编码";
    }
    else if (aErrCode == -2)
    {
        resultStatus = @"用户取消";
    }
    else if (aErrCode == -3)
    {
        resultStatus = @"发送错误";
    }
    else if (aErrCode == -4)
    {
        resultStatus = @"没有权限";
    }
    else if(aErrCode == -5)
        resultStatus = @"不支持支付";
    else
        resultStatus = @"其它";
    return resultStatus;
}

+ (NSString *)formatDateToString:(NSDate *)date
{
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString * dateStr = [dateFormat stringFromDate:date];
    return dateStr;
}

+ (NSString *)formatDateToStringEx:(NSDate *)date
{
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString * dateStr = [dateFormat stringFromDate:date];
    return dateStr;
}

+ (NSDate *)formatDateStrToDate:(NSString *)dateStr
{
    NSDateFormatter* dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *date = [dateFormat dateFromString:dateStr];
    return date;
}

+ (NSDate *)formatDateStrToDateEx:(NSString *)dateStr
{
    NSDateFormatter* dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *date = [dateFormat dateFromString:dateStr];
    return date;
}
+ (NSDate *)formatDateStrToDateYMD:(NSString *)dateStr
{
    NSDateFormatter* dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *date = [dateFormat dateFromString:dateStr];
    return date;
}
+ (NSDate *)formatTimeIntervalToDate:(NSString *)dateStr
{
    return [NSDate dateWithTimeIntervalSince1970:[dateStr doubleValue]];
}

+ (NSTimeInterval)formatDateToTimeInterval:(NSString *)dateStr
{
    //日期字符串转本地NSDate
    //NSDate转TimeInterval
    NSDate * date = [self formatDateStrToDate:dateStr];
    NSTimeInterval dateTimeInterval = [date timeIntervalSince1970];
    return dateTimeInterval;
}

+ (NSDate *)getNowDateFromatStandardDate:(NSDate *)standardDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:standardDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:standardDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:standardDate];
    return destinationDateNow;
}

+ (BOOL)isLink:(NSString *)string {
    if ([StringUtil isEmpty:string]) {
        return NO;
    }
    
    NSError *error;
    //可以识别url的正则表达式
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    //获取可匹配的元素
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    return (arrayOfAllMatches.count == 0 ? NO:YES);
}

+ (NSArray *)getUrlsStr:(NSString *)string {
    if ([StringUtil isEmpty:string]) {
        return nil;
    }
    
    NSError *error;
    //可以识别url的正则表达式
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,3})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,3})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    //获取可匹配的元素
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    //匹配的URL字符串数组
    NSMutableArray *matchUrlStrArr=[NSMutableArray array];
    
    //获取匹配字符串
    for (NSTextCheckingResult *match in arrayOfAllMatches) {
        NSString* substringForMatch;
        substringForMatch = [string substringWithRange:match.range];
        [matchUrlStrArr addObject:substringForMatch];
    }
    //去重
    matchUrlStrArr = [matchUrlStrArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
    return matchUrlStrArr;
}

//获取查找字符串在母串中的NSRange
+ (NSArray *)getRangesOfString:(NSString *)searchString inString:(NSString *)str {
    NSMutableArray *results = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, [str length]);
    NSRange range;
    
    while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        [results addObject:[NSValue valueWithRange:range]];
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
    }
    
    return results;
}

+ (NSString *)formatStrinToUrlString:(NSString *)string {
    if ([StringUtil isEmpty:string]) {
        return nil;
    }
    
    NSArray *matchUrlStrArr = [self getUrlsStr:string];
    if (matchUrlStrArr.count == 0) {
        return string;
    }
    
    NSString *replaceStr;
    for (NSString *url in matchUrlStrArr) {
        replaceStr = [NSString stringWithFormat:@" %@ ", url];
        string = [string stringByReplacingOccurrencesOfString:url withString:replaceStr];
    }
    
    return string;
}

+ (NSAttributedString *)formatOHAttributText:(NSString*)txt withFont:(UIFont *)font {
    if ([StringUtil isEmpty:txt]) {
        return nil;
    }
    
    @autoreleasepool {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.lineSpacing = 3;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont font14], NSParagraphStyleAttributeName:paragraphStyle.copy,NSForegroundColorAttributeName:[UIColor moBlack]};
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:txt attributes:attributes];
        return attr;
    }
}

+ (NSString *)formatWwwToHttp:(NSString *)urlStr {
    if ([StringUtil isEmpty:urlStr]) {
        return nil;
    }
    
    NSString *lowercaseString = [urlStr lowercaseString];
    
    if (![lowercaseString hasPrefix:@"http"]) {
        urlStr = [NSString stringWithFormat:@"%@%@", @"http://", urlStr];
    }
    
    return urlStr;
}

@end
