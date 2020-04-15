//
//  NewRFCellView.m
//  XZF
//
//  Created by mac on 2020/1/8.
//  Copyright © 2020 AlphaGo. All rights reserved.
//

#import "NewRFCellView.h"
static NSInteger padding = 15;
@interface NewRFCellView()

@property (nonatomic,strong) UILabel* todayMoney;

@property (nonatomic,strong) UILabel* totalMoney;

@property (nonatomic,strong) MXSeparatorLine* line;

@property (nonatomic,strong) UILabel* leftBottomLbl;

@property (nonatomic,strong) UILabel* centerBottomLbl;

@property (nonatomic,strong) UILabel* rightBottomLbl;

@property (nonatomic,strong) UIButton* openBtn;


@end

@implementation NewRFCellView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.todayMoney];
    [self addSubview:self.totalMoney];
    [self addSubview:self.leftBottomLbl];
    [self addSubview:self.centerBottomLbl];
    [self addSubview:self.rightBottomLbl];
    [self addSubview:self.line];

//    [self addSubview:self.leftBottomLbl];
//    [self addSubview:self.rightBottomLbl];
    [self addSubview:self.openBtn];
    [self.todayMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(padding));
        make.centerX.equalTo(self);
        make.left.right.equalTo(self);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.todayMoney.mas_bottom).offset(padding);
        make.centerX.equalTo(self);
        make.left.equalTo(@(padding));
        make.right.equalTo(@(-padding));
        make.height.equalTo(@(.5));
    }];
    
    [self.totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(padding);
        make.centerX.equalTo(self);
        make.left.right.equalTo(self);
    }];
    [self.leftBottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).multipliedBy(.5);
        make.top.equalTo(self.totalMoney.mas_bottom).offset(15);
    }];
    [self.centerBottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.totalMoney.mas_bottom).offset(15);
    }];
    [self.rightBottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).multipliedBy(1.5);
        make.top.equalTo(self.totalMoney.mas_bottom).offset(15);
    }];
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(padding));
        make.bottom.centerX.equalTo(self);
    }];
}

-(UILabel *)todayMoney{
    if (!_todayMoney) {
        _todayMoney = [UILabel new];
        _todayMoney.font = [UIFont boldFont17];
        _todayMoney.textColor = [UIColor whiteColor];
        _todayMoney.textAlignment = NSTextAlignmentCenter;
    }
    return _todayMoney;
}

-(UILabel *)totalMoney{
    if (!_totalMoney) {
        _totalMoney = [UILabel new];
        _totalMoney.font = [UIFont boldFont17];
        _totalMoney.textColor = [UIColor whiteColor];
        _totalMoney.textAlignment = NSTextAlignmentCenter;
    }
    return _totalMoney;
}

-(UILabel *)leftBottomLbl{
    if (!_leftBottomLbl) {
        _leftBottomLbl = [UILabel new];
        _leftBottomLbl.font = [UIFont font12];
        _leftBottomLbl.textColor = [UIColor whiteColor];
        _leftBottomLbl.textAlignment = NSTextAlignmentCenter;
        _leftBottomLbl.numberOfLines = 0;
    }
    return _leftBottomLbl;
}

-(UILabel *)centerBottomLbl{
    if (!_centerBottomLbl) {
        _centerBottomLbl = [UILabel new];
        _centerBottomLbl.font = [UIFont font12];
        _centerBottomLbl.textColor = [UIColor whiteColor];
        _centerBottomLbl.textAlignment = NSTextAlignmentCenter;
        _centerBottomLbl.numberOfLines = 0;
    }
    return _centerBottomLbl;
}


-(UILabel *)rightBottomLbl{
    if (!_rightBottomLbl) {
        _rightBottomLbl = [UILabel new];
        _rightBottomLbl.font = [UIFont font12];
        _rightBottomLbl.textColor = [UIColor whiteColor];
        _rightBottomLbl.textAlignment = NSTextAlignmentCenter;
        _rightBottomLbl.numberOfLines = 0;
    }
    return _rightBottomLbl;
}

-(MXSeparatorLine*)line{
    if (!_line) {
        _line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
        _line.backgroundColor = [UIColor whiteColor];
    }
    return _line;
}

-(UIButton* )openBtn{
    if (!_openBtn) {
        _openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_openBtn setImage:[UIImage imageNamed:@"选择_down"] forState:UIControlStateNormal];
        [_openBtn addTarget:self action:@selector(open:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openBtn;
}

-(void)open:(id)sender{
    !self.open?:self.open();
}


-(void)reload:(RealNameModel*)model{
    {
        if (model) {
            NSString* str1 = [NSString stringWithFormat:@"今日交易额:%@",model.tradeAmountDay?:@"0"];
            NSString* str2 = [NSString stringWithFormat:@"累计交易额:%@",model.tradeAmountAll?:@"0"];
            self.todayMoney.text = str1;
            self.totalMoney.text = str2;
        }
        
    }
}

-(void)reloadCTPos:(NSString*)ctpos mPos:(NSString*)mpos ePos:(NSString*)epos{
    self.leftBottomLbl.text =  [NSString stringWithFormat:@"传统POS月台均\n%@",ctpos];
    self.centerBottomLbl.text =  [NSString stringWithFormat:@"MPOS月台均\n%@",mpos];
    self.rightBottomLbl.text =  [NSString stringWithFormat:@"EPOS月台均\n%@",epos];
}

@end
