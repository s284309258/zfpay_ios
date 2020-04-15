//
//  UIViewController+ActionBlock.h
//  MoPromo_Develop
//
//  Created by fly on 16/1/8.
//  Copyright © 2016年 MoPromo. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const MoActionUserInfoKey;

typedef void (^HandlerActionBlock)(NSObject *handler, NSDictionary *userInfo);

@interface NSObject (CallBackBlock)

- (void)setCallBackActionBlock:(HandlerActionBlock)actionBlock;

/**
 *  执行ActionBolck,把object存入到userInfo里，并且key为MoActionUserInfoKey
 *  @{MoActionUserInfoKey : object}
 *
 *  @param object 需要传入的对象
 */
- (void)execCallBackActionBlock:(id)object;

/**
 *  执行ActionBolck,使用userInfo
 *
 *  @param userInfo 传入的参数
 */
- (void)execCallBackForUserInfo:(NSDictionary *)userInfo ;

@end
