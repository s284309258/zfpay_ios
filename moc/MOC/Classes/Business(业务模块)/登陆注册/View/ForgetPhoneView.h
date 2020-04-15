//
//  ForgetPhoneView.h
//  MOC
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneNumView.h"
#import "ImgCaptchaView.h"
#import "TextCaptchaView.h"
#import "CipherView.h"
@class LoginRegModel;
NS_ASSUME_NONNULL_BEGIN

@interface ForgetPhoneView : UIView

@property (nonatomic,strong) PhoneNumView    *numView;

@property (nonatomic,strong) ImgCaptchaView      *imageView;

@property (nonatomic,strong) TextCaptchaView *codeView;

@property (nonatomic,strong) CipherView          *pwdView;

@property (nonatomic,strong) CipherView          *rePwdView;

@property (nonatomic,strong) UIButton        *submitBtn;

@property (nonatomic,strong) LoginRegModel   *model;

-(void)configModel:(LoginRegModel*)model;

+(int)getHeight;

@end

NS_ASSUME_NONNULL_END
