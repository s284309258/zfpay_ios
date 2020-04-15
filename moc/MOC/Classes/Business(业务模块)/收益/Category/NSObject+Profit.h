//
//  NSObject+ProfitHelper.h
//  XZF
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Profit)

- (void)getUserNewInfo:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//收益中心 - 查询头部信息
- (void)getHeaderInformation:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//收益中心 - 查询每月汇总信息（传统POS）
- (void)getBenefitCentreTraditionalPosDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//收益中心 - 查询每月汇总信息（MPOS）
- (void)getBenefitCentreMposDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//收益中心 - 查询每月汇总信息（EPOS）
- (void)getBenefitCentreEPosDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;

//分润记录列表（传统POS）
- (void)getShareBenefitTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//分润记录列表（MPOS）
- (void)getShareBenefitMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;

//机器返现列表（传统POS）
- (void)getMachineBackTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//机器返现列表（MPOS）
- (void)getMachineBackMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;

//未达标列表（传统POS）
- (void)getDeductTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//未达标列表（传统POS）
- (void)getDeductMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;

//活动奖励列表（传统POS）
- (void)getActivityRewardTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//机器返现列表（MPOS）
- (void)getActivityRewardMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;



@end

NS_ASSUME_NONNULL_END




