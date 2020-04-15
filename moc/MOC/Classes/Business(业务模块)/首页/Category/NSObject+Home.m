//
//  NSObject+Home.m
//  MOC
//
//  Created by mac on 2019/6/22.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "NSObject+Home.h"
#import "ItemModel.h"
#import "NoticeModel.h"
#import "NewsListModel.h"
#import "ScanTraditionalPosModel.h"
#import "ApplyScanRecordModel.h"
#import "MPosModel.h"
#import "TraditionalPosActivityModel.h"
#import "PosRewardModel.h"
#import "TraditionalPosActivityApplyModel.h"
#import "PosActivityApplyDetailModel.h"
#import "PosOnlineActivityModel.h"
#import "ScanTraditionalPosModel.h"
#import "PosActivityRewardModel.h"
#import "PosAllocationModel.h"
#import "RefererAgencyModel.h"
#import "UnbindRecordModel.h"
#import "AllocationPosModel.h"
#import "AppImgModel.h"
#import "AllocationPosDetailModel.h"
#import "ApplyRateModel.h"
#import "ApplyRateRecordModel.h"
#import "MerchantPosModel.h"
#import "PosDetailModel.h"
#import "RefererAgencyModel.h"
#import "ReferAgencyPosModel.h"
#import "MoneyLockerCollegeModel.h"
#import "MoneyLockerCollegeDetailModel.h"
#import "PosInputInquiryModel.h"
#import "PosInstallDetailModel.h"
#import "ReferAgencyNumModel.h"
#import "AllocationPosBatchModel.h"
#import "PolicyRecordModel.h"
#import "PosTradeModel.h"
@implementation NSObject (Home)

- (void)getAppImgList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/appImg/getAppImgList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.appImgList"];
                NSArray * array = [AppImgModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
//            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}
- (void)getNewNotice:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/notice/getNewNotice",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* noticeInfoList = [dict valueForKeyPath:@"data.noticeInfoList"];
                NSArray * dataArray = [NoticeModel modelListParseWithArray:noticeInfoList];
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

- (void)getNewNews:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/news/getNewNews",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.newsInfoList"];
                NSArray * array = [NewsListModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getNewsDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/news/getNewsDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* newsInfo = [dict valueForKeyPath:@"data.newsInfo"];
                NewsListModel * dataArray = [NewsListModel modelParseWithDict:newsInfo];
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

- (void)feedback_save:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/feedback/save",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if (![dict[@"code"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)getScanTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/traditionalpos/getScanTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.scanTraditionalPosList"];
                NSArray * array = [ScanTraditionalPosModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)addApplyScanRecord:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/traditionalpos/addApplyScanRecord",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)getApplyScanRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/traditionalpos/getApplyScanRecordList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.applyScanRecordList"];
                NSArray * array = [ApplyScanRecordModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/mpos/getMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.mposList"];
                NSArray * array = [MPosModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)editMposMerInfo:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/mpos/editMposMerInfo",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)updateMerchantNameAndTel:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/updateMerchantNameAndTel",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)getTraditionalPosOnlineActivityList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/getTraditionalPosOnlineActivityList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.traditionalPosOnlineActivityList"];
                NSArray * array = [TraditionalPosActivityModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}
- (void)getMposOnlineActivityList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/getMposOnlineActivityList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.mposOnlineActivityList"];
                NSArray * array = [TraditionalPosActivityModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getTraditionalPosRewardRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/getTraditionalPosRewardRecordList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.traditionalPosRewardRecordList"];
                NSArray * array = [PosRewardModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getMposRewardRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/getMposRewardRecordList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.mposRewardRecordList"];
                NSArray * array = [PosRewardModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getTraditionalPosActivityApplyList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/getTraditionalPosActivityApplyList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.traditionalPosActivityApplyList"];
                NSArray * array = [TraditionalPosActivityApplyModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getMposActivityApplyList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/getMposActivityApplyList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.mposActivityApplyList"];
                NSArray * array = [TraditionalPosActivityApplyModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getTraditionalPosActivityApplyDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/getTraditionalPosActivityApplyDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dataArray = [dict valueForKeyPath:@"data.traditionalPosActivityApply"];
                PosActivityApplyDetailModel * array = [PosActivityApplyDetailModel modelParseWithDict:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getMposActivityApplyDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/getMposActivityApplyDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dataArray = [dict valueForKeyPath:@"data.mposActivityApply"];
                PosActivityApplyDetailModel * array = [PosActivityApplyDetailModel modelParseWithDict:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

-(void)getTraditionalPosOnlineActivityDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/getTraditionalPosOnlineActivityDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dataArray = [dict valueForKeyPath:@"data.traditionalPosOnlineActivity"];
                PosOnlineActivityModel * array = [PosOnlineActivityModel modelParseWithDict:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

-(void)getMposOnlineActivityDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/getMposOnlineActivityDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dataArray = [dict valueForKeyPath:@"data.mposOnlineActivity"];
                PosOnlineActivityModel * array = [PosOnlineActivityModel modelParseWithDict:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

//查询参与活动选择信息（传统POS）
- (void)getTraditionalPosPartActivityInfo:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/getTraditionalPosPartActivityInfo",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* traditionalPosList = [dict valueForKeyPath:@"data.traditionalPosList"];
                NSArray* traditionalPosActivityRewardList = [dict valueForKeyPath:@"data.traditionalPosActivityRewardList"];
                traditionalPosList = [ScanTraditionalPosModel modelListParseWithArray:traditionalPosList];
                traditionalPosActivityRewardList = [PosActivityRewardModel modelListParseWithArray:traditionalPosActivityRewardList];
                completion(@[traditionalPosList,traditionalPosActivityRewardList],nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

//查询参与活动选择信息（MPOS）
- (void)getMposPartActivityInfo:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/getMposPartActivityInfo",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* mposList = [dict valueForKeyPath:@"data.mposList"];
                NSArray* mposActivityRewardList = [dict valueForKeyPath:@"data.mposActivityRewardList"];
                mposList = [ScanTraditionalPosModel modelListParseWithArray:mposList];
                mposActivityRewardList = [PosActivityRewardModel modelListParseWithArray:mposActivityRewardList];
                completion(@[mposList,mposActivityRewardList],nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)submitTraditionalPosActivityApply:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/submitTraditionalPosActivityApply",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)submitMposActivityApply:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/submitMposActivityApply",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)cancelTraditionalPosActivityApply:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/cancelTraditionalPosActivityApply",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)cancelMposActivityApply:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/onlineactivity/cancelMposActivityApply",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)getTraditionalPosAllocationList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getTraditionalPosAllocationList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.traditionalPosAllocationList"];
                NSArray * array = [PosAllocationModel modelListParseWithArray:dataArray];
                
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getMposAllocationList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getMposAllocationList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.mposAllocationList"];
                NSArray * array = [PosAllocationModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getTrafficCardAllocationList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getTrafficCardAllocationList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.trafficCardAllocationList"];
                NSArray * array = [PosAllocationModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getTraditionalPosRecallList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getTraditionalPosRecallList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.traditionalPosRecallList"];
                NSArray * array = [PosAllocationModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}


- (void)getMposRecallList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getMposRecallList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.mposRecallList"];
                NSArray * array = [PosAllocationModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}


- (void)getTrafficCardRecallList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getTrafficCardRecallList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.trafficCardRecallList"];
                NSArray * array = [PosAllocationModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getRefererAgency:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getRefererAgency",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.refererAgencyList"];
                NSArray * array = [RefererAgencyModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getTraditionalPosSysParamRateList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getTraditionalPosSysParamRateList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* weixin_settle_price_list = [dict valueForKeyPath:@"data.traditionalPosSysParamRate.weixin_settle_price_list"];
                NSArray* single_profit_rate_list = [dict valueForKeyPath:@"data.traditionalPosSysParamRate.single_profit_rate_list"];
                NSArray* cloud_settle_price_list = [dict valueForKeyPath:@"data.traditionalPosSysParamRate.cloud_settle_price_list"];
                NSArray* cash_back_rate_list = [dict valueForKeyPath:@"data.traditionalPosSysParamRate.cash_back_rate_list"];
                NSArray* zhifubao_settle_price_list = [dict valueForKeyPath:@"data.traditionalPosSysParamRate.zhifubao_settle_price_list"];
                NSArray* card_settle_price_list = [dict valueForKeyPath:@"data.traditionalPosSysParamRate.card_settle_price_list"];
                NSArray* mer_cap_fee_list = [dict valueForKeyPath:@"data.traditionalPosSysParamRate.mer_cap_fee_list"];
                NSArray* card_settle_price_vip_list = [dict valueForKeyPath:@"data.traditionalPosSysParamRate.card_settle_price_vip_list"];
                NSString* is_reward = [dict valueForKeyPath:@"data.traditionalPosSysParamRate.is_reward"];
                
                         if ([StringUtil isEmpty:is_reward]) {
                             is_reward = @"";
                         }
                if (!card_settle_price_vip_list) {
                    card_settle_price_vip_list = @[];
                }
                completion(@[weixin_settle_price_list,single_profit_rate_list,cloud_settle_price_list,cash_back_rate_list,zhifubao_settle_price_list,card_settle_price_list,mer_cap_fee_list,card_settle_price_vip_list],is_reward);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getMposSysParamRateList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getMposSysParamRateList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* single_profit_rate_list = [dict valueForKeyPath:@"data.mposSysParamRate.single_profit_rate_list"];
                NSArray* cloud_settle_price_list = [dict valueForKeyPath:@"data.mposSysParamRate.cloud_settle_price_list"];
                NSArray* cash_back_rate_list = [dict valueForKeyPath:@"data.mposSysParamRate.cash_back_rate_list"];
                NSArray* card_settle_price_list = [dict valueForKeyPath:@"data.mposSysParamRate.card_settle_price_list"];
                NSString* is_reward = [dict valueForKeyPath:@"data.mposSysParamRate.is_reward"];
                         
                if ([StringUtil isEmpty:is_reward]) {
                    is_reward = @"";
                } completion(@[single_profit_rate_list,cloud_settle_price_list,cash_back_rate_list,card_settle_price_list],is_reward);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)allocationTraditionalPos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/allocationTraditionalPos",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)allocationMpos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/allocationMpos",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)allocationTrafficCard:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/allocationTrafficCard",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)recallTraditionalPos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/recallTraditionalPos",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)recallMpos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/recallMpos",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)recallTrafficCard:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/recallTrafficCard",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}


-(void)unbindTraditionalPos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/unbindTraditionalPos",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}


-(void)unbindMpos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/unbindMpos",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

//查询解绑记录（传统POS）
- (void)getTraditionalPosUnbindRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getTraditionalPosUnbindRecordList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* traditionalPosUnbindRecordList = [dict valueForKeyPath:@"data.traditionalPosUnbindRecordList"];
                NSArray* tmpArray = [UnbindRecordModel modelListParseWithArray:traditionalPosUnbindRecordList];
                completion(tmpArray,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

//查询解绑记录（MPOS）
- (void)getMposUnbindRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getMposUnbindRecordList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dict = (NSDictionary*)data;
                if ([dict[@"success"] boolValue]) {
                    NSArray* mposUnbindRecordList = [dict valueForKeyPath:@"data.mposUnbindRecordList"];
                    NSArray* tmpArray = [UnbindRecordModel modelListParseWithArray:mposUnbindRecordList];
                    completion(tmpArray,nil);
                }else{
                    completion(nil,nil);
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

- (void)getAllocationTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getAllocationTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dict = (NSDictionary*)data;
                if ([dict[@"success"] boolValue]) {
                    NSArray* mposUnbindRecordList = [dict valueForKeyPath:@"data.allocationTraditionalPosList"];
                    NSArray* tmpArray = [AllocationPosModel modelListParseWithArray:mposUnbindRecordList];
                    completion(tmpArray,nil);
                }else{
                    completion(nil,nil);
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

- (void)getAllocationMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getAllocationMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dict = (NSDictionary*)data;
                if ([dict[@"success"] boolValue]) {
                    NSArray* allocationMposList = [dict valueForKeyPath:@"data.allocationMposList"];
                    NSArray* tmpArray = [AllocationPosModel modelListParseWithArray:allocationMposList];
                    completion(tmpArray,nil);
                }else{
                    completion(nil,nil);
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

- (void)selectPosBatchAllocate:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/selectPosBatchAllocate",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dict = (NSDictionary*)data;
                if ([dict[@"success"] boolValue]) {
                    NSArray* allocationMposList = [dict valueForKeyPath:@"data.allocateList"];
                    NSArray* tmpArray = [AllocationPosBatchModel modelListParseWithArray:allocationMposList];
                    completion(tmpArray,nil);
                }else{
                    completion(nil,nil);
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

- (void)getAllocationTrafficCardList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getAllocationTrafficCardList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dict = (NSDictionary*)data;
                if ([dict[@"success"] boolValue]) {
                    NSArray* allocationMposList = [dict valueForKeyPath:@"data.allocationTrafficCardList"];
                    NSArray* tmpArray = [AllocationPosModel modelListParseWithArray:allocationMposList];
                    completion(tmpArray,nil);
                }else{
                    completion(nil,nil);
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
//修改分配记录（传统POS）
- (void)editAllocationTraditionalPos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/editAllocationTraditionalPos",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

//修改分配记录（MPOS）
- (void)editAllocationMpos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/editAllocationMpos",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)editAllocationMPosBatch:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/editAllocationMPosBatch",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)editAllocationTraditionalPosBatch:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/editAllocationTraditionalPosBatch",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}



//查询分配详情（传统POS）
-(void)getAllocationTraditionalPosDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getAllocationTraditionalPosDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* detailDict = [dict valueForKeyPath:@"data.allocationTraditionalPos"];
                AllocationPosDetailModel * model = [AllocationPosDetailModel modelParseWithDict:detailDict];
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
//查询分配详情（MPOS）
-(void)getAllocationMposDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getAllocationMposDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* detailDict = [dict valueForKeyPath:@"data.allocationMpos"];
                AllocationPosDetailModel * model = [AllocationPosDetailModel modelParseWithDict:detailDict];
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

-(void)selectPosSettlePriceBySN:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/selectPosSettlePriceBySN",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* detailDict = [dict valueForKeyPath:@"data.allocationPos"];
                AllocationPosDetailModel * model = [AllocationPosDetailModel modelParseWithDict:detailDict];
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

- (void)getRecallTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getRecallTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dict = (NSDictionary*)data;
                if ([dict[@"success"] boolValue]) {
                    NSArray* allocationMposList = [dict valueForKeyPath:@"data.recallTraditionalPosList"];
                    NSArray* tmpArray = [ScanTraditionalPosModel modelListParseWithArray:allocationMposList];
                    completion(tmpArray,nil);
                }else{
                    completion(nil,nil);
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

- (void)dealRecallTraditionalPos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/dealRecallTraditionalPos",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)getRecallMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getRecallMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dict = (NSDictionary*)data;
                if ([dict[@"success"] boolValue]) {
                    NSArray* allocationMposList = [dict valueForKeyPath:@"data.recallMposList"];
                    NSArray* tmpArray = [ScanTraditionalPosModel modelListParseWithArray:allocationMposList];
                    completion(tmpArray,nil);
                }else{
                    completion(nil,nil);
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

- (void)dealRecallMpos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/dealRecallMpos",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}


- (void)getRecallTrafficCardList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/getRecallTrafficCardList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dict = (NSDictionary*)data;
                if ([dict[@"success"] boolValue]) {
                    NSArray* allocationMposList = [dict valueForKeyPath:@"data.recallTrafficCardList"];
                    NSArray* tmpArray = [ScanTraditionalPosModel modelListParseWithArray:allocationMposList];
                    completion(tmpArray,nil);
                }else{
                    completion(nil,nil);
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


- (void)dealRecallTrafficCard:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/dealRecallTrafficCard",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)getApplyRateTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/creditcardratesapply/getApplyRateTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dict = (NSDictionary*)data;
                if ([dict[@"success"] boolValue]) {
                    NSArray* allocationMposList = [dict valueForKeyPath:@"data.applyRateTraditionalPosList"];
                    NSArray* tmpArray = [ApplyRateModel modelListParseWithArray:allocationMposList];
                    completion(tmpArray,nil);
                }else{
                    completion(nil,nil);
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

- (void)getApplyRateMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/creditcardratesapply/getApplyRateMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dict = (NSDictionary*)data;
                if ([dict[@"success"] boolValue]) {
                    NSArray* allocationMposList = [dict valueForKeyPath:@"data.applyRateMposList"];
                    NSArray* tmpArray = [ApplyRateModel modelListParseWithArray:allocationMposList];
                    completion(tmpArray,nil);
                }else{
                    completion(nil,nil);
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

- (void)getCreditCardRateList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/creditcardratesapply/getCreditCardRateList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dict = (NSDictionary*)data;
                if ([dict[@"success"] boolValue]) {
                    NSArray* creditCardRateList = [dict valueForKeyPath:@"data.creditCardRateList"];
                    completion(creditCardRateList,nil);
                }else{
                    completion(nil,nil);
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

- (void)addApplyRateTraditionalPos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/creditcardratesapply/addApplyRateTraditionalPos",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)addApplyRateMpos:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/creditcardratesapply/addApplyRateMpos",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

- (void)getApplyRateTraditionalPosRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/creditcardratesapply/getApplyRateTraditionalPosRecordList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dict = (NSDictionary*)data;
                if ([dict[@"success"] boolValue]) {
                    NSArray* applyRateTraditionalPosRecordList = [dict valueForKeyPath:@"data.applyRateTraditionalPosRecordList"];
                    NSArray* dataArray = [ApplyRateRecordModel modelListParseWithArray:applyRateTraditionalPosRecordList];
                    completion(dataArray,nil);
                }else{
                    completion(nil,nil);
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

- (void)getApplyRateMposRecordList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/creditcardratesapply/getApplyRateMposRecordList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dict = (NSDictionary*)data;
                if ([dict[@"success"] boolValue]) {
                    NSArray* applyRateMposRecordList = [dict valueForKeyPath:@"data.applyRateMposRecordList"];
                    NSArray* dataArray = [ApplyRateRecordModel modelListParseWithArray:applyRateMposRecordList];
                    completion(dataArray,nil);
                }else{
                    completion(nil,nil);
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

- (void)getSummaryTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getSummaryTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* data = [dict valueForKeyPath:@"data"];
                completion(data,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getSummaryMposList:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getSummaryMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* data = [dict valueForKeyPath:@"data"];
                completion(data,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getAllMerchantTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getAllMerchantTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                    NSArray* allMerchantMposList = [dict valueForKeyPath:@"data.allMerchantTraditionalPosList"];
                    NSArray* dataArray = [MerchantPosModel modelListParseWithArray:allMerchantMposList];
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
- (void)getExcellentMerchantTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getExcellentMerchantTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                    NSArray* allMerchantMposList = [dict valueForKeyPath:@"data.excellentMerchantTraditionalPosList"];
                    NSArray* dataArray = [MerchantPosModel modelListParseWithArray:allMerchantMposList];
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
- (void)getActiveMerchantTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getActiveMerchantTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                    NSArray* allMerchantMposList = [dict valueForKeyPath:@"data.activeMerchantTraditionalPosList"];
                    NSArray* dataArray = [MerchantPosModel modelListParseWithArray:allMerchantMposList];
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

- (void)getDormantMerchantTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getDormantMerchantTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                    NSArray* allMerchantMposList = [dict valueForKeyPath:@"data.dormantMerchantTraditionalPosList"];
                    NSArray* dataArray = [MerchantPosModel modelListParseWithArray:allMerchantMposList];
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


- (void)getAllMerchantMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getAllMerchantMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                    NSArray* allMerchantMposList = [dict valueForKeyPath:@"data.allMerchantMposList"];
                    NSArray* dataArray = [MerchantPosModel modelListParseWithArray:allMerchantMposList];
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

- (void)getExcellentMerchantMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getExcellentMerchantMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                    NSArray* allMerchantMposList = [dict valueForKeyPath:@"data.excellentMerchantMposList"];
                    NSArray* dataArray = [MerchantPosModel modelListParseWithArray:allMerchantMposList];
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


- (void)getActiveMerchantMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getActiveMerchantMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                    NSArray* allMerchantMposList = [dict valueForKeyPath:@"data.activeMerchantMposList"];
                    NSArray* dataArray = [MerchantPosModel modelListParseWithArray:allMerchantMposList];
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

- (void)getDormantMerchantMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getDormantMerchantMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                    NSArray* allMerchantMposList = [dict valueForKeyPath:@"data.dormantMerchantMposList"];
                    NSArray* dataArray = [MerchantPosModel modelListParseWithArray:allMerchantMposList];
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


- (void)getTraditionalPosDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getTraditionalPosDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                    NSDictionary* allMerchantMposList = [dict valueForKeyPath:@"data.traditionalPosDetail"];
                    PosDetailModel* model = [PosDetailModel modelParseWithDict:allMerchantMposList];
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


- (void)getMposDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getMposDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* allMerchantMposList = [dict valueForKeyPath:@"data.mposDetail"];
                PosDetailModel* model = [PosDetailModel modelParseWithDict:allMerchantMposList];
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

- (void)getReferAgencyList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getReferAgencyList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* allMerchantMposList = [dict valueForKeyPath:@"data.referAgencyList"];
                NSArray* dataArray = [RefererAgencyModel modelListParseWithArray:allMerchantMposList];
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

- (void)getReferAgencyNum:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getReferAgencyNum",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                ReferAgencyNumModel* model = [ReferAgencyNumModel modelParseWithDict:dict[@"data"]];
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

- (void)getReferAgencyHeadTraditionalPosInfo:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getReferAgencyHeadTraditionalPosInfo",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                ReferAgencyNumModel* model = [ReferAgencyNumModel modelParseWithDict:[dict valueForKeyPath:@"data.referAgencyHeadTraditionalPosInfo"]];
//                NSDictionary* pos_dict = [dict valueForKeyPath:@"data.referAgencyHeadTraditionalPosInfo"];
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

- (void)getReferAgencyTraditionalPosList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getReferAgencyTraditionalPosList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* allMerchantMposList = [dict valueForKeyPath:@"data.referAgencyTraditionalPosList"];
                NSArray* dataArray = [ReferAgencyPosModel modelListParseWithArray:allMerchantMposList];
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
- (void)getReferAgencyHeadMposInfo:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getReferAgencyHeadMposInfo",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                ReferAgencyNumModel* model = [ReferAgencyNumModel modelParseWithDict:[dict valueForKeyPath:@"data.referAgencyHeadMposInfo"]];
//                NSDictionary* pos_dict = [dict valueForKeyPath:@"data.referAgencyHeadTraditionalPosInfo"];
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

- (void)getReferAgencyMposList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getReferAgencyMposList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* allMerchantMposList = [dict valueForKeyPath:@"data.referAgencyMposList"];
                NSArray* dataArray = [ReferAgencyPosModel modelListParseWithArray:allMerchantMposList];
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

- (void)getMoneyLockerCollegeList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/moneylockercollege/getMoneyLockerCollegeList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* moneyLockerCollegeList = [dict valueForKeyPath:@"data.moneyLockerCollegeList"];
                NSArray* dataArray = [MoneyLockerCollegeModel modelListParseWithArray:moneyLockerCollegeList];
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

- (void)getMoneyLockerCollegeDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/moneylockercollege/getMoneyLockerCollegeDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* moneyLockerCollege = [dict valueForKeyPath:@"data.moneyLockerCollege"];
                MoneyLockerCollegeDetailModel* model = [MoneyLockerCollegeDetailModel modelParseWithDict:moneyLockerCollege];
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

- (void)getTraditionalPosInstallList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/interface/zfback/getTraditionalPosInstallList",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* allMerchantMposList = [dict valueForKeyPath:@"data.traditionalPosInstallList"];
                NSArray* dataArray = [PosInputInquiryModel modelListParseWithArray:allMerchantMposList];
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

- (void)getTraditionalPosInstallDetail:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/interface/zfback/getTraditionalPosInstallDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                PosInstallDetailModel* pos_dict =  [PosInstallDetailModel modelParseWithDict:[dict valueForKeyPath:@"data.traditionalPosInstallDetail"]];
                pos_dict.terminalList = [dict valueForKeyPath:@"data.terminalList"];
                completion(pos_dict,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

-(void)selectPolicy3Record:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/selectPolicy3Record",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* machinesPolicy3Record = [dict valueForKeyPath:@"data.machinesPolicy3Record"];
                NSArray* dataArray = [PolicyRecordModel modelListParseWithArray:machinesPolicy3Record];
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

-(void)chooseAward:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/chooseAward",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if (![dict[@"code"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
            [NotifyHelper showMessageWithMakeText:dict[@"msg"]];
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}


-(void)selectUnbindTraditionalPos:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/selectUnbindTraditionalPos",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.traditionalPosUnbindList"];
                NSArray * array = [PosAllocationModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}


-(void)selectUnbindMpos:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/machinesmanage/selectUnbindMpos",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.mposUnbindList"];
                NSArray * array = [PosAllocationModel modelListParseWithArray:dataArray];
                completion(array,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

-(void)getUnReadNews:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/notice/getUnReadNews",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSDictionary* dataDict = [dict valueForKeyPath:@"data"];
                completion(dataDict,nil);
            }else{
                completion(nil,nil);
            }
            
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}
/*
 消息类型    news_type
 已读标志    read_flag
 */
-(void)updateNewsReadFlag:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/notice/updateNewsReadFlag",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(YES,nil);
            }else{
                completion(NO,nil);
            }
        }).failure(^(id error){
            completion(NO,nil);
        })
        .execute();
    }];
}

-(void)getReferAgencyTraditionalPosTradeAmountAvg:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getReferAgencyTraditionalPosTradeAmountAvg",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(dict[@"data"],nil);
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

-(void)getReferAgencyMPosTradeAmountAvg:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getReferAgencyMPosTradeAmountAvg",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                completion(dict[@"data"],nil);
            }else{
                completion(nil,nil);
            }
        }).failure(^(id error){
            completion(nil,nil);
        })
        .execute();
    }];
}

- (void)getTraditionalPosTradeDetail:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion{
    NSString *url = [NSString stringWithFormat:@"%@/api/sys/merchant/getTraditionalPosTradeDetail",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(param)
        .finish(^(id data){
            NSDictionary* dict = (NSDictionary*)data;
            if ([dict[@"success"] boolValue]) {
                NSArray* dataArray = [dict valueForKeyPath:@"data.traditionalPosTradeDetail"];
                NSArray * array = [PosTradeModel modelListParseWithArray:dataArray];
                completion(array,nil);
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
