//
//  UIViewController+ActionBlock.m
//  MoPromo_Develop
//
//  Created by fly on 16/1/8.
//  Copyright © 2016年 MoPromo. All rights reserved.
//

#import "NSObject+CallBackBlock.h"
#import <objc/runtime.h>

NSString *const MoActionUserInfoKey = @"MoPalActionUserInfoKey";

@implementation NSObject (CallBackBlock)

#pragma mark - runtime associate

- (void)setActionBlock:(HandlerActionBlock)actionBlock {
    objc_setAssociatedObject(self, @selector(actionBlock), actionBlock, OBJC_ASSOCIATION_COPY);
}

- (HandlerActionBlock)actionBlock {
    return objc_getAssociatedObject(self, @selector(actionBlock));
}

#pragma mark - block

- (void)setCallBackActionBlock:(HandlerActionBlock)actionBlock {
    self.actionBlock = nil;
    self.actionBlock = [actionBlock copy];
}

- (void)execCallBackActionBlock:(id)object {
    if (!object) {
        NSLog(@"object is nil");
        return;
    }
    NSDictionary *userInfo = @{MoActionUserInfoKey : object};
    [self execCallBackForUserInfo:userInfo];
}

- (void)execCallBackForUserInfo:(NSDictionary *)userInfo{
    if (self.actionBlock) {
        self.actionBlock(self, userInfo);
    }
}

@end
