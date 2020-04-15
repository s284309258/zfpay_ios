//
//  UIViewController+Extension.h
//  Lcwl
//
//  Created by mac on 2018/12/6.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extension)
- (void)showPopMenu:(NSArray *)titleArr iconArr:(NSArray *)iconArr sender:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
