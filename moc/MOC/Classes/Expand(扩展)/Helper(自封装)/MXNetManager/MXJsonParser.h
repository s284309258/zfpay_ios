//
//  MXJsonParser.h
//  MoPal_Developer
//
//  json字符操作类，包括将字典转换成json，json转换成字典
//  Created by aken on 15/2/6.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXJsonParser : NSObject

/**
 *  将字典转换成json
 *
 *  @param dictionary 字典
 *
 *  @return json
 */
+ (NSString*)dictionaryToJsonString:(NSDictionary*)dictionary;
    

/**
 *  将json转换字典
 *
 *  @param jsonString json
 *
 *  @return 字典
 */
+ (id)jsonToDictionary:(id)jsonString;

@end
