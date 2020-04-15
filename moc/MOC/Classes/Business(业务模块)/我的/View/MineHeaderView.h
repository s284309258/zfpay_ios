//
//  MineHeaderView.h
//  MOC
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MineHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (void)reloadModel:(UserModel* )model;

@end

NS_ASSUME_NONNULL_END
