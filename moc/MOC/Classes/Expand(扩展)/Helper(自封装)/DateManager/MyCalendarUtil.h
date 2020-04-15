//
//  MyCalendarUtil.h
//  HomeHelpDemo
//
//  Created by 刘 贤珍 on 12-2-16.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

typedef enum {
	MyCalendarUtilDateTypeYear = 1,
    MyCalendarUtilDateTypeMonth = 2,
    MyCalendarUtilDateTypeDay = 3,
    MyCalendarUtilDateTypeHour = 4,
    MyCalendarUtilDateTypeMinute = 5,
    MyCalendarUtilDateTypeSecond = 6,
} MyCalendarUtilDateType;


#import <Foundation/Foundation.h>


@interface MyCalendarUtil : NSObject {

}

#pragma mark 根据指定的日期及单个日期占用的宽高返回此日期在当前月份中应该显示的位置
+(CGRect)getFrameByDate:(MXGregorianDate)nowDate width:(CGFloat)width height:(CGFloat)height ;
#pragma mark 根据指定的日期及单个日期占用的宽高返回此日期在指定月份中应该显示的位置
+(CGRect)getFrameByMonth:(MXGregorianDate)nowMonth nowDate:(MXGregorianDate)nowDate width:(CGFloat)width height:(CGFloat)height ;

#pragma mark 根据指定的周几,当月第几周及单个日期占用的宽高返回此位置表示的日期在当前月份中应该显示的位置
+ (CGRect)getFrameByWeek:(int)weekDay weekNum:(int)weekNum width:(CGFloat)width height:(CGFloat)height ;

#pragma mark 根据指定的位置,所在月份及单个日期占用的宽高返回此位置表示的日期
+(MXGregorianDate)getDateByPoint:(CGPoint)point nowMonth:(MXGregorianDate)nowDate width:(CGFloat)width height:(CGFloat)height ;

#pragma mark 根据指定的开始及结束位置,返回所有在这之间的日期集合
+(NSMutableArray *)getDatesByPoint:(CGPoint)startPoint andEndPoing:(CGPoint)endPoint nowMonth:(MXGregorianDate)nowDate width:(CGFloat)width height:(CGFloat)height ;


#pragma mark 返回指定日期所在月份中的第一天是周几,周一返回1,周未返回7
+(NSInteger)getMonthWeekday:(MXGregorianDate)date ;


#pragma mark 根据指定日期对象返回此日期表示的当月最大天数
+(int)getDayCountOfaMonth:(MXGregorianDate)date ;


#pragma mark 返回指定日期是周几,周未返回1,周六返回7
+(NSInteger)getDateWeekDay:(MXGregorianDate)date ;


#pragma mark 返回指定日期是当月第几周
+ (NSInteger)getWeekNumByDate:(MXGregorianDate)date ;

#pragma mark 对日期进行年,月,日的加减计算,返回计算后的日期,type为:1表示年份,2表示月份,3表示日,num表示需要计算的值,正表示加,负表示减
+ (MXGregorianDate)add:(MXGregorianDate)date type:(MyCalendarUtilDateType)type number:(int)num ;	

#pragma mark 对日期进行年,月,日,时,分,秒的加减计算,返回计算后的日期,type为:1表示年份,2表示月份,3表示日,num表示需要计算的值,正表示加,负表示减
+ (NSDate *)addNSDate:(NSDate *)date type:(MyCalendarUtilDateType)type number:(NSInteger)num ;


#pragma mark 当前月最大显示的天数:当前月的总天数+1号当周前几天+31号当周后几天
+ (int)getShowDayCountOfaMonth:(MXGregorianDate)date ;

#pragma mark 返回指定月份中显示dayCount表示的日期(包括上一个月和下一个月在当月显示的日期),dayCount=1表示当月显示的第一天,2表示第二天,以次类推
+ (MXGregorianDate)getCFGregorianDateByMonth:(MXGregorianDate)monthDate DayCount:(int)dayCount ;
+ (MXGregorianDate)getFirstCFGregorianDateByMonth:(MXGregorianDate)monthDate ;
+ (MXGregorianDate)getLastCFGregorianDateByMonth:(MXGregorianDate)monthDate ;

#pragma mark 将自定义的日期计算类型转换成ns定义的日期类型
+(NSCalendarUnit)myCalendarDateTypeToNSCalendarUnit:(MyCalendarUtilDateType)type ;
#pragma mark 计算两个日期相差的时间数,支持,年月日,时分秒
+ (NSUInteger)compareDayDifferNS:(NSDate *)startDate EndDate:(NSDate *)endDate type:(MyCalendarUtilDateType)type ;
+ (NSUInteger)compareDayDifferCF:(MXGregorianDate)startDate EndDate:(MXGregorianDate)endDate type:(MyCalendarUtilDateType)type ;


+ (NSComparisonResult) compareFormDate:(NSDate*) date1 toDate: (NSDate*) date2 ;
+ (NSComparisonResult) compareStartDate:(MXGregorianDate)startDate EndDate:(MXGregorianDate)endDate ;


#pragma mark 判断两个日期的大小,只基于年月,相等返回0,thisDate比toDate小时返回-1,thisDate比toDate大时返回1
+ (int)compareByYM:(MXGregorianDate)thisDate toDate:(MXGregorianDate)toDate ;
#pragma mark 判断两个日期的大小,只基于年月日,相等返回0,thisDate比toDate小时返回-1,thisDate比toDate大时返回1
+ (int)compareByYMD:(MXGregorianDate)thisDate toDate:(MXGregorianDate)toDate ;

#pragma mark 判断两个日期是否是同一天，年，月，日
+ (BOOL)isEquals:(MXGregorianDate)firstDate andDate:(MXGregorianDate)secondDate ;

#pragma mark 时间秒数转化为NSString
+ (NSString *)timeIntervalToString:(NSString *)stringMSec setDateFormat:(NSString *)yyyyMMddHHmm;
#pragma mark 字符串时间转化为nsdate
+(NSDate*) convertDateFromString:(NSString*)date setDateFormat:(NSString *)yyyyMMddHHmm;
#pragma mark 时间转化为星期几
+(NSString*)getWeekdayFromDate:(NSDate*)date;
#pragma 转化为星期几
+(NSString*)getWeekDayString:(NSInteger ) weekday;

// 判断闰年
+ (BOOL)isLeapYear:(NSInteger)year;

//  计算星座
+ (NSString *)getConstellation:(NSDate *)in_date;

#pragma mark 将NSDate类型转换成MXGregorianDate
+ (MXGregorianDate)convertNSDateToGregorianDate:(NSDate *)date;

#pragma mark 计算两个时间大小差，并以XX年XX月XX日XX时XX分XX秒形式字符串返回
+(NSString *)compareByYMDFromDate:(NSDate *)thisDate toDate:(NSDate *)toDate;

+ (NSString*)utcStringFormateWithDateString:(NSString*)dateStr formatter:(NSString*)formatter;

+ (NSString*)dateToString:(NSDate*)date formatter:(NSString*)formatter;

#pragma mark-将世界标准时间转换为当前系统时区对应的时间
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;

@end
