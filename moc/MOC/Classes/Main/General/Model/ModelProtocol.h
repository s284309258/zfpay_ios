//
//  ModelProtocol.h
//  MoPal_Developer

//  数据实体协议,所有接口返回的数据进行封装的实体对象
//  Created by aken on 15/2/11.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelProtocol <NSObject>

@optional;
/**
 * 将字典数据转换成实体对象
 */
- (void)dictionaryToModel:(NSDictionary*)dic;

@end
