//
//  ApplyMPosVC.m
//  XZF
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ApplyMPosVC.h"
#import "CipherView.h"
#import "InvitationCodeView.h"
#import "IIViewDeckController.h"
#import "ApplyMPosSliderVC.h"
#import "UIViewController+IIViewDeckAdditions.h"
#import "NSObject+Home.h"
#import "MPosModel.h"
static NSInteger height = 50;
@interface ApplyMPosVC ()

@property (nonatomic , strong) CipherView*         snCodeView;

@property (nonatomic , strong) InvitationCodeView* nameView;

@property (nonatomic , strong) InvitationCodeView* phoneView;

@property (nonatomic , strong) InvitationCodeView* pwdView;

@property (nonatomic , strong) UIButton* submitBtn;

@property (nonatomic , strong) UIView* backView;

@property (strong, nonatomic) MPosModel* pos;

@property (strong, nonatomic) NSString* name;

@property (strong, nonatomic) NSString* tel;

@property (strong, nonatomic) NSString* pwd;

@end

@implementation ApplyMPosVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    IIViewDeckController* tmp = [self viewDeckController];
    tmp.title = @"MPOS";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self layout];
}

-(void)initUI{
    self.title = @"MPOS";
    self.pos = [[NSMutableArray alloc]initWithCapacity:10];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.snCodeView];
    [self.backView addSubview:self.nameView];
    [self.backView addSubview:self.phoneView];
    [self.backView addSubview:self.pwdView];
    [self.backView addSubview:self.submitBtn];
    
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
        make.bottom.equalTo(self.backView.mas_bottom).offset(-44);
    }];
}

-(void)layout{
    
}

-(CipherView*)snCodeView{
    if (!_snCodeView) {
        _snCodeView = [[CipherView alloc]initWithFrame:CGRectZero];
        _snCodeView.tf.secureTextEntry = NO;
        _snCodeView.tf.enabled = NO;
        [_snCodeView reloadTitle:@"SN码" placeHolder:@"请选择POS机SN码"];
        [_snCodeView isHiddenLine:NO];
        [_snCodeView.btn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
        [_snCodeView.btn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateSelected];
        @weakify(self)
        _snCodeView.rowClick = ^(id data) {
            @strongify(self)
            ApplyMPosSliderVC* slider = [[ApplyMPosSliderVC alloc]init];
            slider.block = ^(id data) {
                self.pos = data;
                [self.snCodeView reloadTitle:@"SN码" placeHolder:self.pos.sn];
                self.nameView.tf.text = self.pos.name;
                self.phoneView.tf.text = self.pos.tel;
                
            };
            [self.viewDeckController setRightViewController:slider];
            [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
        };
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

-(void)submit:(id)sender{
    [self.view endEditing:YES];
    [self editMposMerInfo:@{@"sn":self.pos.sn,@"name":self.name,@"tel":self.tel} completion:^(BOOL success, NSString *error) {
        if (success) {
            
        }
    }];
}

-(UIView*)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
@end
