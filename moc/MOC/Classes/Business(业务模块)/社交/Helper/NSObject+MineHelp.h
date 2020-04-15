//
//  NSObject+MineHelp.h
//  Lcwl
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MineHelp)
///更新基本信息
- (void)updateMyBaseInfo:(NSString *)key value:(NSString *)value personalId:(NSString *)personalId completion:(CompletionBlock)block;
///更新人性化信息
- (void)updatePersonalInfo:(NSString *)key value:(NSString *)value personalId:(NSString *)personalId completion:(CompletionBlock)block;

///更新工作经历/教育经历
- (void)updateExperience:(NSString *)key value:(NSDictionary *)value updateTye:(NSString *)type work_id:(NSString *)work_id userExperienceOper:(NSString *)userExperienceOper completion:(CompletionBlock)block;

/////更新工作经历
//- (void)updateWorkInfo:(NSString *)key value:(NSDictionary *)value work_id:(NSString *)work_id completion:(CompletionBlock)block;
/////更新教育经历
//- (void)updateEducationInfo:(NSString *)key value:(NSDictionary *)value education_id:(NSString *)education_id completion:(CompletionBlock)block;


- (NSInteger)indexOfSex:(NSString *)sex;

- (NSInteger)indexOfRelationship:(NSString *)relationship;

- (NSInteger)indexOfEducation:(NSString *)education;

-(void)getCommunityRankList:(NSDictionary*) param completion:(MXHttpRequestListCallBack)completion;

-(void)getMyCommunityRank:(NSDictionary*) param completion:(MXHttpRequestListCallBack)completion;

-(void)updateComNickName:(NSDictionary*) param completion:(MXHttpRequestCallBack)completion;
    
///130.（社区）查询我的社区信息,查询我的社区信息，包括直推知县人数和自己自己的社区信息状态
- (void)getMyCommunityInfo:(CompletionBlock)completion;

- (void)applyCommunity:(NSString *)nickName completion:(CompletionBlock)completion;

@end

//NS_ASSUME_NONNULL_END
