//
//  CashOutHeader.m
//  XZF
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "CashOutHeader.h"
static NSInteger iconWidth = 50;
static NSInteger padding = 15;
@interface CashOutHeader()

@property (nonatomic , strong) UIImageView* logoImg;

@property (nonatomic , strong) UILabel*     titleLbl;

@property (nonatomic , strong) UILabel*     descLbl;

@property (nonatomic , strong) UIImageView* arrowImg;

@end
@implementation CashOutHeader

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.logoImg];
    [self addSubview:self.titleLbl];
    [self addSubview:self.descLbl];
    [self addSubview:self.arrowImg];
}

-(void)layout{
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImg.mas_right).offset(padding);
        make.top.equalTo(self.logoImg);
        make.right.equalTo(self.arrowImg.mas_left);
    }];
    
    [self.descLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl);
        make.bottom.equalTo(self.logoImg);
    }];
    
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self);
        make.width.height.equalTo(@(18));
    }];
}

-(UIImageView *)logoImg{
    if (!_logoImg) {
        _logoImg = [UIImageView new];
        _logoImg.image = [UIImage imageNamed:@"银行卡_1"];
    }
    return _logoImg;
}

-(UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.font = [UIFont font18];
    }
    return _titleLbl;
}

-(UILabel *)descLbl{
    if (!_descLbl) {
        _descLbl = [UILabel new];
        _descLbl.font = [UIFont font15];
        _descLbl.textColor = [UIColor moPlaceHolder];
    }
    return _descLbl;
}

-(UIImageView *)arrowImg{
    if (!_arrowImg) {
        _arrowImg = [UIImageView new];
        _arrowImg.image = [UIImage imageNamed:@"更换"];
    }
    return _arrowImg;
}

-(void)reload:(UserCardModel*)model{
    self.titleLbl.text = model.bank_name;
    self.descLbl.text = model.account;
}
@end
