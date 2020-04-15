//
//  NSDictionary+HTTPRequestResultExt.h
//  Lcwl
//
//  Created by mac on 2019/1/2.
//  Copyright © 2019 lichangwanglai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (HTTPRequestResultExt)
- (BOOL)isSuccess;
- (void)showMsg;
@end

NS_ASSUME_NONNULL_END
