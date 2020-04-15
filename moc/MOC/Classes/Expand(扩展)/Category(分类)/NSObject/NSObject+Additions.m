//
//  NSObject+Additions.m
//  MoPromo_Develop
//
//  Created by yang.xiangbao on 15/5/28.
//  Copyright (c) 2015年 MoPromo. All rights reserved.
//

#import "NSObject+Additions.h"
#import <objc/runtime.h>
#import <objc/message.h>

Class NSClassFromProtocol(id protocol) {
    if (!protocol) {
        return nil;
    }
    
    NSString *className = NSStringFromProtocol(protocol);
    return NSClassFromString(className);
}

@implementation NSObject (Additions)

// 测试属性是否存在
- (BOOL)hasPropertyForKey:(NSString*)key
{
    objc_property_t property = class_getProperty([self class], [key UTF8String]);
    return (BOOL)property;
}

- (void)safeSetValue:(id)value forKey:(NSString *)key
{
    if ([self hasPropertyForKey:key]) {
        [self setValue:value forKeyPath:key];
    }
}

// 获取属性列表
- (NSArray*)propertyList
{
    @autoreleasepool {
        NSMutableArray *list = [[NSMutableArray alloc] init];
        unsigned int pCount;
       
        objc_property_t *propertys = class_copyPropertyList([self class], &pCount);
        for (NSInteger i = 0; i < pCount; i++) {
            objc_property_t property = propertys[i];
            const char *pName = property_getName(property);
            [list addObject:[NSString stringWithUTF8String:pName]];
        }
        
        free(propertys);
        
        return list;
    }
}

// 检查服务器返回的是否正确，不正确设置为 @""
- (void)checkPropertyAndSetDefaultValue
{
    NSArray *protertys = [self propertyList];
    for (NSString *key in protertys) {
        NSString *setter = [NSString stringWithFormat:@"set%@%@:", [key substringToIndex:1].uppercaseString, [key substringFromIndex:1]];
        SEL sel = NSSelectorFromString(setter);
        if (![self.class instancesRespondToSelector:sel]) {
            return;
        }
        
        if ([[self typeOfPropertyNamed:key] rangeOfString:@"NSString" options:NSCaseInsensitiveSearch].location != NSNotFound && [StringUtil isEmpty:[self valueForKey:key]]) {
            ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)self, sel, @"");
        } else if ([[self typeOfPropertyNamed:key] rangeOfString:@"NSNumber" options:NSCaseInsensitiveSearch].location != NSNotFound && [StringUtil isEmpty:[NSString stringWithFormat:@"%@",[self typeOfPropertyNamed:key]]]) {
            ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)self, sel, @(0));
        }
    }
}

- (NSString*) typeOfPropertyNamed: (NSString *) name
{
    return [NSString stringWithUTF8String:[[self class] typeOfPropertyNamed: name]];
}

+ (const char *) typeOfPropertyNamed: (NSString *) name
{
    objc_property_t property = class_getProperty( self, [name UTF8String] );
    if ( property == NULL )
        return ( NULL );
    
    return ( property_getTypeString(property) );
}

const char * property_getTypeString( objc_property_t property )
{
    const char * attrs = property_getAttributes( property );
    if ( attrs == NULL )
        return ( NULL );
    
    static char buffer[256];
    const char * e = strchr( attrs, ',' );
    if ( e == NULL )
        return ( NULL );
    
    int len = (int)(e - attrs);
    memcpy( buffer, attrs, len );
    buffer[len] = '\0';
    
    return ( buffer );
}

#pragma mark - 拼接图片路径
- (NSString *)appendImgPath:(NSString *)path
{
    if ([StringUtil isEmpty:path]) {
        return @"";
    }
    
    if ([path hasPrefix:@"http"]) {
        return path;
    } else if ([path compare:@"/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 1)] != NSOrderedSame) {
        path = [@"/" stringByAppendingString:path];
    }
    
    return path;//MX_HTTP_URL_FORMAT(@"image", path);
}

#pragma mark - 城市切换
- (NSString *)currentCityCode
{
//    NSString *currentId;
//    if ([StringUtil isEmpty:kCurrentCityCodeValue]) {
//        CountryCodeModel *current = [[CountryHelper sharedDataBase] getCountryCodeByAbbreviation:AppCurrentCity];
//        currentId = [NSString stringWithFormat:@"%@",@(current.currentId)];
//    } else {
//        currentId = kCurrentCityCodeValue;
//    }
//
//    return currentId;
    return @"";
}

@end
