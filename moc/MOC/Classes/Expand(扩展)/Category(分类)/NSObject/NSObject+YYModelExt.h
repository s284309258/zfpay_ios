//
//  NSObject+YYModelExt.h
//  Lcwl
//
//  Created by mac on 2018/12/19.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YYModelExt)
+ (NSArray *)modelsArrayWithClass:(Class)cls array:(NSArray *)arr;
@end

NS_ASSUME_NONNULL_END
