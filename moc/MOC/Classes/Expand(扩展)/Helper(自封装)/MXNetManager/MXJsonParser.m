//
//  MXJsonParser.m
//  MoPal_Developer
//
//  Created by aken on 15/2/6.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MXJsonParser.h"

@implementation MXJsonParser

+ (NSString *)dictionaryToJsonString:(NSDictionary*)dictionary {
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    
    NSString *jsonString=nil;
    NSError *error=nil;
    @try {
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        
        //Data转换为JSON
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    @catch (NSException *exception) {
        NSLog(@"数据格式解析失败:%@",error);
    }
    
    return jsonString;
}

+ (id)jsonToDictionary:(id)jsonString {
    if (!jsonString) {
        return nil;
    }
   
    id obj=nil;
    NSError *error=nil;
    
    @try {
        
        obj =[NSJSONSerialization JSONObjectWithData: [jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &error];
        
    }
    @catch (NSException *exception) {
       
        NSLog(@"数据格式解析失败:%@ -jsonString:%@",error,jsonString);
    }
    
    return obj;
}

@end
