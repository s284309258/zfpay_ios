//
//  MXNetworkConfig.m
//  YTKDemo
//
//  Created by aken on 16/9/24.
//  Copyright © 2016年 aken. All rights reserved.
//

#import "MXNetworkConfig.h"
#import "GVUserDefaults+Properties.h"
#import "MXCache.h"
static NSString* talkPort = @"moTalkPort";

NSString * const ServerDomain_toString[] = {
    [MXMoXianServerDomainOnline] = @"MXMoXianServerDomainOnline",
    [MXMoXianServerDomainCN]     = @"MXMoXianServerDomainCN",
    [MXMoXianServerDomainDev]    = @"MXMoXianServerDomainDev",
    [MXMoXianServerDomainBeta]   = @"MXMoXianServerDomainBeta",
    [MXMoXianServerDomainTest]   = @"MXMoXianServerDomainTest",
};

@interface MXNetworkConfig()

@property (nonatomic, assign, readwrite) MXMoXianServerDomain  serverDomain;

@end

@implementation MXNetworkConfig

+ (MXNetworkConfig *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        // 手动切换环境
#ifdef OpenDebugVC
        self.serverDomain = [[GVUserDefaults standardUserDefaults] serverType];
#else
        self.serverDomain = MXMoXianServerDomainOnline;
#endif
    }
    return self;
}

static NSString *baseServerRoot = nil;
static NSString *baseImageRoot = nil;
static NSString *motalkServerRoot = nil;
static NSString *motalkDomain = nil;

#pragma mark 主API接口服务器
- (NSString *)getBaseRoot {
    
    if (baseServerRoot) {
        return baseServerRoot;
    }
    switch (self.serverDomain) {
        case MXMoXianServerDomainOnline:
            baseServerRoot = @".moxian.com";
            break;
        case MXMoXianServerDomainCN:
            baseServerRoot = @".press.moxian.com";
            break;
        case MXMoXianServerDomainDev:
            baseServerRoot = @".dev2.moxian.com";
            break;
        case MXMoXianServerDomainBeta:
            baseServerRoot = @".beta.moxian.com";
            break;
        case MXMoXianServerDomainTest:
            baseServerRoot = @".test.moxian.com";
            break;
    }
    return baseServerRoot;
}

- (NSString *)merchantKey {
    
    NSString *merchant;
    switch (self.serverDomain) {
        case MXMoXianServerDomainOnline:
            merchant = @"mox20150929#@!";
            break;
        case MXMoXianServerDomainCN:
        case MXMoXianServerDomainDev:
        case MXMoXianServerDomainBeta:
        case MXMoXianServerDomainTest:
            merchant = @"123456";
            break;
    }
    
    return merchant;
}

#pragma mark 魔聊服务器
- (NSString *)getMotalkServer {
    if (motalkServerRoot) {
        return motalkServerRoot;
    }
    switch (self.serverDomain) {
        case MXMoXianServerDomainOnline:
            motalkServerRoot = @"imsz.moxian.com";
            break;
        case MXMoXianServerDomainCN:
            motalkServerRoot = @"14.215.133.20";
            break;
        case MXMoXianServerDomainDev:
            motalkServerRoot = @"imsz.dev2.moxian.com";
            break;
        case MXMoXianServerDomainBeta:
            motalkServerRoot = @"imsz.beta.moxian.com";
            break;
        case MXMoXianServerDomainTest:
            motalkServerRoot = @"imsz.test.moxian.com";
            break;
    }
    
    return motalkServerRoot;
}


#pragma mark 魔聊Domain
- (NSString *)getMotalkDomain {
    
    if (motalkDomain) {
        return motalkDomain;
    }
    switch (self.serverDomain) {
        case MXMoXianServerDomainOnline:
            motalkDomain = @"imsz.moxian.com";
            break;
        case MXMoXianServerDomainCN:
        case MXMoXianServerDomainDev:
        case MXMoXianServerDomainBeta:
        case MXMoXianServerDomainTest:
            motalkDomain = @"openfire";
            break;
    }
    return motalkDomain;
}
- (NSArray*)motalkPortArray {
    return  @[@"80",@"443",@"5222"];
}

- (NSString *)getMotalkPort{
    
    NSString* port =  [MXCache valueForKey:talkPort];
    if ([StringUtil isEmpty:port]) {
        NSArray* ports = [self motalkPortArray];
        return ports[0];
    }else{
        return port;
    }
    return @"";
}

- (void)exchangePort {
    
    NSString* orignPort = [MXCache valueForKey:talkPort];
    NSArray* ports = [self motalkPortArray];
    if ([StringUtil isEmpty:orignPort]) {
        [MXCache setValue:ports[0] forKey:talkPort];
    }else{
        // modify by lifei at 2015.12.8
        NSUInteger index = [ports indexOfObject:orignPort];
        if (index == NSNotFound ||
            (index == (ports.count-1))) {
            index = 0;
        }else{
            index ++;
        }
        
        [MXCache setValue:ports[index] forKey:talkPort];
    }
}

- (NSString *)getLoginPrexDomain {
    if (self.serverDomain == MXMoXianServerDomainOnline) {
        return @"mxlogin";
    }
    return @"login";
}

static NSString *requiredHttpsProtocol = nil;

- (NSString *)getRequiredHttpsProxy {
    if (![StringUtil isEmpty:requiredHttpsProtocol]) {
        return requiredHttpsProtocol;
    }
#ifdef OPENHTTPS
    if (self.serverDomain == MXMoXianServerDomainOnline){
        requiredHttpsProtocol = @"https";
        return requiredHttpsProtocol;
    }
#endif
    requiredHttpsProtocol = @"http";
    return requiredHttpsProtocol;
}

/**
 *  只有(在OPENHTTPS下) 线上环境、开启全局Https时才返回Https
 *
 *  @return Http或Https
 */
static NSString *optionalHttpsProtocol = nil;

- (NSString *)getOptionalHttpsProxy{
    if (![StringUtil isEmpty:optionalHttpsProtocol]) {
        return optionalHttpsProtocol;
    }
#ifdef OPENHTTPS
    if (self.serverDomain == MXMoXianServerDomainOnline &&
        [self useGlobalHttpsProtocol]) {
        optionalHttpsProtocol = @"https";
        return optionalHttpsProtocol;
    }
#endif
    optionalHttpsProtocol = @"http";
    return optionalHttpsProtocol;
}

/**
 *  全局是否使用都使用Https网络协议
 *
 *  @return YES为全部使用Https，NO为只有order payment sso 域名下使用https，其它扔使用Http
 */
- (BOOL)useGlobalHttpsProtocol{
#ifdef kGlobalHttps
    return YES;
#else
    return NO;
#endif
}

- (NSString *)getRSAKey {
    
    NSString *rsaKey=nil;
    
    if (self.serverDomain == MXMoXianServerDomainOnline) {
        rsaKey=@"A25B8D99B2170E9C7434824FA5F710A6C48ADE2EED6F3EA749B89182AF944F61959A2ED3D4E60BF98FA88BCA92833AC11718C05820E73C17F85CEF636697E4BBC9F6D8F80BA2FB56E9CBD8CFDFBBE923D59FB0D692B3DD1034CEBD6DBF8FAFBCE00D4759B1D5054A6E18EEEFE55D52F34E6C00EB621B9E6AE196AA5B972C8F59";
    }else{
        rsaKey=@"98B8A8719EC56C45964833CDDC659520F77D8CD491A9ADD71FC3B8A0AA7296AFF57B0C26847A15CE8B268DC83BFC535B325CB5A8765CE5FCF1E545D402D6D2E6F3A5AB6E52E9859FF88E4E58B5A154172D88E15B7D3436EA0BD179C5343F3ABD01B4A5872F2A0FDAD32EE6CDF1C48F4839797F451E38EEA2DF720168D2DA428F";
    }
    
    return rsaKey;
}

@end
