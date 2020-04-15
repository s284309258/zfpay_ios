//
//  SocialContactMainVC.h
//  Lcwl
//
//  Created by mac on 2018/12/6.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "YNPageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SocialContactMainVC : YNPageViewController

@property (nonatomic, copy) NSString *otherId;
@property (nonatomic, copy) NSString *circle_back_img;

+ (instancetype)instanceVC;

///子类可以覆盖
+ (YNPageConfigration *)pageConfigration;
- (void)updateMenu;
- (void)setNavBarRightBtnWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
