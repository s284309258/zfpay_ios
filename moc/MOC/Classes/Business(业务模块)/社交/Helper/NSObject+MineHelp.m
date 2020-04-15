//
//  NSObject+MineHelp.m
//  Lcwl
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "NSObject+MineHelp.h"

@implementation NSObject (MineHelp)

- (void)updateMyInfo:(NSString *)key value:(id)value updateTye:(NSString *)type personalId:(NSString *)personalId userExperienceOper:(NSString *)userExperienceOper completion:(CompletionBlock)block {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot,@"front/userInfo/updateMyInfo"];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
    if(value && [value isKindOfClass:[NSString class]]) {
        [param setValue:value forKey:key];
    } else if(value && [value isKindOfClass:[NSDictionary class]]){
        [param setDictionary:value];
    }
    [param setValue:type forKey:@"update_user_type"];
    
    if([type isEqualToString:@"user_work"]) {
        [param setValue:personalId forKey:@"work_id"];
        [param setValue:userExperienceOper forKey:@"user_work_oper"];
    } else if([type isEqualToString:@"user_education"]) {
        [param setValue:personalId forKey:@"education_id"];
        [param setValue:userExperienceOper forKey:@"user_education_oper"];
    } else {
        [param setValue:personalId forKey:@"personal_id"];
    }
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary *tempDic = (NSDictionary*)data;
            [tempDic showMsg];
            if ([tempDic[@"success"] boolValue]) {
                NSString *ID = nil;
                if([type isEqualToString:@"user_work"]) {
                    ID = [tempDic valueForKeyPath:@"data.work_id"];
                } else if([type isEqualToString:@"user_education"]) {
                    ID = [tempDic valueForKeyPath:@"data.education_id"];
                } else if([type isEqualToString:@"user_personnal"]) {
                    ID = [tempDic valueForKeyPath:@"data.personal_id"];
                }
                Block_Exec(block,ID);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateMyInfoVCTitle" object:[tempDic valueForKeyPath:@"data.complete_rate"]];
            }
        }).failure(^(id error){
            Block_Exec(block,nil);
            [NotifyHelper showMessageWithMakeText:[error description]];
        })
        .execute();
    }];
}

- (void)updateMyBaseInfo:(NSString *)key value:(NSString *)value personalId:(NSString *)personalId completion:(CompletionBlock)block {
    [self updateMyInfo:key value:value updateTye:@"user_info" personalId:personalId userExperienceOper:nil completion:block];
}

- (void)updatePersonalInfo:(NSString *)key value:(NSString *)value personalId:(NSString *)personalId completion:(CompletionBlock)block {
    [self updateMyInfo:key value:value updateTye:@"user_personnal" personalId:personalId userExperienceOper:nil completion:block];
}

- (void)updateExperience:(NSString *)key value:(NSDictionary *)value updateTye:(NSString *)type work_id:(NSString *)work_id userExperienceOper:(NSString *)userExperienceOper completion:(CompletionBlock)block {
    __weak UIViewController *vc = (UIViewController *)self;
    
    if([self isKindOfClass:[UIViewController class]]) {
        [NotifyHelper showHUDAddedTo:vc.view animated:YES];
    }
    
    [self updateMyInfo:key value:value updateTye:type personalId:work_id userExperienceOper:userExperienceOper completion:^(id data) {
        [NotifyHelper hideHUDForView:vc.view animated:YES];
        Block_Exec(block,data);
    }];
}

//- (void)updateWorkInfo:(NSString *)key value:(NSDictionary *)value work_id:(NSString *)work_id completion:(CompletionBlock)block {
//    [self updateMyInfo:key value:value updateTye:@"user_work" personalId:work_id completion:block];
//}
//
//- (void)updateEducationInfo:(NSString *)key value:(NSDictionary *)value education_id:(NSString *)education_id completion:(CompletionBlock)block {
//    [self updateMyInfo:key value:value updateTye:@"user_education" personalId:education_id completion:block];
//}

- (NSInteger)indexOfSex:(NSString *)sex {
    NSArray *sexArr = @[@"男",@"女"];
    return [sexArr indexOfObject:sex];
}

- (NSInteger)indexOfRelationship:(NSString *)relationship {
    NSArray *relationshipArr = @[@"保密",@"单身",@"恋爱",@"订婚",@"已婚"];
    return [relationshipArr indexOfObject:relationship];
}

- (NSInteger)indexOfEducation:(NSString *)education {
    NSArray *educationArr = @[@"本科",@"硕士",@"博士",@"专科",@"高中",@"初中",@"小学"];
    return [educationArr indexOfObject:education];
}


-(void)getCommunityRankList:(NSDictionary*) param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot,@"front/community/getCommunityRankList"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                NSDictionary* dataDict = tempDic[@"data"];
                if (dataDict) {
                    NSDictionary* communityRankList = dataDict[@"communityRankList"];
                    if (communityRankList) {
                        completion(communityRankList,nil);
                    }
                }
            }else{
                  [NotifyHelper showMessageWithMakeText:tempDic[@"msg"]];
            }
        }).failure(^(id error){
            if (completion) {
                completion(nil,error);
            }
        })
        .execute();
    }];
}


-(void)getMyCommunityRank:(NSDictionary*) param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot,@"front/community/getMyCommunityRank"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                NSDictionary* dataDict = tempDic[@"data"];
                if (dataDict) {
                    NSDictionary* communityRankList = dataDict[@"myCommunityRank"];
                    if (communityRankList) {
                        completion(communityRankList,nil);
                    }else{
                        completion(nil,nil);
                    }
                }
            }else{
                [NotifyHelper showMessageWithMakeText:tempDic[@"msg"]];
            }
        }).failure(^(id error){
            if (completion) {
//                completion(nil,error);
            }
        })
        .execute();
    }];
}


-(void)updateComNickName:(NSDictionary*) param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot,@"front/community/updateComNickName"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                [NotifyHelper showMessageWithMakeText:tempDic[@"msg"]];
            }
        }).failure(^(id error){
            if (completion) {
                
            }
        })
        .execute();
    }];
}

- (void)applyCommunity:(NSString *)nickName completion:(CompletionBlock)completion {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot,@"front/community/applyCommunity"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(@{@"nickname":nickName ?: @""})
        .finish(^(id data){
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                [NotifyHelper showMessageWithMakeText:tempDic[@"msg"]];
            }else{
                [NotifyHelper showMessageWithMakeText:tempDic[@"msg"]];
            }
            Block_Exec(completion,data);
        }).failure(^(id error) {
            Block_Exec(completion,nil);
        })
        .execute();
    }];
}

- (void)getMyCommunityInfo:(CompletionBlock)completion {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot,@"front/community/getMyCommunityInfo"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(nil)
        .finish(^(id data){
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                Block_Exec(completion,data);
            }else{
                [NotifyHelper showMessageWithMakeText:tempDic[@"msg"]];
            }
        }).failure(^(id error){
        })
        .execute();
    }];
}
@end
