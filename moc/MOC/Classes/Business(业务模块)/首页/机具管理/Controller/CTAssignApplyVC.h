//
//  CTAssignApplyVC.h
//  XZF
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTAssignApplyVC : BaseViewController

@property (nonatomic,strong) NSMutableArray* dataArray;

@property (nonatomic,strong) CompletionBlock block;

@property (nonatomic,strong) NSString* type;

@end

NS_ASSUME_NONNULL_END
