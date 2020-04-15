//
//  CashRecordModel.m
//  XZF
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "CashRecordModel.h"

@implementation CashRecordModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"cashRecordDetailList" : CashRecordDetailModel.class};
}

@end
