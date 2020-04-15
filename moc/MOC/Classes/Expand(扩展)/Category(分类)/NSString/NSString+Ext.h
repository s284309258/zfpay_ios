//
//  NSString+Ext.h
//  Lcwl
//
//  Created by mac on 2018/12/24.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Ext)
///去除字符串中所有的空格和换行符(\r\n)(包括中间和首尾)
- (NSString *)removeSpaceAndNewline;
@end

NS_ASSUME_NONNULL_END
