//
//  NSObject+Property.m
//  MoPromo_Develop
//
//  Created by 李星楼 on 15/8/21.
//  Copyright (c) 2015年 MoPromo. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

@implementation NSObject (Property)


-(void)setPropertyWithDictionary:(NSDictionary *)paramDict{
    
    
    [[paramDict allKeys] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        const char *name=[obj UTF8String];
        
        objc_property_t property = class_getProperty([self class], name);
        
        if(property){
            
            NSObject *propertyValue=paramDict[obj];
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil){
                [self setValue:propertyValue forKey:obj];
            }
        }
        
        
    }];
    
}
@end
