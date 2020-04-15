//
//  ShowImageVC.h
//  Lcwl
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 lichangwanglai. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ShowType)
{
    ShowTypePush = 0,
    ShowTypePrompt = 1,
};

typedef NS_ENUM(NSInteger, ShowImageType)
{
    ShowImageType01 = 1, //奖励规则
    ShowImageType02 = 2, //人气奖励
    ShowImageType03 = 3  //获奖名单
};

@interface ShowImageVC : BaseViewController
//@property(nonatomic, copy) NSString *url;
@property(nonatomic, assign) ShowType type;
@property(nonatomic, assign) ShowImageType showImageType;
@end

NS_ASSUME_NONNULL_END
