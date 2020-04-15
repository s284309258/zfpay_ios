//
//  MineTopView.m
//  RatelBrother
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "MineInfoCell.h"
#import "UIView+Utils.h"
#import "UIView+AZGradient.h"
#import "MXAlertViewHelper.h"
#import "PersonalCenterHelper.h"
static NSInteger iconWidth = 60;
static float EdegePadding = 15;

@interface MineInfoCell ()

@property (nonatomic,strong) UIImageView *avatarImg;

@property (nonatomic,strong) UILabel     *nameLbl;

@property (nonatomic,strong) UILabel     *inviteLbl;

@property (nonatomic,strong) UIButton    *arrowBtn;

@property (nonatomic,strong) UIButton    *stateBtn;

@property (nonatomic,strong) UIImageView *backImg;

@end

@implementation MineInfoCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createUI];
        [self layout];
        [self reload];
    }
    return self;
}

-(void)createUI{
    [self addSubview:self.backImg];
    [self addSubview:self.avatarImg];
    [self addSubview:self.nameLbl];
    [self addSubview:self.inviteLbl];
    [self addSubview:self.arrowBtn];
    [self addSubview:self.stateBtn];
}

-(void)layout{
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.left.equalTo(self).offset(EdegePadding);
        make.centerY.equalTo(self);
    }];
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImg.mas_right).offset(EdegePadding);
        make.centerY.equalTo(self.avatarImg).offset(-10);
    }];
    [self.inviteLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLbl);
         make.centerY.equalTo(self.avatarImg).offset(10);
    }];
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-EdegePadding);
        make.width.height.equalTo(@(18));
        make.centerY.equalTo(self );
    }];
    [self.stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLbl);
        make.top.equalTo(self.inviteLbl.mas_bottom).offset(5);
    }];
}

- (void)settingBntClick:(UIButton *)bnt {
    @weakify(self)
    [MXAlertViewHelper showAlertViewWithMessage:Lang(@"你是否确定切换账号?") title:Lang(@"提示") okTitle:Lang(@"确定") cancelTitle:Lang(@"取消") completion:^(BOOL cancelled, NSInteger buttonIndex) {
        @strongify(self);
        if (buttonIndex == 1) {
            AppDelegate* app = MoApp;
            if ([app respondsToSelector:@selector(enterLoginPage)]) {
                [app performSelector:@selector(enterLoginPage) withObject:nil afterDelay:0];
                
            }
        }
    }];
}

-(UIImageView *)avatarImg{
    if (!_avatarImg) {
        _avatarImg = [UIImageView new];
        _avatarImg.layer.masksToBounds = YES;
        _avatarImg.layer.cornerRadius = iconWidth/2;
        _avatarImg.layer.borderWidth = 1;
        _avatarImg.layer.borderColor = [UIColor whiteColor].CGColor;
        _avatarImg.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        _avatarImg.image = [UIImage imageNamed:@"icon_login"];
    }
    return _avatarImg;
}

-(UIImageView *)backImg{
    if (!_backImg) {
        _backImg = [UIImageView new];
        _backImg.image = [UIImage imageNamed:@"背景"];
    }
    return _backImg;
}

-(UILabel *)nameLbl{
    if (!_nameLbl) {
        _nameLbl = [UILabel new];
        _nameLbl.text = @"ZBQG000001";
        _nameLbl.textColor = [UIColor whiteColor];
        _nameLbl.font = [UIFont systemFontOfSize:21];
        
    }
    return _nameLbl;
}

-(UILabel *)inviteLbl{
    if (!_inviteLbl) {
        _inviteLbl = [UILabel new];
        _inviteLbl.text = @"133****2681";
         _inviteLbl.textColor = [UIColor whiteColor];
        _inviteLbl.font = [UIFont systemFontOfSize:13];
    }
    return _inviteLbl;
}

- (UIButton *)arrowBtn {
    if(!_arrowBtn) {
        _arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arrowBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        
    }
    return _arrowBtn;
}

- (UIButton *)stateBtn {
    if(!_stateBtn) {
        _stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_stateBtn setImage:[UIImage imageNamed:@"未实名"] forState:UIControlStateNormal];
        [_stateBtn setTitle:@"实名" forState:UIControlStateNormal];
        _stateBtn.titleLabel.font = [UIFont font11];
    }
    return _stateBtn;
}

-(void)reload {
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:AppUserModel.head_photo]];
    self.nameLbl.text = (![StringUtil isEmpty:AppUserModel.real.real_name])?AppUserModel.real.real_name:[PersonalCenterHelper getAuthStatus:AppUserModel.real.auth_status];
    self.inviteLbl.text = AppUserModel.user_tel;
    [self.stateBtn setTitle:[PersonalCenterHelper getAuthStatus:AppUserModel.real.auth_status] forState:UIControlStateNormal];
   
}
@end
