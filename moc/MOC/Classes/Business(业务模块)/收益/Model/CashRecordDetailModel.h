//
//  CashRecordDetailModel.h
//  XZF
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CashRecordDetailModel : BaseObject

@property (nonatomic,copy) NSString* cash_detail_id;

@property (nonatomic,copy) NSString* cash_id;

@property (nonatomic,copy) NSString* cash_status;

@property (nonatomic,copy) NSString* note;

@property (nonatomic,copy) NSString* cre_date;
@end

NS_ASSUME_NONNULL_END
