//
//  PwdLoginVC.m
//  RatelBrother
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ForgetPwdVC.h"
#import "ForgetPhoneView.h"
#import "LoginRegModel.h"
#import "NSObject+LoginHelper.h"
#import "DLPickerView.h"
static int leftPadding = 11;
static int height = 49;

@interface ForgetPwdVC ()

@property (nonatomic,strong) UIButton        *backBtn;

@property (nonatomic,strong) UILabel         *titleLbl;

@property (nonatomic,strong) UILabel         *descLbl;

@property (nonatomic,strong) ForgetPhoneView *phoneView;

@property (nonatomic,strong) LoginRegModel   *model;

@property (nonatomic,strong) UIView          *backView;

@property (nonatomic,strong) UIScrollView    *scroll;


@end

@implementation ForgetPwdVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNaviStyle];
    [self initUI];
    [self layout];
}


-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.scroll];
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [ForgetPhoneView getHeight]+NavBarHeight+StatuBarHeight+height)];
    [self.scroll addSubview:self.backView];
    self.scroll.contentSize = CGSizeMake(SCREEN_WIDTH, [ForgetPhoneView getHeight]+NavBarHeight+StatuBarHeight+height+20);
    
    [self.backView addSubview:self.backBtn];
    [self.backView addSubview:self.titleLbl];
    [self.backView addSubview:self.descLbl];
    [self.backView addSubview:self.phoneView];
}

-(void)layout{
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(10);
        make.height.equalTo(@(20));
        make.width.equalTo(@(60));
        make.top.equalTo(@((NavBarHeight-20)/2+StatuBarHeight));
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backBtn.mas_bottom).offset(40);
        make.left.equalTo(self.backView).offset(40);
        make.right.equalTo(self.backView);
        make.height.equalTo(@(20));
    }];
    
    [self.descLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLbl.mas_bottom).offset(5);
        make.left.right.equalTo(self.titleLbl);
        make.height.equalTo(@(20));
    }];
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.width.equalTo(@(SCREEN_WIDTH-2*leftPadding));
        make.height.equalTo(@([ForgetPhoneView getHeight]));
        make.top.equalTo(self.descLbl.mas_bottom).offset(60);
    }];
}

-(UILabel*)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLbl.backgroundColor = [UIColor clearColor];
        _titleLbl.textColor = [UIColor moBlack];
//        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"请输入您绑定的手机号码" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 21],NSForegroundColorAttributeName: [UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1.0]}];
//        _titleLbl.attributedText = string;
        _titleLbl.text = @"重置密码";
        _titleLbl.font = [UIFont boldSystemFontOfSize:21];
        _titleLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLbl;
}

-(UILabel*)descLbl{
    if (!_descLbl) {
        _descLbl = [[UILabel alloc]initWithFrame:CGRectZero];
        _descLbl.backgroundColor = [UIColor clearColor];
        _descLbl.textColor = [UIColor moPlaceHolder];
        _descLbl.text = Lang(@"为了保证您的账户安全，请勿泄露密码");
        _descLbl.font = [UIFont systemFontOfSize:13];
        _descLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _descLbl;
}

-(UIButton*)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor moBlack] forState:UIControlStateNormal];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(ForgetPhoneView*)phoneView{
    if (!_phoneView) {
        _phoneView = [[ForgetPhoneView alloc]initWithFrame:CGRectZero];
        if (!_model) {
            _model = [[LoginRegModel alloc]init];
            _model.type = ForgetPhoneType;
        }
        [_phoneView configModel:_model];
        _phoneView.backgroundColor = [UIColor clearColor];
        
    }
    return _phoneView;
}

-(void)setNaviStyle{
    self.navigationController.navigationBarHidden = YES;
}

-(void)navBarRightBtnAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
