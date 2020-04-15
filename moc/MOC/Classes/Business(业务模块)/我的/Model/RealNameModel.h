//
//  RealNameModel.h
//  XZF
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RealNameModel : BaseObject
/*
 认证状态
 00—待认证
 04—待审核
 08—认证失败
 09—认证成功
 */
@property (nonatomic, copy) NSString* auth_status;

@property (nonatomic, copy) NSString* real_name;

@property (nonatomic, copy) NSString* id_card;

@property (nonatomic, copy) NSString* card_photo;

@property (nonatomic, copy) NSString* auth_remark;

@property (nonatomic, copy) NSString* tradeAmountAll;

@property (nonatomic, copy) NSString* tradeAmountDay;

@end

NS_ASSUME_NONNULL_END
