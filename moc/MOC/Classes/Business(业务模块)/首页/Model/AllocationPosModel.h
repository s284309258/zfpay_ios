//
//  AllocationPosModel.h
//  XZF
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllocationPosModel : BaseObject

@property (nonatomic ,copy) NSString* allocation_id;

@property (nonatomic ,copy) NSString* card_no;

@property (nonatomic ,copy) NSString* sn;

@property (nonatomic ,copy) NSString* real_name;

@property (nonatomic ,copy) NSString* cre_datetime;

@end

NS_ASSUME_NONNULL_END
