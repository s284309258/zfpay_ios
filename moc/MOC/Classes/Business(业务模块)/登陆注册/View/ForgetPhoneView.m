//
//  RegisterPhoneView.m
//  MOC
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ForgetPhoneView.h"
#import "InvitationCodeView.h"
#import "PhoneNumView.h"
#import "TextCaptchaView.h"
#import "ImgCaptchaView.h"
#import "TextCaptchaView.h"
#import "LoginRegModel.h"
#import "NSObject+LoginHelper.h"
#import "CipherView.h"
static int topPadding = 16;
static int leftPadding = 23;
static int padding = 8;
static int height = 50;
static int btnHeight = 44;
@interface ForgetPhoneView()

@end

@implementation ForgetPhoneView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
        [self layout];
        [self getImgCode];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.numView];
    [self addSubview:self.imageView];
    [self addSubview:self.codeView];
    [self addSubview:self.pwdView];
    [self addSubview:self.rePwdView];
    [self addSubview:self.submitBtn];
}

-(void)layout{
    @weakify(self)
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(leftPadding);
        make.right.equalTo(self.mas_right).offset(-leftPadding);
        make.height.equalTo(@(height));
        make.top.equalTo(self);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.numView);
        make.height.equalTo(@(height));
        make.top.equalTo(self.numView.mas_bottom);
    }];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.numView);
        make.height.equalTo(@(height));
        make.top.equalTo(self.imageView.mas_bottom);
    }];
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.numView);
        make.height.equalTo(@(height));
        make.top.equalTo(self.codeView.mas_bottom);
    }];
    
    [self.rePwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.numView);
        make.height.equalTo(@(height));
        make.top.equalTo(self.pwdView.mas_bottom);
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.numView);
        make.height.equalTo(@(btnHeight));
        make.top.equalTo(self.rePwdView.mas_bottom).offset(50);
    }];
}

-(PhoneNumView* )numView{
    if (!_numView) {
        _numView = [[PhoneNumView alloc]initWithFrame:CGRectZero];
        [_numView reloadPlaceHolder:Lang(@"手机号码") image:@"手机"];
        [_numView showDownLine:YES];
        @weakify(self)
        _numView.getText = ^(id data) {
            @strongify(self)
            self.model.phoneNo = data;
        };
    }
    return _numView;
}

-(TextCaptchaView* )codeView{
    if (!_codeView) {
        _codeView = [[TextCaptchaView alloc]initWithFrame:CGRectZero];
        [_codeView reloadImg:@"短信验证码" placeHolder:Lang(@"短信验证码")];
        [_codeView showDownLine:YES];
        [_codeView showBorder];
        @weakify(self)
        _codeView.getText = ^(id data) {
            @strongify(self)
            self.model.captcha = data;
        };
        _codeView.sendCodeBlock = ^(id data) {
            @strongify(self)
            [self sendSmsCode];
        };
    }
    return _codeView;
}

- (void)sendSmsCode {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
    [param setValue:self.model.phoneNo forKey:@"sys_user_account"];
    [param setValue:@"FrontForgetPass" forKey:@"bus_type"];
    [param setValue:self.model.img_id forKey:@"img_id"];
    [param setValue:self.model.picCode forKey:@"img_code"];
    [self send_code:param completion:^(BOOL success, NSString *error) {
        if (!success) {
            [self getImgCode];
        }else{
            [self.codeView startCountDowView];
        }
    }];
}

- (void)getImgCode {
    @weakify(self)
    [self createImgCode:@{@"interface_type":@"createImgCode"} completion:^(id object, NSString *error) {
        @strongify(self)
        if (object) {
            NSDictionary* tempDic = (NSDictionary*)object;
            NSString * img_id = [tempDic valueForKeyPath:@"img_id"];
            NSString * img_io = [tempDic valueForKeyPath:@"img_io"];
            self.model.img_id = img_id;
            self.model.img_io = img_io;
            [self.imageView reloadRightImg:self.model.ioImage];
        }
    }];
}


-(UIButton* )submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        [_submitBtn setTitle:Lang(@"确认重置") forState:UIControlStateNormal];
        _submitBtn.clipsToBounds =NO;
        [_submitBtn addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setBackgroundColor:[UIColor moGreen]];
    }
    return _submitBtn;
}


-(void)back:(id)sender{
    UIViewController * vc = [self nextResponder].nextResponder.nextResponder.nextResponder;
    [vc.navigationController popViewControllerAnimated:YES];
}

+(int)getHeight{
    return topPadding+4*(height+padding)+height+36+btnHeight+24+13+topPadding;
}

-(void)configModel:(LoginRegModel*)model{
    self.model = model;
}

-(void)goTo:(id)sender{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self userForgetPass:@{@"sys_user_account":self.model.phoneNo,@"sms_code":self.model.captcha,@"login_password":self.model.password} completion:^(id object, NSString *error) {
        if (object) {
            [self back:nil];
        }
    }];
}


-(ImgCaptchaView* )imageView{
    if (!_imageView) {
        _imageView = [[ImgCaptchaView alloc]initWithFrame:CGRectZero];
        [_imageView reloadImg:@"图形验证码" placeHolder:@"请输入验证码"];
        [_imageView showDownLine:YES];
        @weakify(self)
        _imageView.getText = ^(id data) {
            @strongify(self)
            self.model.picCode = data;
        };
        _imageView.picBlock = ^(id data) {
            @strongify(self)
            [self getImgCode];
        };
    }
    return _imageView;
}

-(CipherView* )pwdView{
    if (!_pwdView) {
        _pwdView = [[CipherView alloc]initWithFrame:CGRectZero];
        [_pwdView reloadImg:@"密码" placeHolder:Lang(@"新登录密码 (6-16位数字、字母组合)")];
        @weakify(self)
        _pwdView.getText = ^(id data) {
            @strongify(self)
            self.model.password = data;
        };
    }
    return _pwdView;
}

-(CipherView* )rePwdView{
    if (!_rePwdView) {
        _rePwdView = [[CipherView alloc]initWithFrame:CGRectZero];
        [_rePwdView reloadImg:@"密码" placeHolder:@"确认密码"];
        @weakify(self)
        _rePwdView.getText = ^(id data) {
            @strongify(self)
            self.model.rePassword = data;
        };
    }
    return _rePwdView;
}
@end
