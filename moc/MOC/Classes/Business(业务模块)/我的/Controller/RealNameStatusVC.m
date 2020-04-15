//
//  RealNameStatusVC.m
//  XZF
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "RealNameStatusVC.h"
#import "InvitationCodeView.h"
#import "RealNameAuthVC.h"
@interface RealNameStatusVC ()

@property (nonatomic,strong) UIImageView* img;

@property (nonatomic,strong) UILabel* lbl;

@property (nonatomic,strong) UILabel* lbl1;

@property (nonatomic,strong) UIView* bottomView1;

@property (nonatomic,strong) UIView* bottomView2;

@property (nonatomic,strong) UIView* topView;

@property (nonatomic,strong) UIButton* loginoutBnt;

@property (nonatomic,strong) InvitationCodeView* nameView;

@property (nonatomic,strong) InvitationCodeView* cardView;


@end

@implementation RealNameStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self layout];
}

-(void)initUI{
    [self setNavBarTitle:@"实名认证"];
    self.topView = [UIView new];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topView);
        make.bottom.equalTo(self.topView.mas_centerY);
        make.width.height.equalTo(@(44));
    }];
    [self.topView addSubview:self.lbl];
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topView);
        make.top.equalTo(self.img.mas_bottom).offset(15);
        make.left.right.equalTo(self.topView);
    }];
    [self.topView addSubview:self.lbl1];
    [self.lbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topView);
        make.top.equalTo(self.lbl.mas_bottom).offset(10);
        make.left.right.equalTo(self.topView);
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(180));
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    if ([self.status.auth_status isEqualToString:@"08"]) {
        [self bottomView1];
    }else if ([self.status.auth_status isEqualToString:@"09"]) {
        [self bottomView2];
    }
    
}

-(void)layout{
    
}

-(UIImageView*)img{
    if (!_img) {
        _img = [UIImageView new];
        NSString* image = @"";
        if ([self.status.auth_status isEqualToString:@"04"]) {
            image = @"审核中1";
        }else if ([self.status.auth_status isEqualToString:@"08"]) {
            image = @"审核失败1";
        }else if ([self.status.auth_status isEqualToString:@"09"]) {
             image = @"认证成功1";
        }
        _img.image = [UIImage imageNamed:image];
    }
    return _img;
}

-(UILabel*)lbl{
    if (!_lbl) {
        _lbl = [UILabel new];
        _lbl.font = [UIFont font18];
        _lbl.textColor = [UIColor moBlack];
        _lbl.textAlignment = NSTextAlignmentCenter;
        NSString* str = @"";
        if ([self.status.auth_status isEqualToString:@"04"]) {
            str = @"申请审核中";
        }else if ([self.status.auth_status isEqualToString:@"08"]) {
            str = @"审核失败";
        }else if ([self.status.auth_status isEqualToString:@"09"]) {
            str = @"实名认证成功";
        }
        _lbl.text = str;
    }
    return _lbl;
}

-(UILabel*)lbl1{
    if (!_lbl1) {
        _lbl1 = [UILabel new];
        _lbl1.font = [UIFont systemFontOfSize:13];
        _lbl1.textColor = [UIColor moPlaceHolder];
        _lbl1.numberOfLines = 2;
        _lbl1.textAlignment = NSTextAlignmentCenter;
        NSString* str = @"";
        if ([self.status.auth_status isEqualToString:@"04"]) {
            str = @"请耐心等待";
        }else if ([self.status.auth_status isEqualToString:@"08"]) {
            str = @"抱歉，您的资料信息存在不符\n请重新提交完整有效的资料";
        }else if ([self.status.auth_status isEqualToString:@"09"]) {
            str = @"";
        }
        _lbl1.text = str;
    }
    return _lbl1;
}

-(UIView*)bottomView1{
    if (!_bottomView1) {
        _bottomView1 = [UIView new];
        _bottomView1.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_bottomView1];
        [_bottomView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(132));
            make.top.equalTo(self.topView.mas_bottom);
        }];
        [_bottomView1 addSubview:self.loginoutBnt];
        [self.loginoutBnt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_bottomView1).offset(15);
            make.right.equalTo(_bottomView1).offset(-15);
            make.centerY.equalTo(_bottomView1);
            make.height.equalTo(@(44));
        }];
    }
    return _bottomView1;
}

- (UIButton *)loginoutBnt {
    if(!_loginoutBnt) {
        _loginoutBnt=[UIButton buttonWithType:UIButtonTypeCustom];
        _loginoutBnt.frame = CGRectMake(-1, 0, SCREEN_WIDTH+2, 44);
        [_loginoutBnt setTitle:Lang(@"重新提交申请") forState:UIControlStateNormal];
        _loginoutBnt.titleLabel.font = [UIFont systemFontOfSize:17];
        _loginoutBnt.backgroundColor = [UIColor darkGreen];
        [_loginoutBnt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginoutBnt.layer.masksToBounds = YES;
        _loginoutBnt.layer.cornerRadius = 5;
        [_loginoutBnt addTarget:self action:@selector(resubmit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginoutBnt;
}

-(UIView*)bottomView2{
    if (!_bottomView2) {
        _bottomView2 = [UIView new];
        _bottomView2.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_bottomView2];
        [_bottomView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(88));
            make.top.equalTo(self.topView.mas_bottom);
        }];
        [_bottomView2 addSubview:self.nameView];
        [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_bottomView2).offset(15);
            make.right.equalTo(_bottomView2).offset(-15);
            make.top.equalTo(_bottomView2);
            make.height.equalTo(@(44));
        }];
        [_bottomView2 addSubview:self.cardView];
        [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.nameView);
            make.top.equalTo(self.nameView.mas_bottom);
            make.height.equalTo(@(44));
        }];
    }
    return _bottomView2;
}

-(InvitationCodeView*)nameView{
    if (!_nameView) {
        _nameView = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
        [_nameView reloadTitle:@"真实姓名" placeHolder:@""];
        _nameView.tf.textAlignment = NSTextAlignmentRight;
        _nameView.tf.enabled = NO;
        _nameView.tf.text = AppUserModel.real.real_name;
        _nameView.tf.textColor = [UIColor moPlaceHolder];
        [_nameView isHiddenLine:NO];
    }
    return _nameView;
}

-(InvitationCodeView*)cardView{
    if (!_cardView) {
        _cardView = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
        [_cardView reloadTitle:@"身份证号" placeHolder:@""];
        _cardView.tf.textAlignment = NSTextAlignmentRight;
        _cardView.tf.enabled = NO;
        _cardView.tf.text = AppUserModel.real.id_card;
         _cardView.tf.textColor = [UIColor moPlaceHolder];
    }
    return _cardView;
}

-(void)resubmit:(id)sender{
    NSArray* controllers =  self.navigationController.viewControllers;
    NSMutableArray* tmpControllers = [[NSMutableArray alloc]initWithArray:controllers];
    [tmpControllers removeLastObject];
    [tmpControllers addObject:[RealNameAuthVC new]];
    [self.navigationController setViewControllers:tmpControllers];
}
@end
