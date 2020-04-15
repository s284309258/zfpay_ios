//
//  MyCalendarUtil.m
//  HomeHelpDemo
//
//  Created by 刘 贤珍 on 12-2-16.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MyCalendarUtil.h"
#import "StringUtil.h"

static NSInteger NSDateCompare(NSDate* date1, NSDate* date2, void* context)
{
    // 你要实现的函数, 返回值为NSOrderedAscending, NSOrderedSame, NSOrderedDescending中的一个
	return [date1 compare:date2];
}


@implementation MyCalendarUtil



#pragma mark 根据指定的日期及单个日期占用的宽高返回此日期在当前月份中应该显示的位置
+(CGRect)getFrameByDate:(MXGregorianDate)nowDate width:(CGFloat)width height:(CGFloat)height {
	int weekDay = [MyCalendarUtil getDateWeekDay:nowDate];
	int week = [MyCalendarUtil getWeekNumByDate:nowDate];
	CGFloat x = width*(weekDay-1);
	CGFloat y = height*(week-1);
	return CGRectMake(x, y, width, height);
}

#pragma mark 根据指定的日期及单个日期占用的宽高返回此日期在指定月份中应该显示的位置
+(CGRect)getFrameByMonth:(MXGregorianDate)nowMonth nowDate:(MXGregorianDate)nowDate width:(CGFloat)width height:(CGFloat)height {
	if(nowMonth.year!=nowDate.year || nowMonth.month != nowDate.month ){ // 绘制的日期不是当前月
		CGRect frame = [MyCalendarUtil getFrameByDate:nowDate width:width height:height];
		MXGregorianDate tempDate ;
		CGRect tempFrame;
		if(nowDate.day>20){// 属于上一个月
			//tempDate = [MyCalendarUtil getCFGregorianDateByMonth:nowMonth DayCount:1];
			//tempFrame = [MyCalendarUtil getFrameByDate:tempDate width:width height:height];		
			frame.origin.y = 0;
		}else {  // 属于下一个月
			int dayCount = [MyCalendarUtil getDayCountOfaMonth:nowMonth];
			tempDate.year = nowMonth.year;
			tempDate.month = nowMonth.month;
			tempDate.day = dayCount;
			tempFrame = [MyCalendarUtil getFrameByDate:tempDate width:width height:height];
			int weekDay = [MyCalendarUtil getDateWeekDay:tempDate]; // 指定日期是周几,1~7
			int t = 7-weekDay;
			if(nowDate.day<=t){ // 上个月最后一天的星期数+这月的日期小于7,说明这天是和上月的最后一天是在同周
				frame.origin.y = tempFrame.origin.y;
			}else {
				int i = nowDate.day-t;
				t = i%7;
				i = (t==0)?(i/7):(i/7+1);
				frame.origin.y = tempFrame.origin.y+height*i;
			}
		}			
		return frame;
	}else{ // 绘制的日期是当前月
		return [MyCalendarUtil getFrameByDate:nowDate width:width height:height];
	}
}

#pragma mark 根据指定的周几,当月第几周及单个日期占用的宽高返回此位置表示的日期在当前月份中应该显示的位置
+ (CGRect)getFrameByWeek:(int)weekDay weekNum:(int)weekNum width:(CGFloat)width height:(CGFloat)height {
	CGFloat x = width*(weekDay-1);
	CGFloat y = height*(weekNum-1);
	return CGRectMake(x, y, width, height);
}

#pragma mark 根据指定的位置,所在月份及单个日期占用的宽高返回此位置表示的日期
+(MXGregorianDate)getDateByPoint:(CGPoint)point nowMonth:(MXGregorianDate)nowDate width:(CGFloat)width height:(CGFloat)height {
	MXGregorianDate date ;
	date.year = nowDate.year;
	date.month = nowDate.month;
	date.day = nowDate.day;
	int weekday=[MyCalendarUtil getMonthWeekday:nowDate]; // 指定月份第一天星期
	int monthDayCount=[MyCalendarUtil getDayCountOfaMonth:nowDate]; // 指定月份最大天数
	int x=point.x/width;  //X坐标除以单个日期显示的宽取整,得到的是显示日期为当月的星期几,1~7
	int y=point.y/height; // Y坐标除以单个日期的高取整,得到的是显示日期为当月的第几周
	int monthday=x+y*7-weekday+2; // 
	if(monthday>0 && monthday<monthDayCount+1)
	{
		date.day=monthday;
	}else if(monthday<=0){ // 上一个月的
		date = [MyCalendarUtil add:date type:MyCalendarUtilDateTypeMonth number:-1];
		monthDayCount=[MyCalendarUtil getDayCountOfaMonth:date];
		date.day = monthDayCount+monthday;
	}else if(monthday>monthDayCount){ // 下一个月的
		date = [MyCalendarUtil add:date type:MyCalendarUtilDateTypeMonth number:1];
		date.day = monthday-monthDayCount;
	}
	
	
	return date;
}


#pragma mark 根据指定的开始及结束位置,返回所有在这之间的日期集合
+(NSMutableArray *)getDatesByPoint:(CGPoint)startPoint andEndPoing:(CGPoint)endPoint nowMonth:(MXGregorianDate)nowDate width:(CGFloat)width height:(CGFloat)height {
	MXGregorianDate d1 = [MyCalendarUtil getDateByPoint:startPoint nowMonth:nowDate width:width height:height];
	NSDate *startDate = [StringUtil nsDateForCFGregorianDate:d1];
	MXGregorianDate d2 = [MyCalendarUtil getDateByPoint:endPoint nowMonth:nowDate width:width height:height];
	NSDate *endDate = [StringUtil nsDateForCFGregorianDate:d2];
	NSMutableArray *dateArray = [[NSMutableArray alloc] init];
	NSComparisonResult re = [startDate compare:endDate];
	if(re==NSOrderedSame){
		[dateArray addObject:startDate];
	}else {
		int t = re==NSOrderedDescending?1:-1;
		NSDate *tempDate = startDate ;
						  
		for(;[tempDate compare:endDate]!=NSOrderedSame;){
			[dateArray addObject:tempDate];
			tempDate = [MyCalendarUtil addNSDate:tempDate type:MyCalendarUtilDateTypeDay number:t];			
		}
		[dateArray addObject:endDate];
	}
	[dateArray sortUsingFunction:NSDateCompare context:nil];

	return dateArray;
}

#pragma mark 当前月最大显示的天数:当前月的总天数+1号当周前几天+31号当周后几天
+ (int)getShowDayCountOfaMonth:(MXGregorianDate)date {
	int t = [MyCalendarUtil getDayCountOfaMonth:date]; // 当月最大天数
	int w1 = [MyCalendarUtil getMonthWeekday:date]; // 1号是周几
	date.day = t;
	int w31 = [MyCalendarUtil getDateWeekDay:date]; // 当月最后一天是周几
	int t1 = w1-1; // 7-(7-w1)-1;
	int t31 = 7-w31;

	return t+t1+t31;
}

#pragma mark 根据指定日期对象返回此日期表示的当月最大天数
+(int)getDayCountOfaMonth:(MXGregorianDate)date{
	switch (date.month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
			
		case 2:
			if((date.year % 4==0 && date.year % 100!=0) || date.year % 400==0)
				return 29;
			else
				return 28;
		case 4:
		case 6:
		case 9:		
		case 11:
			return 30;
		default:
			return 31;
	}
}


#pragma mark 返回指定日期所在月份中的第一天是周几,周一返回1,周未返回7
+(NSInteger)getMonthWeekday:(MXGregorianDate)date
{
	date.day = 1;
	return [MyCalendarUtil getDateWeekDay:date];
}

#pragma mark 返回指定日期是周几,周一返回1,周未返回7
+(NSInteger)getDateWeekDay:(MXGregorianDate)date {
    
    NSString *dateStr = [NSString stringWithFormat:@"%d-%d-%d",date.year,date.month,date.day];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDate *theDate = [dateFormat dateFromString:dateStr];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitYear  | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:theDate];
    return [dateComponents weekday];
}

#pragma mark 返回指定日期是当月第几周,从第1周返回1,
+ (NSInteger)getWeekNumByDate:(MXGregorianDate)date {
	NSInteger weekM1 = [MyCalendarUtil getMonthWeekday:date]; // 当月第一天是周几
	NSInteger t = (date.day+weekM1-1);
	NSInteger week = t/7;
	if(t%7==0){
		return week;
	}else{
		return week+1;
	}
}


#pragma mark 对日期进行年,月,日,时,分,秒的加减计算,返回计算后的日期,type为:1表示年份,2表示月份,3表示日,num表示需要计算的值,正表示加,负表示减
+ (NSDate *)addNSDate:(NSDate *)date type:(MyCalendarUtilDateType)type number:(NSInteger)num {

	
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	switch (type) {
		case MyCalendarUtilDateTypeYear:{ // 年
			[comps setYear:num];
			break;
		}case MyCalendarUtilDateTypeMonth:{  // 月
			[comps setMonth:num];
			break;
		}case MyCalendarUtilDateTypeDay:{  // 日
			[comps setDay:num];
			break;
		}case MyCalendarUtilDateTypeHour:{  // 时
			[comps setHour:num];
			break;
		}case MyCalendarUtilDateTypeMinute:{  // 分
			[comps setMinute:num];
			break;
		}case MyCalendarUtilDateTypeSecond:{  // 秒
			[comps setSecond:num];
			break;
		}default:{  // 日
			[comps setDay:num];			
			break;
		}
	}
	NSCalendar *gregorian = [NSCalendar currentCalendar];
	NSDate *newDate = [gregorian dateByAddingComponents:comps toDate:date  options:0];
	
	return newDate;
}

#pragma mark 对日期进行年,月,日,时,分,秒的加减计算,返回计算后的日期,type为:1表示年份,2表示月份,3表示日,num表示需要计算的值,正表示加,负表示减
+ (MXGregorianDate)add:(MXGregorianDate)date type:(MyCalendarUtilDateType)type number:(int)num {
	
	NSDate *currentDate = [StringUtil nsDateForCFGregorianDate:date];
	NSDate *newDate =  [MyCalendarUtil addNSDate:currentDate type:type number:num];
	MXGregorianDate date2 =[StringUtil cfGregorianDateForNSDate:newDate];
	return date2;
}


#pragma mark 返回指定月份中显示dayCount表示的日期(包括上一个月和下一个月在当月显示的日期),dayCount=1表示当月显示的第一天,2表示第二天,以次类推
+ (MXGregorianDate)getCFGregorianDateByMonth:(MXGregorianDate)monthDate DayCount:(int)dayCount {
	MXGregorianDate tempDate ;
	tempDate.year = monthDate.year;
	tempDate.month = monthDate.month;
	tempDate.day = monthDate.day;
	//monthDate.day = 1;
	int weekDay = [MyCalendarUtil getMonthWeekday:tempDate]; // 当月第一天是周几?
	int maxMonthDay = [MyCalendarUtil getDayCountOfaMonth:tempDate]; // 当月最大天数
	tempDate.day = maxMonthDay;
	int weekNum = [MyCalendarUtil getWeekNumByDate:tempDate]; // 当月最后一天是第几周
	int weekDayDate = [MyCalendarUtil getDateWeekDay:tempDate]; // 当月最后一天是周几
	int t = (weekNum-1)*7+weekDayDate; // 当月最后一天在当月日历中显示的位数
	if(dayCount<weekDay){ // 显示天数小于当月1号表示是上个月的日期
		tempDate.day = 1;
		tempDate = [MyCalendarUtil add:tempDate type:MyCalendarUtilDateTypeDay number:-(weekDay-dayCount)];
		
	}else if(dayCount>t){ // 显示天数大于当月最大天数+上月在本月中显示的几天
		tempDate.day = maxMonthDay;
		tempDate = [MyCalendarUtil add:tempDate type:MyCalendarUtilDateTypeDay number:dayCount-t];
	}else {
		tempDate.day =  (dayCount-weekDay)+1;
	}
	return tempDate;

	
}


+ (MXGregorianDate)getFirstCFGregorianDateByMonth:(MXGregorianDate)monthDate {
    return [MyCalendarUtil getCFGregorianDateByMonth:monthDate DayCount:1];
}
+ (MXGregorianDate)getLastCFGregorianDateByMonth:(MXGregorianDate)monthDate {
    int maxCount = [MyCalendarUtil getShowDayCountOfaMonth:monthDate ];
    return [MyCalendarUtil getCFGregorianDateByMonth:monthDate DayCount:maxCount];
}


#pragma mark 计算两个日期相差的时间数,支持,年月日,时分秒
+ (NSUInteger)compareDayDifferNS:(NSDate *)startDate EndDate:(NSDate *)endDate type:(MyCalendarUtilDateType)type {
    
	NSUInteger unitFlags = [MyCalendarUtil myCalendarDateTypeToNSCalendarUnit:type];
//	NSCalendar *chineseClendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendar *chineseClendar = [NSCalendar currentCalendar];
//    [chineseClendar setFirstWeekday:2];
	NSDateComponents *differTime = [chineseClendar components:unitFlags fromDate:startDate toDate:endDate options:0];
    
    
    
    
	switch (type) {
        case MyCalendarUtilDateTypeSecond:
            return [differTime second];
            break;
        case MyCalendarUtilDateTypeMinute:
            return [differTime minute];
            break;
        case MyCalendarUtilDateTypeHour:
            return [differTime hour];
            break;
        case MyCalendarUtilDateTypeMonth:
            return [differTime month];
            break;
        case MyCalendarUtilDateTypeYear:
            return [differTime year];
            break;
        default:
            [differTime day];
            break;
    }
	return [differTime day];
    
    
    
}
#pragma mark 计算两个日期相差的时间数,支持,年月日,时分秒
+ (NSUInteger)compareDayDifferCF:(MXGregorianDate)startDate EndDate:(MXGregorianDate)endDate type:(MyCalendarUtilDateType)type {
	NSDate *sDate = [StringUtil nsDateForCFGregorianDate:startDate];
	NSDate *eDate = [StringUtil nsDateForCFGregorianDate:endDate];
	return [MyCalendarUtil compareDayDifferNS:sDate EndDate:eDate type:type];
}
#pragma mark 将自定义的日期计算类型转换成ns定义的日期类型
+(NSCalendarUnit)myCalendarDateTypeToNSCalendarUnit:(MyCalendarUtilDateType)type {
	NSCalendarUnit t ;
	switch (type) {
		case MyCalendarUtilDateTypeDay:
			t = NSCalendarUnitDay;
			break;
		case MyCalendarUtilDateTypeMonth:
			t = NSCalendarUnitMonth;
			break;
		case MyCalendarUtilDateTypeYear:
			t = NSCalendarUnitYear;
			break;
		case MyCalendarUtilDateTypeHour:
			t = NSCalendarUnitHour;
			break;
		case MyCalendarUtilDateTypeMinute:
			t = NSCalendarUnitMinute;
			break;
		case MyCalendarUtilDateTypeSecond:
			t = NSCalendarUnitSecond;
			break;
		default:
			t = NSCalendarUnitDay;
			break;
	}
	return t;
}
#pragma mark 比较两个日期,date1比date2小返回:NSOrderedAscending,date1等于date2返回:NSOrderedSame;date1比date2大返回:NSOrderedDescending
+ (NSComparisonResult) compareFormDate:(NSDate*) date1 toDate: (NSDate*) date2 {
	return [date1 compare:date2];
}
#pragma mark 比较两个日期,startDate比endDate小返回:NSOrderedAscending,startDate等于endDate返回:NSOrderedSame;startDate比endDate大返回:NSOrderedDescending
+ (NSComparisonResult) compareStartDate:(MXGregorianDate)startDate EndDate:(MXGregorianDate)endDate {
	NSDate *sDate = [StringUtil nsDateForCFGregorianDate:startDate];
	NSDate *eDate = [StringUtil nsDateForCFGregorianDate:endDate];
	return [MyCalendarUtil compareFormDate:sDate toDate:eDate ];
}


#pragma mark 判断两个日期的大小,只基于年月日,相等返回0,thisDate比toDate小时返回-1,thisDate比toDate大时返回1
+ (int)compareByYMD:(MXGregorianDate)thisDate toDate:(MXGregorianDate)toDate {
	int res = [MyCalendarUtil compareByYM:thisDate toDate:toDate];
	
    if( res==0 ){
        if( thisDate.day == toDate.day ) {
            res = 0;
        } else if ( thisDate.day > toDate.day ) {
            res = -1;
        } else if (thisDate.day < toDate.day ){
            res = 1;
        }
    }
	
	return res;
}
#pragma mark 判断两个日期的大小,只基于年月,相等返回0,thisDate比toDate小时返回-1,thisDate比toDate大时返回1
+ (int)compareByYM:(MXGregorianDate)thisDate toDate:(MXGregorianDate)toDate {
	int res = 0;
	
	if(thisDate.year==toDate.year){
		if( thisDate.month == toDate.month ){
			res = 0;
		} else if (thisDate.month > toDate.month ){
			res = -1;
		} else if (thisDate.month < toDate.month ){
			res = 1;
		}
	}else if(thisDate.year>toDate.year ){
		res = -1;
	} else if (thisDate.year<toDate.year ){
		res = 1;
	}
	
	return res;
}
#pragma mark 判断两个日期是否是同一天，年，月，日
+ (BOOL)isEquals:(MXGregorianDate)firstDate andDate:(MXGregorianDate)secondDate {
    if(firstDate.year==secondDate.year && firstDate.month==secondDate.month && firstDate.day==secondDate.day){
        return YES ;
    }else{
        return NO;
    }
}

+ (NSString *)timeIntervalToString:(NSString *)stringMSec setDateFormat:(NSString *)yyyyMMddHHmm
{
    if (stringMSec==nil) {
        return @"";
    }
    NSDate *date=[[NSDate alloc] initWithTimeIntervalSince1970:atoll([stringMSec UTF8String])];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:yyyyMMddHHmm]; //@"yyyy/MM/dd HH:mm"
    NSString *stringConverted=[formatter stringFromDate:date];
    
    return stringConverted;
}

+(NSDate*) convertDateFromString:(NSString*)date setDateFormat:(NSString *)yyyyMMddHHmm
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:yyyyMMddHHmm];
    NSDate *formatDate=[formatter dateFromString:date];
    return formatDate;
}


+(NSString*)getWeekdayFromDate:(NSDate*)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    NSDateComponents* components = [calendar components:unitFlags fromDate:date];
    NSUInteger weekday = [components weekday];
   return  [self getWeekDayString:weekday];
}

/*
 
 "Statistical_fans_week1"="周一";
 "Statistical_fans_week2"="周二";
 "Statistical_fans_week3"="周三";
 "Statistical_fans_week4"="周四";
 "Statistical_fans_week5"="周五";
 "Statistical_fans_week6"="周六";
 "Statistical_fans_week7"="周日";
 */
+(NSString*)getWeekDayString:(NSInteger ) weekday{
    NSString* weekDayString = @"";
    if (weekday == 2) {
        weekDayString = @"周一";
    }else if(weekday == 3){
        weekDayString = @"周二";
    }else if (weekday == 4){
        weekDayString = @"周三";
    }else if(weekday == 5){
        weekDayString = @"周四";
    }else if(weekday == 6){
        weekDayString = @"周五";
    }else if(weekday == 7){
        weekDayString = @"周六";
    }else if(weekday == 1){
        weekDayString = @"周日";
    }
    return weekDayString;
}

#pragma mark - 判断闰年
+ (BOOL)isLeapYear:(NSInteger)year {
    if ((year % 4  == 0 && year % 100 != 0)  || year % 400 == 0)
        return YES;
    else
        return NO;
}

#pragma mark - 计算星座
+ (NSString *)getConstellation:(NSDate *)in_date {
    // 计算星座
    
    NSString *retStr=@"";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    int i_month=0;
    NSString *theMonth = [dateFormat stringFromDate:in_date];
    if([[theMonth substringToIndex:0] isEqualToString:@"0"]){
        i_month = [[theMonth substringFromIndex:1] intValue];
    }else{
        i_month = [theMonth intValue];
    }
    
    [dateFormat setDateFormat:@"dd"];
    int i_day=0;
    NSString *theDay = [dateFormat stringFromDate:in_date];
    if([[theDay substringToIndex:0] isEqualToString:@"0"]){
        i_day = [[theDay substringFromIndex:1] intValue];
    }else{
        i_day = [theDay intValue];
    }
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */

    
    NSMutableArray *tempArray=[NSMutableArray array];
//    [tempArray addObject:MXLang(@"PersonalCenter_info_constellation_29", @"摩羯座")]; // 0
//    [tempArray addObject:MXLang(@"PersonalCenter_info_constellation_30", @"水瓶座")]; // 1
//    [tempArray addObject:MXLang(@"PersonalCenter_info_constellation_31", @"双鱼座")]; // 2
//    [tempArray addObject:MXLang(@"PersonalCenter_info_constellation_32", @"白羊座")]; // 3
//    [tempArray addObject:MXLang(@"PersonalCenter_info_constellation_33", @"金牛座")]; // 4
//    [tempArray addObject:MXLang(@"PersonalCenter_info_constellation_34", @"双子座")]; // 5
//    [tempArray addObject:MXLang(@"PersonalCenter_info_constellation_35", @"巨蟹座")]; // 6
//    [tempArray addObject:MXLang(@"PersonalCenter_info_constellation_36", @"狮子座")]; // 7
//    [tempArray addObject:MXLang(@"PersonalCenter_info_constellation_37", @"处女座")]; // 8
//    [tempArray addObject:MXLang(@"PersonalCenter_info_constellation_38", @"天秤座")]; // 9
//    [tempArray addObject:MXLang(@"PersonalCenter_info_constellation_39", @"天蝎座")]; // 10
//    [tempArray addObject:MXLang(@"PersonalCenter_info_constellation_40", @"射手座")]; // 11
    
    
    switch (i_month) {
        case 1:
            if(i_day>=20 && i_day<=31){
                retStr=tempArray[1];//MXLang(@"PersonalCenter_info_constellation_29", @"水瓶座");
            }
            if(i_day>=1 && i_day<=19){
                retStr=tempArray[0];//MXLang(@"PersonalCenter_info_constellation_30", @"摩羯座");
            }
            break;
        case 2:
            if(i_day>=1 && i_day<=18){
                retStr=tempArray[1];//MXLang(@"PersonalCenter_info_constellation_29", @"水瓶座");
            }
            if(i_day>=19 && i_day<=31){
                retStr=tempArray[2];//MXLang(@"PersonalCenter_info_constellation_31", @"双鱼座");
            }
            break;
        case 3:
            if(i_day>=1 && i_day<=20){
                retStr=tempArray[2];//@"双鱼座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=tempArray[3];//@"白羊座";
            }
            break;
        case 4:
            if(i_day>=1 && i_day<=19){
                retStr=tempArray[3];//@"白羊座";
            }
            if(i_day>=20 && i_day<=31){
                retStr=tempArray[4];//@"金牛座";
            }
            break;
        case 5:
            if(i_day>=1 && i_day<=20){
                retStr=tempArray[4];//@"金牛座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=tempArray[5];//@"双子座";
            }
            break;
        case 6:
            if(i_day>=1 && i_day<=21){
                retStr=tempArray[5];//@"双子座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=tempArray[6];//@"巨蟹座";
            }
            break;
        case 7:
            if(i_day>=1 && i_day<=22){
                retStr=tempArray[6];//@"巨蟹座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=tempArray[7];//@"狮子座";
            }
            break;
        case 8:
            if(i_day>=1 && i_day<=22){
                retStr=tempArray[7];//@"狮子座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=tempArray[8];//@"处女座";
            }
            break;
        case 9:
            if(i_day>=1 && i_day<=22){
                retStr=tempArray[8];//@"处女座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=tempArray[9];//@"天秤座";
            }
            break;
        case 10:
            if(i_day>=1 && i_day<=23){
                retStr=tempArray[9];//@"天秤座";
            }
            if(i_day>=24 && i_day<=31){
                retStr=tempArray[10];//@"天蝎座";
            }
            break;
        case 11:
            if(i_day>=1 && i_day<=21){
                retStr=tempArray[10];//@"天蝎座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=tempArray[11];//=@"射手座";
            }
            break;
        case 12:
            if(i_day>=1 && i_day<=21){
                retStr=tempArray[11];//@"射手座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=tempArray[0];//@"摩羯座";
            }
            break;
    }
    return retStr;
}

#pragma mark 将NSDate类型转换成MXGregorianDate
+ (MXGregorianDate)convertNSDateToGregorianDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    NSInteger sec = [comps second];
    MXGregorianDate dregorianDate = {
        year,
        month,
        day,
        hour,
        min,
        sec
    };
    return dregorianDate;
}

#pragma mark 计算两个时间大小差，并以XX年XX月XX日XX时XX分XX秒形式字符串返回
+(NSString *)compareByYMDFromDate:(NSDate *)thisDate toDate:(NSDate *)toDate
{
    if (!thisDate||!toDate) {
        return nil;
    }
    NSArray *timeUnit = [NSArray arrayWithObjects:@"年",@"月",@"天",@"时",@"分",@"秒", nil];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *compareDateComponent = [cal components:unitFlags fromDate:thisDate toDate:toDate options:0];
    
    NSInteger comYear = [compareDateComponent year];
    NSInteger comMonth = [compareDateComponent month];
    NSInteger comDay = [compareDateComponent day];
    NSInteger comHour = [compareDateComponent hour];
    NSInteger comMin = [compareDateComponent minute];
    NSInteger comSec = [compareDateComponent second];
    NSInteger compareTime[] = {comYear,comMonth,comDay,comHour,comMin,comSec};
    
    NSMutableArray *difTimeComponents = [NSMutableArray array];
    for (int i=0; i<6; i++) {
        NSNumber *difNumber = [NSNumber numberWithInteger:compareTime[i]];
        [difTimeComponents addObject:difNumber];
    }
    
    int flag = -1;//记录第一个不为0的位置
    BOOL isFind = NO;//记录是否已找到第一个不为0的位置
    for (int i=0; i<difTimeComponents.count; i++) {
        if (!isFind) {
            if ([difTimeComponents[i] integerValue]!= 0) {
                if ([difTimeComponents[i] integerValue] < 0) {
                    return nil;
                }
                flag = i;
                isFind = YES;
            }
        }
    }
    
    NSMutableString *dateStr = [NSMutableString string];
    for (int i=flag; i<difTimeComponents.count; i++) {
        [dateStr appendString:[NSString stringWithFormat:@"%@%@",difTimeComponents[i],timeUnit[i]]];
    }
    
    return dateStr;
}

+ (NSString*)utcStringFormateWithDateString:(NSString*)dateStr formatter:(NSString*)formatter {
    
    NSString *utc=nil;
    NSDate *date= [self convertDateFromString:dateStr setDateFormat:formatter];
    utc = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    
    return utc;
}

#pragma mark-将世界标准时间转换为当前系统时区对应的时间
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

// 将日期转换成string字符
+ (NSString*)dateToString:(NSDate*)date formatter:(NSString*)formatter {
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:formatter];
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];//systemTimeZone
    [df setTimeZone:timeZone];
    
    NSString* str = [df stringFromDate:date];
    
    return str;
}

@end
