//
//  TextChangeVC.h
//  Lcwl
//
//  Created by AlphaGO on 2018/11/21.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TextChangeVC : BaseViewController
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *placeholder;
@property (copy, nonatomic) NSString *tipInfo;
@property(nonatomic, copy) CompletionBlock block;
@end

NS_ASSUME_NONNULL_END
