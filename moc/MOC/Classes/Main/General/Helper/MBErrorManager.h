//
//  MBErrorManager.h
//  MoPromo_Develop
//
//  Created by yang.xiangbao on 15/6/1.
//  Copyright (c) 2015年 MoPromo. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MXRequest+RequestError.h"

@interface MBErrorManager : NSObject

/**
 *  显示服务器返回的错误信息
 *
 *  @param code 错误码
 */
+ (NSString *)showErrorMessageWithCode:(NSString *)code;

@end
