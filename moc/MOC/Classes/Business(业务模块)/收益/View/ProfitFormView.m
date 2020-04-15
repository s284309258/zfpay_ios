//
//  ProfitFormView.m
//  XZF
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ProfitFormView.h"
static NSInteger padding = 15;
@interface ProfitFormView()



@end

@implementation ProfitFormView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.typeLbl];
    [self addSubview:self.moneyLbl];
    [self addSubview:self.detailBtn];
    [self addSubview:self.line];
}

-(void)layout{
    [self.typeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self);
    }];
    [self.moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX);
        make.centerY.equalTo(self);
    }];
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLbl);
        make.right.equalTo(self.detailBtn);
        make.height.equalTo(@(1));
        make.bottom.equalTo(self);
    }];
}

-(UILabel *)typeLbl{
    if (!_typeLbl) {
        _typeLbl = [UILabel new];
        _typeLbl.text = @"收益类型";
        _typeLbl.font = [UIFont font15];
    }
    return _typeLbl;
}

-(UILabel *)moneyLbl{
    if (!_moneyLbl) {
        _moneyLbl = [UILabel new];
        _moneyLbl.text = @"金额(元)";
        _moneyLbl.font = [UIFont font15];
    }
    return _moneyLbl;
}

-(UIButton*)detailBtn{
    if (!_detailBtn) {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailBtn setTitle:@"明细>" forState:UIControlStateNormal];
        [_detailBtn setTitleColor: [UIColor moGreen] forState:UIControlStateNormal];
        _detailBtn.titleLabel.font = [UIFont font15];
        _detailBtn.enabled = NO;
    }
    return _detailBtn;
}

-(MXSeparatorLine*)line{
    if (!_line) {
        _line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
        _line.hidden = YES;
    }
    return _line;
}

-(void)reloadData:(NSString *) type money:(NSString *)money btnTitle: (NSString *)title{
    self.typeLbl.text = type;
    self.moneyLbl.text = money;
    self.detailBtn.hidden = [StringUtil isEmpty:title];
    [self.detailBtn setTitle:title forState:UIControlStateNormal];
}

-(void)reloadData:(NSString *) type money:(NSString *)money {
    
    self.typeLbl.text = type;
    self.moneyLbl.text = money;
    if (!self.detailBtn.hidden) {
        self.typeLbl.font = [UIFont systemFontOfSize:13];
        self.typeLbl.textColor = [UIColor moPlaceHolder];
        [self.typeLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(padding);
            make.centerY.equalTo(self);
            make.width.equalTo(@(80));
        }];
        self.moneyLbl.font = [UIFont systemFontOfSize:13];
        [self.moneyLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.typeLbl.mas_right);
            make.centerY.equalTo(self);
            make.right.equalTo(self);
        }];
        self.detailBtn.hidden = YES;
        [self setNeedsLayout];
    }
}
@end
