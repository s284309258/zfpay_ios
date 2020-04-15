//
//  ApplyScanRecordModel.h
//  XZF
//
//  Created by mac on 2019/8/30.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApplyScanRecordModel : BaseObject

@property (nonatomic, strong) NSString* record_id;

@property (nonatomic, strong) NSString* sn;

@property (nonatomic, strong) NSString* status;

@property (nonatomic, strong) NSString* cre_datetime;

@end

NS_ASSUME_NONNULL_END
