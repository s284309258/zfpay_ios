//
//  RegisterPhoneView.m
//  MOC
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "RegisterPhoneView.h"
#import "InvitationCodeView.h"
#import "PhoneNumView.h"
#import "CipherView.h"
#import "ImgCaptchaView.h"
#import "TextCaptchaView.h"
#import "LoginRegModel.h"
#import "NSObject+LoginHelper.h"
#import "SPButton.h"
#import "NSMutableAttributedString+Attributes.h"
#import "NSAttributedString+YYText.h"
#import "YYLabel.h"
static int topPadding = 16;
static int leftPadding = 23;
static int padding = 0;
static int height = 50;
static int btnHeight = 46;
@interface RegisterPhoneView()

@property (nonatomic,strong) InvitationCodeView  *inviteView;

@property (nonatomic,strong) PhoneNumView        *numView;

@property (nonatomic,strong) CipherView          *pwdView;

@property (nonatomic,strong) CipherView          *rePwdView;

@property (nonatomic,strong) CipherView          *payPwdView;

@property (nonatomic,strong) ImgCaptchaView      *imageView;

@property (nonatomic,strong) TextCaptchaView     *codeView;

@property (nonatomic,strong) UIButton            *submitBtn;

@property (nonatomic,strong) LoginRegModel       *model;

@property (nonatomic,strong) YYLabel            *tipLbl;

@end

@implementation RegisterPhoneView

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
    [self addSubview:self.inviteView];
    [self addSubview:self.numView];
    [self addSubview:self.pwdView];
    [self addSubview:self.rePwdView];
    [self addSubview:self.payPwdView];
    [self addSubview:self.imageView];
    [self addSubview:self.codeView];
    [self addSubview:self.submitBtn];
    [self addSubview:self.tipLbl];
}

-(void)layout{
    
    @weakify(self)
    [self.inviteView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(leftPadding);
        make.right.equalTo(self.mas_right).offset(-leftPadding);
        make.height.equalTo(@(height));
        make.top.equalTo(self).offset(topPadding);
    }];
    
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.inviteView);
        make.height.equalTo(@(height));
        make.top.equalTo(self.inviteView.mas_bottom).offset(padding);
    }];
    
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.inviteView);
        make.height.equalTo(@(height));
        make.top.equalTo(self.numView.mas_bottom).offset(padding);
    }];
    
    [self.rePwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.inviteView);
        make.height.equalTo(@(height));
        make.top.equalTo(self.pwdView.mas_bottom).offset(padding);
    }];
    
    [self.payPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.inviteView);
        make.height.equalTo(@(height));
        make.top.equalTo(self.rePwdView.mas_bottom).offset(padding);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.inviteView);
        make.height.equalTo(@(height));
        make.top.equalTo(self.payPwdView.mas_bottom).offset(padding);
    }];
    
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.inviteView);
        make.height.equalTo(@(height));
        make.top.equalTo(self.imageView.mas_bottom).offset(padding);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.inviteView);
        make.height.equalTo(@(btnHeight));
        make.top.equalTo(self.codeView.mas_bottom).offset(36);
    }];
    
    [self.tipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.inviteView);
        make.height.equalTo(@(17));
        make.top.equalTo(self.submitBtn.mas_bottom).offset(24);
    }];
    
}

-(InvitationCodeView* )inviteView{
    if (!_inviteView) {
        _inviteView = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
        [_inviteView reloadImg:@"推荐人" placeHolder:Lang(@"推荐人手机号")];
        [_inviteView showDownLine:YES];
//        _inviteView.tf.keyboardType = UIKeyboardTypeNumberPad;
        @weakify(self)
        _inviteView.getText = ^(id data) {
            @strongify(self)
            self.model.inviteCode = data;
        };
    }
    return _inviteView;
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

-(CipherView* )pwdView{
    if (!_pwdView) {
        _pwdView = [[CipherView alloc]initWithFrame:CGRectZero];
        [_pwdView reloadImg:@"密码" placeHolder:Lang(@"登录密码 (6-16位数字、字母组合)")];
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

-(CipherView* )payPwdView{
    if (!_payPwdView) {
        _payPwdView = [[CipherView alloc]initWithFrame:CGRectZero];
        _payPwdView.tf.keyboardType = UIKeyboardTypeNumberPad;
        [_payPwdView reloadImg:@"密码" placeHolder:Lang(@"支付密码 (6位数字)")];
        @weakify(self)
        _payPwdView.getText = ^(id data) {
            @strongify(self)
            self.model.pay_password = data;
        };
    }
    return _payPwdView;
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

-(TextCaptchaView* )codeView{
    if (!_codeView) {
        _codeView = [[TextCaptchaView alloc]initWithFrame:CGRectZero];
        [_codeView reloadImg:@"短信验证码" placeHolder:Lang(@"短信验证码")];
        [_codeView showBorder];
        [_codeView showDownLine:YES];
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
    [param setValue:@"FrontRegister" forKey:@"bus_type"];
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

-(UIButton* )submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        [_submitBtn setTitle:Lang(@"注册") forState:UIControlStateNormal];
        _submitBtn.clipsToBounds =NO;
        [_submitBtn addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setBackgroundColor:[UIColor moGreen]];
    }
    return _submitBtn;
}


-(void)goTo:(id)sender{
    if (![StringUtil regexStr:self.model.inviteCode] ||
        ![StringUtil regexStr:self.model.phoneNo] ||
        ![StringUtil regexStr:self.model.password] ||
        ![StringUtil regexStr:self.model.rePassword] ||
        ![StringUtil regexStr:self.model.pay_password]||
        ![StringUtil regexStr:self.model.picCode]||
        ![StringUtil regexStr:self.model.captcha]) {
        [NotifyHelper showMessageWithMakeText:[StringUtil errorString]];
        return;
    }
    if (![self.model.password isEqualToString:self.model.rePassword]) {
        [NotifyHelper showMessageWithMakeText:Lang(@"密码不一致")];
        return;
    }
    if (!(self.model.password.length >= 6 && self.model.password.length <=18 )) {
        [NotifyHelper showMessageWithMakeText:Lang(@"密码在6-18位")];
        return;
    }
    [self register:@{@"login_password":self.model.password,@"pay_password":self.model.pay_password,@"sys_user_account":self.model.phoneNo,@"sms_code":self.model.captcha,@"invite_code":self.model.inviteCode} completion:^(id object, NSString *error) {
        if (object) {
            NSDictionary* dict = object;
            NSString* token = dict[@"token"];
            if (![StringUtil isEmpty:token]) {
                [self login:@{@"login_type":@"token",@"token":token} completion:^(BOOL success, NSString *error) {
                    if (success) {
                        MoApp.mainVC = [[MainViewController alloc] init];
                        [self.window setRootViewController:MoApp.mainVC];
                    }
                }];
            }
        } else {
            [self getImgCode];
        }
    }];
}

-(YYLabel* )tipLbl{
    if (!_tipLbl) {
        _tipLbl = [YYLabel new];
        YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
        parser.emoticonMapper = @{@"中付钱柜_select":[UIImage imageNamed:@"中付钱柜_select"]};
        _tipLbl.textParser = parser;
        NSString* str1 = @" 我已阅读并同意";
        NSString* str2 = @"《用户服务协议》";
        NSString* str3 = @"和";
        NSString* str4 = @"《隐私政策》";
        NSString* str = [NSString stringWithFormat:@"中付钱柜_select%@%@%@%@",str1,str2,str3,str4];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
        NSRange range1 = [str rangeOfString:str1];
        NSRange range2 = [str rangeOfString:str2];
        NSRange range3 = [str rangeOfString:str3];
        NSRange range4 = [str rangeOfString:str4];
    
        [attr setTextHighlightRange:[str rangeOfString:str2] color:[UIColor moGreen] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            NSLog(@"%@",text);
            [MXRouter openURL:@"lcwl://ServiceProtocolVC"];
        }];
        [attr setTextHighlightRange:[str rangeOfString:str4] color:[UIColor moGreen] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                NSLog(@"%@",text);
            [MXRouter openURL:@"lcwl://PrivacyProtocolVC"];
              }];
        [attr setTextHighlightRange:[str rangeOfString:str1] color:[UIColor moPlaceHolder] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            NSLog(@"%@",text);
              }];
        [attr setTextHighlightRange:[str rangeOfString:str3] color:[UIColor moPlaceHolder] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                  NSLog(@"%@",text);
        }];
        
        
        _tipLbl.attributedText = attr;
        
    }
    return _tipLbl;
}

//-(void)back:(id)sender{
//    UIViewController * vc = [self nextResponder].nextResponder.nextResponder.nextResponder;
//    [vc.navigationController popViewControllerAnimated:YES];
//}

+(int)getHeight{
    return topPadding+10*(height+padding)+height+36+btnHeight+24+13+topPadding;
}


-(void)configModel:(LoginRegModel*)model{
    self.model = model;
}

@end
