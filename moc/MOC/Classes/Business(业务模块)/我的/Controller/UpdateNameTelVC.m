//
//  ApplyMPosVC.m
//  XZF
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "UpdateNameTelVC.h"
#import "CipherView.h"
#import "InvitationCodeView.h"
#import "IIViewDeckController.h"
#import "ApplyMPosSliderVC.h"
#import "UIViewController+IIViewDeckAdditions.h"
#import "NSObject+Home.h"
#import "MPosModel.h"
#import "ZFMerchantManager.h"
static NSInteger height = 50;
@interface UpdateNameTelVC ()

@property (nonatomic , strong) InvitationCodeView* snCodeView;

@property (nonatomic , strong) InvitationCodeView* nameView;

@property (nonatomic , strong) InvitationCodeView* phoneView;

@property (nonatomic , strong) InvitationCodeView* pwdView;

@property (nonatomic , strong) UIButton* submitBtn;

@property (nonatomic , strong) UIButton* skipBtn;

@property (nonatomic , strong) UIView* backView;


@property (strong, nonatomic) NSString* name;

@property (strong, nonatomic) NSString* tel;

@property (strong, nonatomic) NSString* pwd;

@end

@implementation UpdateNameTelVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self layout];

    _snCodeView.tf.text = self.model.sn;
    _nameView.tf.text = self.model.name;
    _phoneView.tf.text = self.model.tel;
    self.name = self.model.name;
    self.tel = self.model.tel;
}

-(void)initUI{
    self.title = @"商户登记";
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.snCodeView];
    [self.backView addSubview:self.nameView];
    [self.backView addSubview:self.phoneView];
    [self.backView addSubview:self.pwdView];
    [self.backView addSubview:self.submitBtn];
    [self.backView addSubview:self.skipBtn];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(370));
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(10);
    }];
    [self.snCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView);
        make.left.equalTo(self.backView).offset(15);
        make.right.equalTo(self.backView).offset(-15);
        make.height.equalTo(@(height));
    }];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.snCodeView.mas_bottom);
        make.left.right.equalTo(self.snCodeView);
        make.height.equalTo(@(height));
    }];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameView.mas_bottom);
        make.left.right.equalTo(self.snCodeView);
        make.height.equalTo(@(height));
    }];
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneView.mas_bottom);
        make.left.right.equalTo(self.snCodeView);
        make.height.equalTo(@(height));
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.snCodeView);
        make.height.equalTo(@(height));
        make.bottom.equalTo(self.skipBtn.mas_top).offset(-20);
    }];
    [self.skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.equalTo(self.snCodeView);
           make.height.equalTo(@(height));
           make.bottom.equalTo(self.backView.mas_bottom).offset(-44);
       }];
}

-(void)layout{
    
}

-(InvitationCodeView*)snCodeView{
    if (!_snCodeView) {
        _snCodeView = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
        [_snCodeView reloadTitle:@"SN码" placeHolder:@""];
        _snCodeView.tf.enabled = NO;
        @weakify(self)
        _snCodeView.getText = ^(id data) {
            @strongify(self)
        };
        [_snCodeView isHiddenLine:NO];
    }
    return _snCodeView;
}

-(InvitationCodeView*)nameView{
    if (!_nameView) {
        _nameView = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
        [_nameView reloadTitle:@"姓名" placeHolder:@"请输入商户姓名"];
        @weakify(self)
        _nameView.getText = ^(id data) {
            @strongify(self)
            self.name = data;
        };
         [_nameView isHiddenLine:NO];
    }
    return _nameView;
}

-(InvitationCodeView*)phoneView{
    if (!_phoneView) {
        _phoneView = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
        _phoneView.tf.keyboardType = UIKeyboardTypeNumberPad;
       
         [_phoneView reloadTitle:@"手机号码" placeHolder:@"请输入商户手机号"];
        @weakify(self)
        _phoneView.getText = ^(id data) {
            @strongify(self)
            self.tel = data;
        };
         [_phoneView isHiddenLine:NO];
    }
    return _phoneView;
}

-(InvitationCodeView*)pwdView{
    if (!_pwdView) {
        _pwdView = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
        [_pwdView reloadTitle:@"交易密码" placeHolder:@"请输入交易密码"];
        [_pwdView isHiddenLine:NO];
        _pwdView.hidden = YES;
        @weakify(self)
        _pwdView.getText = ^(id data) {
            @strongify(self)
            self.pwd = data;
        };
    }
    return _pwdView;
}

-(UIButton*)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        _submitBtn.backgroundColor = [UIColor darkGreen];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _submitBtn;
}

-(UIButton*)skipBtn{
    if (!_skipBtn) {
        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipBtn.layer.masksToBounds = YES;
        _skipBtn.hidden = YES;
        _skipBtn.layer.cornerRadius = 5;
        _skipBtn.backgroundColor = [UIColor whiteColor];
        _skipBtn.layer.borderColor = [UIColor moGreen].CGColor;
        _skipBtn.layer.borderWidth = 0.5;
        [_skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [_skipBtn setTitleColor:[UIColor moGreen] forState:UIControlStateNormal];
        _skipBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_skipBtn addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _skipBtn;
}

-(void)submit:(id)sender{
    [self.view endEditing:YES];
    [self updateMerchantNameAndTel:@{@"sn":self.model.sn,@"name":self.name,@"tel":self.tel} completion:^(BOOL success, NSString *error) {
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"merchanlist" object:nil];
        }
    }];
//    [self editMposMerInfo:@{@"sn":self.pos.sn,@"name":self.name,@"tel":self.tel} completion:^(BOOL success, NSString *error) {
//        if (success) {
//
//        }
//    }];
}

-(void)skip:(id)sender{
//    [ZFMerchantManager shareManager].delegate = self;
//    [[ZFMerchantManager shareManager]presentWithAccount:AppUserModel.app_id viewController:self other:@"ios"];
}

-(UIView*)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
@end
