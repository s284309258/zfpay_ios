//
//  RegisterPhoneView.h
//  MOC
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LoginRegModel;

@interface RegisterPhoneView : UIView

+(int)getHeight;

-(void)configModel:(LoginRegModel*)model;

- (void)updateForLanguageChanged;

@end

NS_ASSUME_NONNULL_END
