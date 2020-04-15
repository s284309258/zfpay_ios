//
//  NSDictionary+HTTPRequestResultExt.m
//  Lcwl
//
//  Created by mac on 2019/1/2.
//  Copyright © 2019 lichangwanglai. All rights reserved.
//

#import "NSDictionary+HTTPRequestResultExt.h"

@implementation NSDictionary (HTTPRequestResultExt)
- (BOOL)isSuccess {
    if([[self allKeys] containsObject:@"code"]) {
        return [self[@"code"] integerValue] == 0;
    } else {
        return NO;
    }
}

- (void)showMsg {
    NSString *msg = [self valueForKey:@"msg"];
    if(![StringUtil isEmpty:msg]) {
        [NotifyHelper showMessageWithMakeText:msg];
    }
}
@end
