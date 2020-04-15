//
//  BaseObject.h
//  MoPal_Developer
//
//  Created by Fly on 15/8/13.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseObject : NSObject

/**
 *  解析Json数据的类方法，直接解析成相应的Model
 *
 *  @param dict 需要解析的Dictionary数据
 *
 *  @return 解析Json后的Model数据
 */
+ (instancetype)modelParseWithDict:(NSDictionary *)dict;

/**
 *  解析包含数组Json数据的类方法，直接解析成包含相应的Model的Array
 *
 *  @param dictList 需要解析的Json数据List
 *
 *  @return 解析Json后的Model数据Array
 */
+ (NSArray *)modelListParseWithArray:(NSArray*)dictList;

/**
 *  获取网络请求的参数方法，默认是返回 nil
 *
 *  @return 返回的Parsms
 */
- (NSDictionary*)genTaskParams;


@end
