//
//  YTKNetworkConfig+Swizzling.m
//  YTKDemo
//
//  Created by aken on 16/9/24.
//  Copyright © 2016年 aken. All rights reserved.
//

#import "YTKNetworkConfig+Swizzling.h"
#import "Aspects.h"
#import "AFSecurityPolicy.h"

@implementation YTKNetworkConfig (Swizzling)

+ (void)load {
    
    
    [YTKNetworkConfig aspect_hookSelector:@selector(init) withOptions:0 usingBlock:^(id<AspectInfo> info){
        
        #ifdef OPENHTTPS
        YTKNetworkConfig *conf = [info instance];
        AFSecurityPolicy *security = [YTKNetworkConfig securityPolicyFinal];
        conf.securityPolicy = security;
        #endif
        
    } error:nil];
    
}

#ifdef OPENHTTPS
+ (AFSecurityPolicy *)securityPolicyFinal {
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"online" ofType:@"cer"];
    NSData *certData  = [NSData dataWithContentsOfFile:cerPath];
    if (!cerPath) {
        return nil;
    }
    
    NSMutableSet *certificates = [NSMutableSet setWithCapacity:0];
    [certificates addObject:certData];
    
    // 校验服务器端给予的证书的模式 AFSSLPinningModeCertificate
    AFSecurityPolicy *securityPolicyFinal = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[NSSet setWithSet:certificates]];
    // 否信任非法证书
#if DEBUG
    [securityPolicyFinal setAllowInvalidCertificates:YES];
#else
    [securityPolicyFinal setAllowInvalidCertificates:NO];
#endif

    
    
    // 是否校验在证书中的domain
    [securityPolicyFinal setValidatesDomainName:YES];
    
    return securityPolicyFinal;
}
#endif

@end
