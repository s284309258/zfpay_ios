//
//  NSObject+Business.h
//  MOC
//
//  Created by mac on 2019/6/22.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (RF)
//报表首页
- (void)getHomePageInfo:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//代理每天详情（传统POS）
- (void)getDayAgencyTraditionalPosDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//代理每月详情（传统POS）
- (void)getMonthAgencyTraditionalPosDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
// 商户每天详情（传统POS）
- (void)getDayMerchantTraditionalPosDetail:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//商户每月详情（传统POS）
- (void)getMonthMerchantTraditionalPosDetail:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//代理每天走势（传统POS）
- (void)getDayAgencyTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//代理每月走势（传统POS） 
- (void)getMonthAgencyTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//商户每天走势（传统POS）
- (void)getDayMerchantTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//商户每月走势（传统POS）
- (void)getMonthMerchantTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;


//代理每天详情（MPOS）
- (void)getDayAgencyMposDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//代理每月详情（MPOS）
- (void)getMonthAgencyMposDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//商户每天详情（MPOS）
- (void)getDayMerchantMposDetail:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//商户每月详情（MPOS）
- (void)getMonthMerchantMposDetail:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;

//代理每天走势（MPOS）
- (void)getDayAgencyMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//代理每月走势（MPOS）
- (void)getMonthAgencyMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//商户每天走势（MPOS） 未做
- (void)getDayMerchantMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//商户每月走势（MPOS） 未做
- (void)getMonthMerchantMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;



@end

NS_ASSUME_NONNULL_END
