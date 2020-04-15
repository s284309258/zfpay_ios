//
//  WhoCanSeeMyInfoVC.h
//  Lcwl
//
//  Created by AlphaGO on 2018/11/17.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WhoCanSeeType) {
    WhoCanSeeTypeInfo = 0, //设置里面的允许查看资料
    WhoCanSeeTypeDynamic = 1 //发朋友圈权限
};

@interface WhoCanSeeMyInfoVC : BaseViewController
@property (nonatomic, copy) CompletionBlock block;
@property (nonatomic, assign) WhoCanSeeType type;
@property (nonatomic, copy) NSString *value;
@end

NS_ASSUME_NONNULL_END
