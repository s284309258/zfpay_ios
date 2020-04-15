//
//  NSString+Distance.h
//  MoPal_Developer
//
//  距离统一格式，处理
//
//  Created by yang.xiangbao on 15/11/25.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Distance)

/**
 *  距离单位转换
 *
 *  @return  转换后的值
 */
- (NSString *)distance;

/**
 *  四舍五入
 *
 *  @param price    原始数值
 *  @param position 小数点保留位数
 *
 *  @return
 */
- (NSString *)notRounding:(CGFloat)price afterPoint:(NSInteger)position;

@end
