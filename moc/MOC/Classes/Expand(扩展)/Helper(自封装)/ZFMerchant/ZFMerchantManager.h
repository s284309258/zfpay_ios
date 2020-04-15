//
//  ZFMerchantManager.h
//  MerchantLib
//
//  Created by 中付支付 on 2018/12/10.
//  Copyright © 2018年 中付支付. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZFMerchantManagerDelegate <NSObject>

///失败  返回错误信息
- (void)merchantManagerReturnError:(NSString *)msg;

///成功 返回商户信息、其他信息
- (void)merchantManagerReturnSuccess:(NSDictionary *)merchantInfo other:(NSString *)other;

@end

@interface ZFMerchantManager : NSObject

@property (nonatomic, assign)id<ZFMerchantManagerDelegate>delegate;

+ (instancetype)shareManager;

/**
 新增商户
 @param account 代理账号
 @param vc 当前控制器
 @param other 成功时传回字段
 */
- (void)presentWithAccount:(NSString *)account
            viewController:(UIViewController *)vc
                     other:(NSString *)other;

/**
 修改商户信息
 @param account 代理账号
 @param merName 商户名
 @param merCode 商户号(非必传)
 @param vc 当前控制器
 @param other 成功时传回字段
 */
- (void)changeInfoWithAccount:(NSString *)account
                 merchantName:(NSString *)merName
                 merchantCode:(NSString *)merCode
               viewController:(UIViewController *)vc
                        other:(NSString *)other;

@end

NS_ASSUME_NONNULL_END
