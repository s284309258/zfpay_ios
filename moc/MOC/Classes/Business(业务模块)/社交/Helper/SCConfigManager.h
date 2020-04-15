//
//  SCConfigManager.h
//  Lcwl
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 lichangwanglai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCConfigManager : NSObject
+ (NSInteger)commentLimitCount;
+ (BOOL)validateMsg:(NSString *)msg;
@end

NS_ASSUME_NONNULL_END
