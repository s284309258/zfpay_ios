//
//  MessageRecordModel.h
//  XZF
//
//  Created by mac on 2019/9/5.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageRecordModel : BaseObject

@property (nonatomic, copy) NSString* message_id;

@property (nonatomic, copy) NSString* money;

@property (nonatomic, copy) NSString* cre_datetime;

@end

NS_ASSUME_NONNULL_END
