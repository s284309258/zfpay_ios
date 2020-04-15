//
//  SCConfigManager.m
//  Lcwl
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 lichangwanglai. All rights reserved.
//

#import "SCConfigManager.h"

@implementation SCConfigManager
+ (NSInteger)commentLimitCount {
    return 30;
}

+ (BOOL)validateMsg:(NSString *)msg {
    BOOL pass = msg.length <= [self commentLimitCount];
    if(!pass) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        [NotifyHelper showMessageWithMakeText:@"评论不能超过30个字符！"];
    }
    return pass;
}
@end
