//
//  LoginMainView.m
//  AdvertisingMaster
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "PwdMainView.h"
#import "PhoneNumView.h"
#import "CipherView.h"
#import "LoginRegModel.h"
#import "NSObject+LoginHelper.h"
#import "PhoneNumView.h"
#import "SPButton.h"
static NSInteger padding = 15;
static NSInteger height = 45;
static int btnHeight = 44;
@interface PwdMainView()

@property (nonatomic,strong) PhoneNumView    *phoneView;

@property (nonatomic,strong) CipherView      *pwdView;

@property (nonatomic,strong) SPButton        *rememberBtn;

@property (nonatomic,strong) UIButton        *forgetBtn;

@property (nonatomic,strong) UIButton        *submitBtn;

@property (nonatomic,strong) UIButton        *regBtn;

@property (nonatomic,strong) UIButton        *protocolBtn;

@property (nonatomic,strong) LoginRegModel   *model;

@end

@implementation PwdMainView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.phoneView];
    [self addSubview:self.pwdView];
    [self addSubview:self.rememberBtn];
    [self addSubview:self.forgetBtn];
    [self addSubview:self.submitBtn];
    [self addSubview:self.regBtn];
//    #ifdef OPEN_DISTRIBUTION
//    if([AppDelegate isTestDistribution]) {
//        [self addSubview:self.protocolBtn];
//    }
//    #endif
    
    [self layout];
}

-(void)layout{
    @weakify(self)
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(-0);
        make.height.equalTo(@(height));
        make.top.equalTo(self.mas_top).offset(0);
    }];
  
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(-0);
        make.height.equalTo(@(height));
        make.top.equalTo(self.phoneView.mas_bottom).offset(5);
    }];
    
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.pwdView.mas_bottom).offset(20);
        make.height.equalTo(@(20));
        make.width.equalTo(@(70));
        make.right.equalTo(self.pwdView.mas_right);
    }];
    
    [self.rememberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.pwdView.mas_bottom).offset(20);
        make.height.equalTo(@(20));
        make.width.equalTo(@(90));
        make.left.equalTo(self.pwdView.mas_left).offset(0);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@(btnHeight));
        make.left.right.equalTo(self.pwdView);
        make.top.equalTo(self.forgetBtn.mas_bottom).offset(3*padding);
    }];
    
    [self.regBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@(btnHeight));
        make.left.right.equalTo(self.submitBtn);
        make.top.equalTo(self.submitBtn.mas_bottom).offset(padding);
    }];
    
//    #ifdef OPEN_DISTRIBUTION
//    if([AppDelegate isTestDistribution]) {
//        [self.protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            @strongify(self)
//            make.centerX.equalTo(self.mas_centerX);
//            make.height.equalTo(@(30));
//            make.left.right.equalTo(self.submitBtn);
//            make.top.equalTo(self.regBtn.mas_bottom).offset(padding);
//        }];
//    }
//    #endif
    
}

-(CipherView* )pwdView{
    if (!_pwdView) {
        _pwdView = [[CipherView alloc]initWithFrame:CGRectZero];
        [_pwdView reloadImg:@"密码" placeHolder:Lang(@"登录密码")];
        @weakify(self)
        _pwdView.getText = ^(id data) {
            @strongify(self)
            self.model.password = data;
        };
    }   
    return _pwdView;
}

-(PhoneNumView* )phoneView{
    if (!_phoneView) {
        _phoneView = [[PhoneNumView alloc]initWithFrame:CGRectZero];
        [_phoneView reloadPlaceHolder:@"手机号码" image:@"手机"];
        [_phoneView showDownLine:YES];
        @weakify(self)
        _phoneView.getText = ^(id data) {
            @strongify(self)
            self.model.phoneNo = data;
        };
    }
    return _phoneView;
}

-(UIButton* )forgetBtn{
    if (!_forgetBtn) {
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _forgetBtn.backgroundColor = [UIColor clearColor];
        [_forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        NSString* str = Lang(@"忘记密码?");
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
        [attr addColor:[UIColor moGreen] substring:str];
        [_forgetBtn setAttributedTitle:attr forState:UIControlStateNormal];
        [_forgetBtn addTarget:self action:@selector(forgetPwd:) forControlEvents:UIControlEventTouchUpInside];
        _forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _forgetBtn;
}

-(void)forgetPwd:(id)sender{
    [MXRouter openURL:@"lcwl://ForgetPwdVC"];
}

-(SPButton* )rememberBtn{
    if (!_rememberBtn) {
        _rememberBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionLeft];
        [_rememberBtn setImage:[UIImage imageNamed:@"中付钱柜_select"] forState:UIControlStateNormal];
        _rememberBtn.imageTitleSpace = 8;
        _rememberBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _rememberBtn.backgroundColor = [UIColor clearColor];
        [_rememberBtn setTitleColor:[UIColor moPlaceHolder] forState:UIControlStateNormal];
        [_rememberBtn setTitle:@"记住密码" forState:UIControlStateNormal];
//        _rememberBtn.hidden = YES;
//        NSString* str = Lang(@"记住密码");
//        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
//        [attr addColor:[UIColor moPlaceHolder] substring:str];
//        [_rememberBtn setAttributedTitle:attr forState:UIControlStateNormal];
//        [_rememberBtn addTarget:self action:@selector(rememberBtn:) forControlEvents:UIControlEventTouchUpInside];
//        _rememberBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _rememberBtn;
}

-(void)rememberBtn:(id)sender{
   
}

-(UIButton* )submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        [_submitBtn setTitle:Lang(@"登录") forState:UIControlStateNormal];
        _submitBtn.clipsToBounds =NO;
        [_submitBtn addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setBackgroundColor:[UIColor moGreen]];
    }
    return _submitBtn;
}


-(UIButton* )regBtn{
    if (!_regBtn) {
        _regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _regBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_regBtn setTitleColor:[UIColor moGreen] forState:UIControlStateNormal];
        _regBtn.layer.masksToBounds = YES;
        _regBtn.layer.cornerRadius = 5;
        [_regBtn setTitle:Lang(@"注册") forState:UIControlStateNormal];
        _regBtn.clipsToBounds =NO;
        [_regBtn addTarget:self action:@selector(register:) forControlEvents:UIControlEventTouchUpInside];
        _regBtn.layer.masksToBounds = YES;
        _regBtn.layer.borderWidth = 1;
        _regBtn.layer.borderColor = [UIColor moGreen].CGColor;
        [_regBtn setBackgroundColor:[UIColor whiteColor]];
    }
    return _regBtn;
}

-(UIButton* )protocolBtn{
    if (!_protocolBtn) {
        _protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _protocolBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_protocolBtn setTitleColor:[UIColor moGreen] forState:UIControlStateNormal];
//        _protocolBtn.layer.masksToBounds = YES;
//        _protocolBtn.layer.cornerRadius = 5;
        [_protocolBtn setTitle:@"《用户使用协议》" forState:UIControlStateNormal];
//        _protocolBtn.clipsToBounds =NO;
        [_protocolBtn addTarget:self action:@selector(protocolClick:) forControlEvents:UIControlEventTouchUpInside];
//        _protocolBtn.layer.masksToBounds = YES;
//        _protocolBtn.layer.borderWidth = 1;
//        _protocolBtn.layer.borderColor = [UIColor moGreen].CGColor;
        [_protocolBtn setBackgroundColor:[UIColor whiteColor]];
    }
    return _protocolBtn;
}

-(void)protocolClick:(id)sender{
     [MXRouter openURL:@"lcwl://ShowTextVC"];
}

-(void)register:(id)sender{
     [MXRouter openURL:@"lcwl://RegisterVC"];
}

-(void)goTo:(id)sender{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [NotifyHelper showHUDAddedTo:self makeText:@"" animated:YES];
    NSDictionary* paramDict = nil;
    paramDict = @{@"login_type":@"account",@"login_password":self.model.password,@"sys_user_account":self.model.phoneNo};
    [self login:paramDict completion:^(BOOL success, NSString *error) {
        //[NotifyHelper hideAllHUDsForView:self animated:YES];
        if (success) {
            MoApp.mainVC = [[MainViewController alloc] init];
            [self.window setRootViewController:MoApp.mainVC];
            
//            #ifdef OPEN_DISTRIBUTION
//            if([AppDelegate isTestDistribution]) {
//                [self socialLogin:@{@"login_type":@"account",@"password":@"111111",@"account":@"haha99"} superView:self completion:^(BOOL success, NSString *error) {
//                    [NotifyHelper hideAllHUDsForView:self animated:YES];
//                    if (success) {
//                        
//                    }else{
//                        
//                    }
//                }];
//            }
//            #endif
        }else{
            [NotifyHelper hideAllHUDsForView:self animated:YES];
        }
    }];
}

-(void)configModel:(LoginRegModel*)model{
    self.model = model;
    [self.phoneView reloadText:model.phoneNo];
    self.pwdView.tf.text = model.password;
}


@end
