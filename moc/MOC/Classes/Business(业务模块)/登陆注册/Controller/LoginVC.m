//
//  PwdLoginVC.m
//  RatelBrother
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "LoginVC.h"
#import "PwdMainView.h"
#import "LoginRegModel.h"
#import "DLPickerView.h"
static NSInteger padding = 30;
@interface LoginVC ()

@property (nonatomic,strong) PwdMainView     *mainView;

@property (nonatomic,strong) UIView          *logoView;

@property (nonatomic,strong) LoginRegModel   *model;

@end

@implementation LoginVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNaviStyle];
    [self initUI];
}

-(void)initUI{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.logoView];
    [self layout];
}

-(void)layout{
    @weakify(self)
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top).offset(NavBarHeight+StatuBarHeight+30);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(197));
        make.height.equalTo(@(59));
    }];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(SCREEN_WIDTH-2*padding));
        make.height.equalTo(@(40+2*50+17+68+44*2+15));
        make.top.equalTo(self.logoView.mas_bottom).offset(70);
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

-(PwdMainView*)mainView{
    if (!_mainView) {
        
        _mainView = [[PwdMainView alloc]initWithFrame:CGRectZero];
        if (!_model) {
            _model = [[LoginRegModel alloc]init];
            _model.type = LoginPhoneType;
            if (AppUserModel) {
                UserModel* tmp = AppUserModel;
                _model.password = tmp.password;
                _model.phoneNo = tmp.user_tel;
            }
        }
        [_mainView configModel:self.model];
        _mainView.block = ^(id data) {
            if ([data isKindOfClass:[NSString class]]) {
                [MXRouter openURL:@"lcwl://PhoneLoginVC"];
            }
        };
    }
    return _mainView;
}


-(void)setNaviStyle{
    self.navigationController.navigationBarHidden = YES;
}

- (void)updateForLanguageChanged {
    [self.mainView updateForLanguageChanged];
    
}

@end
