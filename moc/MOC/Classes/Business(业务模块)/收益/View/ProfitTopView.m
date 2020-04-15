//
//  ProfitTopView.m
//  XZF
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ProfitTopView.h"
static NSInteger padding = 15;
@interface ProfitTopView()

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *label1;

@property (nonatomic, strong) UILabel *label2;

@property (nonatomic, strong) UILabel *label3;

@property (nonatomic, strong) UILabel *label4;

@property (nonatomic, strong) UIButton *chargeBtn;

@property (nonatomic, strong) MXSeparatorLine *line;

@end
@implementation ProfitTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.titleLbl];
    [self addSubview:self.label1];
    [self addSubview:self.label2];
    [self addSubview:self.chargeBtn];
    [self addSubview:self.line];
    [self addSubview:self.label3];
    [self addSubview:self.label4];
}

-(void)layout{
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(padding);
        make.width.equalTo(@(90));
        make.height.equalTo(@(30));
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self.mas_centerY);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.label1);
        make.left.equalTo(self.mas_centerX);
    }];
    
    [self.chargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self.label1);
        make.width.equalTo(@(50));
        make.height.equalTo(@(22));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label1);
        make.right.equalTo(self.chargeBtn);
        make.top.equalTo(self.label1.mas_bottom).offset(padding);
        make.height.equalTo(@(1));
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label1);
        make.top.equalTo(self.line.mas_bottom).offset(padding);
    }];
    
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label2);
        make.centerY.equalTo(self.label3);
    }];
    
}

- (UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = [UIFont systemFontOfSize:15];
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.text = Lang(@"我的收益");
        _titleLbl.layer.masksToBounds = YES;
        _titleLbl.layer.cornerRadius = 5;
        _titleLbl.backgroundColor = [UIColor moGreen];
    }
    
    return _titleLbl;
}

- (UILabel *)label1{
    if (!_label1) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectZero];
        _label1.textAlignment = NSTextAlignmentCenter;
        _label1.font = [UIFont font12];
        _label1.textColor = [UIColor whiteColor];
    }
    return _label1;
}

- (UILabel *)label2{
    if (!_label2) {
        _label2 = [[UILabel alloc] initWithFrame:CGRectZero];
        _label2.textAlignment = NSTextAlignmentCenter;
        _label2.font = [UIFont font12];
        _label2.textColor = [UIColor whiteColor];
    }
    return _label2;
}

- (UILabel *)label3{
    if (!_label3) {
        _label3 = [[UILabel alloc] initWithFrame:CGRectZero];
        _label3.textAlignment = NSTextAlignmentCenter;
        _label3.font = [UIFont systemFontOfSize:17];
        _label3.textColor = [UIColor whiteColor];
    }
    return _label3;
}

- (UILabel *)label4{
    if (!_label4) {
        _label4 = [[UILabel alloc] initWithFrame:CGRectZero];
        _label4.textAlignment = NSTextAlignmentCenter;
        _label4.font = [UIFont systemFontOfSize:17];
        _label4.textColor = [UIColor whiteColor];
    }
    return _label4;
}

-(UIButton* )chargeBtn{
    if (!_chargeBtn) {
        _chargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chargeBtn setBackgroundColor:[UIColor whiteColor]];
        [_chargeBtn setTitleColor:[UIColor moGreen] forState:UIControlStateNormal];
        _chargeBtn.titleLabel.font = [UIFont font12];
        [_chargeBtn setTitle:@"提现" forState:UIControlStateNormal];
        _chargeBtn.layer.masksToBounds = YES;
        _chargeBtn.layer.cornerRadius = 3;
        [_chargeBtn addTarget:self action:@selector(charge:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chargeBtn;
}

-(MXSeparatorLine *)line{
    if (!_line) {
        _line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
        _line.backgroundColor = [UIColor colorWithHexString:@"#60DBBB"];
    }
    return _line;
}

-(void)charge:(id)sender{
    if (self.block) {
        self.block(nil);
    }
}

-(void)reloadToday_benefit:(NSString*)today withdraw_money:(NSString*)withdraw_money total_benefit:(NSString*)total_benefit settle_money:(NSString *)settle_money{
    if ([StringUtil isEmpty:today]) {
        today = @"0";
    }
    if ([StringUtil isEmpty:withdraw_money]) {
        withdraw_money = @"0";
    }
    if ([StringUtil isEmpty:total_benefit]) {
        total_benefit = @"0";
    }
    if ([StringUtil isEmpty:settle_money]) {
        settle_money = @"0";
    }
    _label1.text = [NSString stringWithFormat:@"今日收益:%@",today];
    _label2.text = [NSString stringWithFormat:@"可提现:%@",withdraw_money];
    _label3.attributedText = [self makeStr1:@"累计收益:" str2:total_benefit];
    _label4.attributedText = [self makeStr1:@"累计提现:" str2:settle_money];
    
    
}

-(NSMutableAttributedString *)makeStr1:(NSString* )str1 str2:(NSString* )str2{
    NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",str1,str2]];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:0];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attr length])];
    [attr addColor:[UIColor whiteColor] substring:str1];
    [attr addColor:[UIColor whiteColor] substring:str2];
    [attr addFont:[UIFont systemFontOfSize:12] substring:str1];
    [attr addFont:[UIFont systemFontOfSize:20] substring:str2];
    return attr;
}
@end
