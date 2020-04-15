//
//  ProfitHelper.h
//  XZF
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfitHelper : NSObject

+ (void)getUserCardList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion ;

+ (void)searchLikeBank:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion ;

+ (void)updateUserCard:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion ;

+ (void)getCashInfo:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion ;

+ (void)applyCash:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion ;

+ (void)getUserValidCardList:(NSDictionary*)param completion:(MXHttpRequestListCallBack)completion ;

+ (void)getCashRecordList:(NSDictionary*)param completion:(MXHttpRequestResultObjectCallBack)completion ;


@end

NS_ASSUME_NONNULL_END
