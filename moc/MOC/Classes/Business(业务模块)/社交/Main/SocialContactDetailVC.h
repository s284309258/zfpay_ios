//
//  SocialContactDetailVC.h
//  Lcwl
//
//  Created by mac on 2018/12/5.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "BaseViewController.h"
#import "YNPageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class WBStatusLayout;

@interface SocialContactDetailVC : YNPageViewController
@property (nonatomic, weak) WBStatusLayout *layout;
@property (nonatomic, strong) NSString *circle_id;
@property (nonatomic, copy) CompletionBlock backBlock;
+ (instancetype)instanceVC;
@end

NS_ASSUME_NONNULL_END
