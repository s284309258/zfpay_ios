//
//  NSString+Url.h
//  MoPal_Developer
//
//  处理url
//
//  Created by lhy on 16/12/30.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUrl : NSObject

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;

@end
