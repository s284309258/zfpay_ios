//
//  PwdLoginVC.m
//  RatelBrother
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "RegisterVC.h"
#import "RegisterPhoneView.h"
#import "LoginRegModel.h"
#import "NSObject+LoginHelper.h"
#import "DLPickerView.h"
static int leftPadding = 11;
static int height = 49;

@interface RegisterVC ()

@property (nonatomic,strong) UIView          *logoView;

@property (nonatomic,strong) RegisterPhoneView *phoneView;

@property (nonatomic,strong) LoginRegModel    *model;

@property (nonatomic,strong) UIView    *backView;

@property (nonatomic,strong) UIScrollView    *scroll;

@property (nonatomic,strong) UIButton       *backBtn;

@end

@implementation RegisterVC
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
    self.isShowBackButton = YES;
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.scroll];
    AdjustTableBehavior(self.scroll);
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [RegisterPhoneView getHeight]+height+NavBarHeight+StatuBarHeight)];
    [self.scroll addSubview:self.backView];
    self.scroll.contentSize = CGSizeMake(SCREEN_WIDTH, [RegisterPhoneView getHeight]+height+40+NavBarHeight+StatuBarHeight);
    
    [self.backView addSubview:self.backBtn];
    [self.backView addSubview:self.logoView];
    [self.backView addSubview:self.phoneView];
    
}

-(void)layout{
    @weakify(self)
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.backView).offset(10);
        make.height.equalTo(@(20));
        make.width.equalTo(@(60));
        make.top.equalTo(@((NavBarHeight-20)/2+StatuBarHeight));
    }];
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.backView).offset(30+NavBarHeight+StatuBarHeight);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(197));
        make.height.equalTo(@(59));
    }];
    

    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.backView.mas_centerX);
        make.width.equalTo(@(SCREEN_WIDTH-2*leftPadding));
        make.height.equalTo(@([RegisterPhoneView getHeight]));
        make.top.equalTo(self.logoView.mas_bottom).offset(30);
    }];
}

-(UIView*)logoView{
    if (!_logoView) {
        _logoView = [[UIView alloc]initWithFrame:CGRectZero];
        _logoView.backgroundColor = [UIColor clearColor];
        UIImageView* view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
        [_logoView addSubview:view];
        @weakify(self)
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.edges.equalTo(self.logoView);
        }];
    }
    return _logoView;
}

-(RegisterPhoneView*)phoneView{
    if (!_phoneView) {
        _phoneView = [[RegisterPhoneView alloc]initWithFrame:CGRectZero];
        if (!_model) {
            _model = [[LoginRegModel alloc]init];
            _model.type = RegisterPhoneType;
        }
        [_phoneView configModel:_model];
        _phoneView.backgroundColor = [UIColor clearColor];
        
    }
    return _phoneView;
}

-(void)setNaviStyle{
    
}

-(void)navBarRightBtnAction:(id)sender{
}



- (void)updateForLanguageChanged {
//    [_leftBtn setTitle:Lang(@"手机注册") forState:UIControlStateNormal];
    [self.phoneView updateForLanguageChanged];
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

@end
