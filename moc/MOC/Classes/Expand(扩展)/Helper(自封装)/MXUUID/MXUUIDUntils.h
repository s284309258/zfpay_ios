//
//  MXUUIDUntils.h
//  MoPal_Developer
//
//  Created by fly on 2016/10/19.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXUUIDUntils : NSObject

+ (void)saveUUIDToKeyChain;
+ (BOOL)removeUUIDFromKeyChain;
+ (NSString *)readUUIDFromKeyChain;

@end
