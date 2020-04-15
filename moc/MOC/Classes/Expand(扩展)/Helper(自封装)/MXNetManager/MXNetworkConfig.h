//
//  MXNetworkConfig.h
//  YTKDemo
//
//  网络请求基本配置,如url
//  Created by aken on 16/9/24.
//  Copyright © 2016年 aken. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const ServerDomain_toString[];

// 网络请求启动入口
typedef CF_ENUM(NSInteger, MXMoXianServerDomain) {
    MXMoXianServerDomainOnline = 0,
    MXMoXianServerDomainCN     = 1,
    MXMoXianServerDomainDev    = 2,
    MXMoXianServerDomainBeta   = 3,
    MXMoXianServerDomainTest   = 4,
};

@interface MXNetworkConfig : NSObject

+ (MXNetworkConfig *)sharedInstance;

/// 切换服务器入口
@property (nonatomic, assign, readonly) MXMoXianServerDomain  serverDomain;

/// 基础API接口服务器
- (NSString *)getBaseRoot;

/// 魔聊服务器
- (NSString *)getMotalkServer;

/// 魔聊Domain
- (NSString *)getMotalkDomain;

/// 登录接口前缀
- (NSString *)getLoginPrexDomain;

/// 密匙
- (NSString *)getRSAKey;

/// 商家key
- (NSString *)merchantKey;

/// 魔聊端口
- (NSString *)getMotalkPort;

/// 获取http代理
- (NSString *)getRequiredHttpsProxy;

/**
 *  只有(在OPENHTTPS下) 线上环境、开启全局Https时才返回Https
 *
 *  @return Http或Https
 */
- (NSString *)getOptionalHttpsProxy;

/**
 *  全局是否使用都使用Https网络协议
 *
 *  @return YES为全部使用Https，NO为只有order payment sso 域名下使用https，其它扔使用Http
 */
- (BOOL)useGlobalHttpsProtocol;

/// 切换端口
- (void)exchangePort;

@end
