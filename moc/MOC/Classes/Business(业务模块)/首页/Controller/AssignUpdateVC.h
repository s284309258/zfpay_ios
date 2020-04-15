//
//  AssignUpdateVC.h
//  XZF
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseViewController.h"
#import "AllocationPosBatchModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    MAssigType ,
    CTAssignType,
    EAssignType
} AssignUpdateType;

@interface AssignUpdateVC : BaseViewController

@property (nonatomic,strong) AllocationPosBatchModel *batchModel;

@property (nonatomic) NSInteger type;


@end

NS_ASSUME_NONNULL_END
