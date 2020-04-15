//
//  NSObject+ProfitHelper.m
//  XZF
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "NSObject+Profit.h"
#import "UserPurseInfoModel.h"
#import "ProfitHeaderInfo.h"
#import "PosBenefitDetailModel.h"
#import "ShareBenefitPosModel.h"
#import "MachineBackPosModel.h"
@implementation NSObject (Profit)

- (void)getUserNewInfo:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/user/info/getUserNewInfo",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).useEncrypt().params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dataDict = [dict valueForKeyPath:@"data.userNewInfo"];
                UserPurseInfoModel * model = [UserPurseInfoModel modelParseWithDict:dataDict];
                completion(model,nil);
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getHeaderInformation:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/benefitcentre/getHeaderInformation",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dataDict = [dict valueForKeyPath:@"data.headerInfo"];
                ProfitHeaderInfo * model = [ProfitHeaderInfo modelParseWithDict:dataDict];
                completion(model,nil);
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}



- (void)getBenefitCentreEPosDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/benefitcentre/getBenefitCentreEposDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dataDict = [dict valueForKeyPath:@"data.traditionalPosBenefitDeatil"];
                PosBenefitDetailModel * model = [PosBenefitDetailModel modelParseWithDict:dataDict];
                completion(model,nil);
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getBenefitCentreTraditionalPosDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/benefitcentre/getBenefitCentreTraditionalPosDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dataDict = [dict valueForKeyPath:@"data.traditionalPosBenefitDeatil"];
                PosBenefitDetailModel * model = [PosBenefitDetailModel modelParseWithDict:dataDict];
                completion(model,nil);
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getBenefitCentreMposDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/benefitcentre/getBenefitCentreMposDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dataDict = [dict valueForKeyPath:@"data.traditionalPosBenefitDeatil"];
                if (!dataDict) {
                    dataDict = [dict valueForKeyPath:@"data.mposBenefitDeatil"];
                }
                PosBenefitDetailModel * model = [PosBenefitDetailModel modelParseWithDict:dataDict];
                completion(model,nil);
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}


- (void)getShareBenefitTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/benefitcentre/getShareBenefitTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* shareBenefitTraditionalPosList = [dict valueForKeyPath:@"data.shareBenefitTraditionalPosList"];
                NSArray* dataArray = [ShareBenefitPosModel modelListParseWithArray:shareBenefitTraditionalPosList];
                completion(dataArray,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}


- (void)getShareBenefitMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/benefitcentre/getShareBenefitMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* shareBenefitTraditionalPosList = [dict valueForKeyPath:@"data.shareBenefitMposList"];
                NSArray* dataArray = [ShareBenefitPosModel modelListParseWithArray:shareBenefitTraditionalPosList];
                completion(dataArray,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}


- (void)getMachineBackTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/benefitcentre/getMachineBackTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* shareBenefitTraditionalPosList = [dict valueForKeyPath:@"data.machineBackTraditionalPosList"];
                NSArray* dataArray = [MachineBackPosModel modelListParseWithArray:shareBenefitTraditionalPosList];
                completion(dataArray,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getMachineBackMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/benefitcentre/getMachineBackMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* shareBenefitTraditionalPosList = [dict valueForKeyPath:@"data.machineBackMposList"];
                NSArray* dataArray = [MachineBackPosModel modelListParseWithArray:shareBenefitTraditionalPosList];
                completion(dataArray,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}


- (void)getActivityRewardTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/benefitcentre/getActivityRewardTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* activityRewardTraditionalPosList = [dict valueForKeyPath:@"data.activityRewardTraditionalPosList"];
                NSArray* dataArray = [MachineBackPosModel modelListParseWithArray:activityRewardTraditionalPosList];
                completion(dataArray,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getActivityRewardMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/benefitcentre/getActivityRewardMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* activityRewardMposList = [dict valueForKeyPath:@"data.activityRewardMposList"];
                NSArray* dataArray = [MachineBackPosModel modelListParseWithArray:activityRewardMposList];
                completion(dataArray,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getDeductTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/benefitcentre/getDeductTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* activityRewardMposList = [dict valueForKeyPath:@"data.deductTraditionalPosList"];
                NSArray* dataArray = [MachineBackPosModel modelListParseWithArray:activityRewardMposList];
                completion(dataArray,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getDeductMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/benefitcentre/getDeductMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* activityRewardMposList = [dict valueForKeyPath:@"data.deductMposList"];
                NSArray* dataArray = [MachineBackPosModel modelListParseWithArray:activityRewardMposList];
                completion(dataArray,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}


@end
