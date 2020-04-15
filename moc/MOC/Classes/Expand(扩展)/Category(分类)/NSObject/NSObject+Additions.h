//
//  NSObject+Additions.h
//  MoPromo_Develop
//
//  Created by yang.xiangbao on 15/5/28.
//  Copyright (c) 2015年 MoPromo. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT Class NSClassFromProtocol(id protocol);

@interface NSObject (Additions)

/// 测试属性是否存在
- (BOOL)hasPropertyForKey:(NSString *)key;

- (void)safeSetValue:(id)value forKey:(NSString *)key;

/// 获取属性列表
- (NSArray*)propertyList;

/// 检查服务器返回的是否正确,不正确设置为 @""
- (void)checkPropertyAndSetDefaultValue;

/// 拼接图片路径
- (NSString *)appendImgPath:(NSString *)path;

- (NSString *)currentCityCode;

@end
