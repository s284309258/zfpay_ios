//
//  RASManage.h
//  JiuJiuEcoregion
//
//  Created by mac on 2019/6/1.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSAManage : NSObject
+ (NSString *)encryptString:(NSString *)orginStr;
+ (NSString *)decryptString:(NSString *)encryptStr;
+ (NSString *)encrypt2String:(NSString *)orginStr; //聊天
+ (NSString *)encrypt3String:(NSString *)orginStr; //
@end

NS_ASSUME_NONNULL_END
