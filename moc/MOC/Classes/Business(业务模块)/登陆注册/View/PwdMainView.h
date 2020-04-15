//
//  PwdMainView.h
//  RatelBrother
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginRegModel;

NS_ASSUME_NONNULL_BEGIN

@interface PwdMainView : UIView

@property (nonatomic, strong) CompletionBlock block;

- (void)configModel:(LoginRegModel*)model;

- (void)switchClick;

- (void)updateForLanguageChanged;

@end

NS_ASSUME_NONNULL_END
