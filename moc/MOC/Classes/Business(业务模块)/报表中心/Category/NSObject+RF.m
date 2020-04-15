//
//  NSObject+Business.m
//  MOC
//
//  Created by mac on 2019/6/22.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "NSObject+RF.h"
#import "RFPosDetailModel.h"
@implementation NSObject (RF)

- (void)getHomePageInfo:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getHomePageInfo",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                
                NSDictionary* traposDetail = [dict valueForKeyPath:@"data.traposDetail"];
                RFPosDetailModel* trapos = [RFPosDetailModel modelParseWithDict:traposDetail];
                NSDictionary* mposDetail = [dict valueForKeyPath:@"data.mposDetail"];
                RFPosDetailModel* mpos = [RFPosDetailModel modelParseWithDict:mposDetail];
                NSDictionary* eposDetail = [dict valueForKeyPath:@"data.eposDetail"];
                RFPosDetailModel* epos = [RFPosDetailModel modelParseWithDict:eposDetail];
                if (trapos && mpos && epos) {
                    completion(@[trapos,mpos,epos],nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getDayAgencyTraditionalPosDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getDayAgencyTraditionalPosDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* traposDetail = [dict valueForKeyPath:@"data.dayAgencyTraditionalPosDetail"];
                RFPosDetailModel* trapos = [RFPosDetailModel modelParseWithDict:traposDetail];
                if (trapos) {
                    completion(trapos,nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getMonthAgencyTraditionalPosDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getMonthAgencyTraditionalPosDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* traposDetail = [dict valueForKeyPath:@"data.monthAgencyTraditionalPosDetail"];
                RFPosDetailModel* trapos = [RFPosDetailModel modelParseWithDict:traposDetail];
                if (trapos) {
                    completion(trapos,nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getDayMerchantTraditionalPosDetail:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getDayMerchantTraditionalPosDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* traposDetail = [dict valueForKeyPath:@"data.dayMerchantTraditionalPosDetail"];
                RFPosDetailModel* trapos = [RFPosDetailModel modelParseWithDict:traposDetail];
                if (trapos) {
                    completion(trapos,nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getMonthMerchantTraditionalPosDetail:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getMonthMerchantTraditionalPosDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* traposDetail = [dict valueForKeyPath:@"data.monthMerchantTraditionalPosDetail"];
                RFPosDetailModel* trapos = [RFPosDetailModel modelParseWithDict:traposDetail];
                if (trapos) {
                    completion(trapos,nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}



//4个接口

- (void)getDayAgencyTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getDayAgencyTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dayAgencyTraditionalPosList = [dict valueForKeyPath:@"data.dayAgencyTraditionalPosList"];
                NSArray* array = [RFPosDetailModel modelListParseWithArray:dayAgencyTraditionalPosList];
                if (array) {
                    completion(array,nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getMonthAgencyTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getMonthAgencyTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dayAgencyTraditionalPosList = [dict valueForKeyPath:@"data.monthAgencyTraditionalPosList"];
                NSArray* array = [RFPosDetailModel modelListParseWithArray:dayAgencyTraditionalPosList];
                if (array) {
                    completion(array,nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}


- (void)getDayAgencyMposDetail:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getDayAgencyMposDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* traposDetail = [dict valueForKeyPath:@"data.dayAgencyMposDetail"];
                RFPosDetailModel* trapos = [RFPosDetailModel modelParseWithDict:traposDetail];
                if (trapos) {
                    completion(trapos,nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}


- (void)getMonthAgencyMposDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getMonthAgencyMposDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* traposDetail = [dict valueForKeyPath:@"data.monthAgencyMposDetail"];
                RFPosDetailModel* trapos = [RFPosDetailModel modelParseWithDict:traposDetail];
                if (trapos) {
                    completion(trapos,nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}


- (void)getDayMerchantTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getDayMerchantTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                
                NSArray* dayMerchantTraditionalPosList = [dict valueForKeyPath:@"data.dayMerchantTraditionalPosList"];
                NSArray* trapos = [RFPosDetailModel modelListParseWithArray:dayMerchantTraditionalPosList];
                if (trapos ) {
                    completion(trapos,nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getMonthMerchantTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getMonthMerchantTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                
                NSArray* dayMerchantTraditionalPosList = [dict valueForKeyPath:@"data.monthMerchantTraditionalPosList"];
                NSArray* trapos = [RFPosDetailModel modelListParseWithArray:dayMerchantTraditionalPosList];
                if (trapos ) {
                    completion(trapos,nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getDayMerchantMposDetail:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getDayMerchantMposDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* traposDetail = [dict valueForKeyPath:@"data.dayMerchantMposDetail"];
                RFPosDetailModel* trapos = [RFPosDetailModel modelParseWithDict:traposDetail];
                if (trapos) {
                    completion(trapos,nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getMonthMerchantMposDetail:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getMonthMerchantMposDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* traposDetail = [dict valueForKeyPath:@"data.monthMerchantMposDetail"];
                RFPosDetailModel* trapos = [RFPosDetailModel modelParseWithDict:traposDetail];
                if (trapos) {
                    completion(trapos,nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getDayAgencyMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getDayAgencyMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dayMerchantTraditionalPosList = [dict valueForKeyPath:@"data.dayAgencyMposList"];
                NSArray* trapos = [RFPosDetailModel modelListParseWithArray:dayMerchantTraditionalPosList];
                if (trapos) {
                    completion(trapos,nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getMonthAgencyMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getMonthAgencyMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dayMerchantTraditionalPosList = [dict valueForKeyPath:@"data.monthAgencyMposList"];
                NSArray* trapos = [RFPosDetailModel modelListParseWithArray:dayMerchantTraditionalPosList];
                if (trapos) {
                    completion(trapos,nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getDayMerchantMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getDayMerchantMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dayMerchantTraditionalPosList = [dict valueForKeyPath:@"data.dayMerchantMposList"];
                NSArray* trapos = [RFPosDetailModel modelListParseWithArray:dayMerchantTraditionalPosList];
                if (trapos) {
                    completion(trapos,nil);
                }
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getMonthMerchantMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/reportforms/getMonthMerchantMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dayMerchantTraditionalPosList = [dict valueForKeyPath:@"data.monthMerchantMposList"];
                NSArray* trapos = [RFPosDetailModel modelListParseWithArray:dayMerchantTraditionalPosList];
                if (trapos) {
                    completion(trapos,nil);
                }
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
