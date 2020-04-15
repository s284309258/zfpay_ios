//
//  NSString+NumFormat.h
//  MoPal_Developer
//
//  Created by Fly on 15/8/12.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NumFormat)

//共条
+ (NSString*)getFormatTotalString:(NSInteger)count;

//点赞数量超过1000（超过1K，单位显示k）
+ (NSString*)getFormatBrowseCount:(NSInteger)count;

- (BOOL)isPureInt;

- (NSString *)showNoUnitFormatPrice;
- (NSString *)showIntFormatPrice:(BOOL)needUnit;

- (NSString *)formatterMoney;

+ (NSString *)deductionPointTranferCash:(double)point;

- (NSString *)starReplace;

- (NSString *)dateAddDot;
@end
