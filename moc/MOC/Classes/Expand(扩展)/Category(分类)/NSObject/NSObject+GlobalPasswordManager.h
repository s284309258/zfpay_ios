//
//  NSObject+GlobalPasswordManager.h
//  MoPal_Developer
//
//  Created by xgh on 16/6/17.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PassIsLockedBlock)(BOOL isLocked);

@interface NSObject (GlobalPasswordManager)

//密码是否被锁
- (void)passwordIsLocked:(PassIsLockedBlock)callBack;

//设置密码解锁时间
- (void)setExpiredTime:(NSDictionary *)expiredTimeInfo;

@end
