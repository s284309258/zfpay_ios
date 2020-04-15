//
//  LLKAssignApplyVC.h
//  XZF
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLKAssignApplyVC : BaseViewController

@property (nonatomic,strong) NSMutableArray* dataArray;

@property (nonatomic,strong) CompletionBlock block;
@end

NS_ASSUME_NONNULL_END
