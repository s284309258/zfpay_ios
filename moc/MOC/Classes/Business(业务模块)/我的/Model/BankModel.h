//
//  BankModel.h
//  XZF
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankModel : BaseObject

@property (nonatomic, copy) NSString* bank_code;

@property (nonatomic, copy) NSString* bank_name;

@property (nonatomic, copy) NSString* id;


@end

NS_ASSUME_NONNULL_END
