//
//  PosInputInquiryModel.h
//  XZF
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PosInputInquiryModel : BaseObject

@property (nonatomic,strong) NSString* install_id;

@property (nonatomic,strong) NSString* merchant_name;

@property (nonatomic,strong) NSString* mer_code;

@property (nonatomic,strong) NSString* biz_msg;

@property (nonatomic,strong) NSString* cre_datetime;

@end

NS_ASSUME_NONNULL_END
