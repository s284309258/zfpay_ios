//
//  NSObject+Home.h
//  MOC
//
//  Created by mac on 2019/6/22.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Home)
//查询APP图片列表
- (void)getAppImgList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询系统最新公告接口
- (void)getNewNotice:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//查询新闻资讯列表接口
- (void)getNewNews:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询资讯详情
- (void)getNewsDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//查询传统POS列表
- (void)getScanTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//提交申请记录
- (void)addApplyScanRecord:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//查询记录列表
- (void)getApplyScanRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询MPOS列表
- (void)getMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//修改商户信息
- (void)editMposMerInfo:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//查询传统POS活动列表
- (void)getTraditionalPosOnlineActivityList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询MPOS活动列表
- (void)getMposOnlineActivityList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询传统POS活动奖励列表
- (void)getTraditionalPosRewardRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询MPOS活动奖励列表
- (void)getMposRewardRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询用户活动申请列表（传统POS）
- (void)getTraditionalPosActivityApplyList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询用户活动申请列表（MPOS）
- (void)getMposActivityApplyList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询用户活动申请详情（传统POS）
- (void)getTraditionalPosActivityApplyDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//查询用户活动申请详情（MPOS） 
- (void)getMposActivityApplyDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//查询活动详情（传统POS）
-(void)getTraditionalPosOnlineActivityDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//查询活动详情（MPOS）
-(void)getMposOnlineActivityDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//查询参与活动选择信息（传统POS）
- (void)getTraditionalPosPartActivityInfo:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询参与活动选择信息（MPOS）
- (void)getMposPartActivityInfo:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//提交活动申请（传统POS）
- (void)submitTraditionalPosActivityApply:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//提交活动申请（MPOS）
- (void)submitMposActivityApply:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//取消活动申请（传统POS）
- (void)cancelTraditionalPosActivityApply:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//取消活动申请（传统MPOS）
- (void)cancelMposActivityApply:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//获取待分配列表（传统POS）
- (void)getTraditionalPosAllocationList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//获取待分配列表（MPOS）
- (void)getMposAllocationList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//获取待分配列表（流量卡）
- (void)getTrafficCardAllocationList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//机具管理 - 查询直推代理
- (void)getRefererAgency:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询系统配置参数（传统POS）
- (void)getTraditionalPosSysParamRateList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询系统配置参数（MPOS）
- (void)getMposSysParamRateList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//获取待召回列表（传统POS）
- (void)getTraditionalPosRecallList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//获取待召回列表（传统MPOS）
- (void)getMposRecallList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//获取待召回列表（流量卡）
- (void)getTrafficCardRecallList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;


//分配（传统POS）
- (void)allocationTraditionalPos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//分配（MPOS）
- (void)allocationMpos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//分配（流量卡）
- (void)allocationTrafficCard:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;


//召回（传统POS）
- (void)recallTraditionalPos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//召回（MPOS）
- (void)recallMpos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//召回（流量卡）
- (void)recallTrafficCard:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;


//解绑（传统POS）
-(void)unbindTraditionalPos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//解绑（MPOS）
-(void)unbindMpos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//查询解绑记录（传统POS）
- (void)getTraditionalPosUnbindRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询解绑记录（MPOS）
- (void)getMposUnbindRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;

//查询分配记录（传统POS）
- (void)getAllocationTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询分配记录（MPOS）暂时不用
- (void)getAllocationMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询分配批次 sys_user_id，pos_type(MPOS,TraditionalPOS,TrafficCard)
- (void)selectPosBatchAllocate:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询分配记录（流量卡）
- (void)getAllocationTrafficCardList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;


/*
 记录编号
 allocation_id
 支付宝结算价
 zhifubao_settle_price
 云闪付结算价
 cloud_settle_price
 微信结算价
 weixin_settle_price
 返现比例
 cash_back_rate
 刷卡结算价
 card_settle_price
 单笔比例
 single_profit_rate

 */
//修改分配记录（传统POS） 暂时不用
- (void)editAllocationTraditionalPos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//修改分配记录（MPOS）暂时不用
- (void)editAllocationMpos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//批次修改MPOS分配记录
- (void)editAllocationMPosBatch:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//批次修改传统POS分配记录
- (void)editAllocationTraditionalPosBatch:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;

//查询分配详情（传统POS） 暂时不用
-(void)getAllocationTraditionalPosDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//查询分配详情（MPOS） 暂时不用
-(void)getAllocationMposDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//跟据SN号和UserID查询代理的结算价格等信息
-(void)selectPosSettlePriceBySN:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;

//查询召回记录（传统POS）
- (void)getRecallTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//处理召回记录（传统POS）
- (void)dealRecallTraditionalPos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//查询召回记录（MPOS）
- (void)getRecallMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//处理召回记录（MPOS）
- (void)dealRecallMpos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//查询召回记录（流量卡）
- (void)getRecallTrafficCardList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//处理召回记录（MPOS）
- (void)dealRecallTrafficCard:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//费率申请 - 查询POS机列表（传统POS）
- (void)getApplyRateTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//费率申请 - 查询POS机列表（MPOS）
- (void)getApplyRateMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询刷卡费率列表
- (void)getCreditCardRateList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//申请刷卡费率（传统POS）
- (void)addApplyRateTraditionalPos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//申请刷卡费率（MPOS）
- (void)addApplyRateMpos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//查询费率申请列表（传统POS）
- (void)getApplyRateTraditionalPosRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询费率申请列表（MPOS）
- (void)getApplyRateMposRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//直营商户汇总（传统POS）
- (void)getSummaryTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//直营商户汇总（MPOS）
- (void)getSummaryMposList:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;

//全部商户列表（传统POS）
- (void)getAllMerchantTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//优质商户列表（传统POS）
- (void)getExcellentMerchantTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//活跃商户列表（传统POS）
- (void)getActiveMerchantTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//休眠商户列表（传统POS）
- (void)getDormantMerchantTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;

//全部商户列表（MPOS）
- (void)getAllMerchantMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//优质商户列表（MPOS）
- (void)getExcellentMerchantMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//活跃商户列表（MPOS）
- (void)getActiveMerchantMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//休眠商户列表（MPOS）
- (void)getDormantMerchantMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;

//商户详情（传统POS）
- (void)getTraditionalPosDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//商户详情（MPOS）
- (void)getMposDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;

//查询代理列表
- (void)getReferAgencyList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询代理人数
- (void)getReferAgencyNum:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//查询代理详情头部（传统POS）
- (void)getReferAgencyHeadTraditionalPosInfo:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//查询代理详情头部（MPOS）
- (void)getReferAgencyHeadMposInfo:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;


//查询代理商户列表（传统POS）
- (void)getReferAgencyTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询代理商户列表（MPOS）
- (void)getReferAgencyMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;

//查询钱柜列表
- (void)getMoneyLockerCollegeList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;
//查询钱柜详情
- (void)getMoneyLockerCollegeDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;

//传统POS-进件商户查询列表
- (void)getTraditionalPosInstallList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;


//传统POS-进件商户查询详情
- (void)getTraditionalPosInstallDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;

//查询达标商户
-(void)selectPolicy3Record:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;

//领取政策奖励
-(void)chooseAward:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;

//查询可以解绑的传统POS[新增接口 201912]
-(void)selectUnbindTraditionalPos:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;

//查询可以解绑的MPOS
-(void)selectUnbindMpos:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;


//查看是否有小红点
-(void)getUnReadNews:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//更新小红点(消灭掉)
-(void)updateNewsReadFlag:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;



-(void)getReferAgencyTraditionalPosTradeAmountAvg:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;


-(void)getReferAgencyMPosTradeAmountAvg:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;


//更新商户姓名和商户电话
- (void)updateMerchantNameAndTel:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;


- (void)getTraditionalPosTradeDetail:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion;

@end

NS_ASSUME_NONNULL_END
