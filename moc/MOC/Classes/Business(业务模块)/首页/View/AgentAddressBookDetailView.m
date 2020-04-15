//
//  AgentAddressBookDetailVC.m
//  XZF
//
//  Created by mac on 2019/8/23.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "AgentAddressBookDetailView.h"
#import "QNManager.h"
#import "SPButton.h"
static NSInteger padding = 15;
static NSInteger width = 60;
@interface AgentAddressBookDetailView()

@property (nonatomic,strong) UIImageView* avatar;

@property (nonatomic,strong) UILabel* name;

@property (nonatomic,strong) UIButton* phone;

@property (nonatomic,strong) UILabel* tip;

@property (nonatomic,strong) UILabel* totalMoney;

@property (nonatomic,strong) UILabel* monthMoney;

@property (nonatomic , strong) SPButton* dateBtn;


@end

@implementation AgentAddressBookDetailView

- (id)init{
    self=[super init];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.avatar];
    [self addSubview:self.name];
    [self addSubview:self.phone];
    [self addSubview:self.totalMoney];
    [self addSubview:self.monthMoney];
    [self addSubview:self.dateBtn];
    [self addSubview:self.tip];
}

-(void)layout{
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self).offset(padding);
        make.width.height.equalTo(@(width));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatar);
        make.left.equalTo(self.avatar.mas_right).offset(padding);
    }];
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self.avatar);
        make.width.height.equalTo(@(32));
    }];
    
    [self.totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(padding));
        make.top.equalTo(self.tip.mas_bottom).offset(5);
    }];
    
    [self.monthMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(padding));
        make.bottom.equalTo(self).offset(-15);
    }];
    
    [self.tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name);
        make.top.equalTo(self.avatar.mas_bottom).offset(5);
    }];
    [self.dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.monthMoney);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(@(65));
        make.height.equalTo(@(20));
    }];
}

-(UIImageView*)avatar{
    if (!_avatar) {
        _avatar = [UIImageView new];
        _avatar.backgroundColor = [UIColor moPlaceHolder];
        _avatar.layer.masksToBounds = YES;
        _avatar.layer.cornerRadius = 30;
    }
    return _avatar;
}

-(UILabel*)name{
    if (!_name) {
        _name = [UILabel new];
        _name.font = [UIFont font15];
        _name.textColor = [UIColor moBlack];
        _name.numberOfLines = 0;
    }
    return _name;
}

-(UIButton*)phone{
    if (!_phone) {
        _phone = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phone setBackgroundImage:[UIImage imageNamed:@"拨打"] forState:UIControlStateNormal];
        [_phone addTarget:self action:@selector(tel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phone;
}

-(UILabel*)tip{
    if (!_tip) {
        _tip = [UILabel new];
        _tip.font = [UIFont font12];
        _tip.numberOfLines = 0;
        _tip.textColor = [UIColor moBlack];
    }
    return _tip;
}

-(void)tel:(id)sender{
    if (self.telBlock) {
        self.telBlock(nil);
    }
}

-(UILabel*)totalMoney{
    if (!_totalMoney) {
        _totalMoney = [UILabel new];
        _totalMoney.textColor = [UIColor moBlack];
        _totalMoney.font = [UIFont font12];
        
    }
    return _totalMoney;
}

-(UILabel*)monthMoney{
    if (!_monthMoney) {
        _monthMoney = [UILabel new];
        _monthMoney.textColor = [UIColor moBlack];
        _monthMoney.font = [UIFont font12];
    }
    return _monthMoney;
}

- (UIButton *)dateBtn{
    if (!_dateBtn) {
        _dateBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
        _dateBtn.titleLabel.font = [UIFont font12];
        [_dateBtn setImage:[UIImage imageNamed:@"选择_down"] forState:UIControlStateNormal];
        [_dateBtn setTitleColor:[UIColor moBlack] forState:UIControlStateNormal];
        _dateBtn.layer.borderColor = [UIColor moBlack].CGColor;
        _dateBtn.layer.borderWidth = 0.5;
        _dateBtn.layer.cornerRadius = 4;
        [_dateBtn addTarget:self action:@selector(dateClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dateBtn;
}

-(void)dateClick:(id)sender{
    !self.dateBlock?:self.dateBlock();
}

-(void)reload:(NSString *)avatar name:(NSString* )name merchant:(NSString*)merchant money:(NSString*)money tipAttr:(NSMutableAttributedString*)tip{
    NSString* url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,avatar];
    [_avatar sd_setImageWithURL:[NSURL URLWithString:url]];
    NSMutableAttributedString* nameAttr = [[NSMutableAttributedString alloc]initWithString:name];
    [nameAttr setLineSpacing:10 substring:name alignment:NSTextAlignmentLeft];
    _name.attributedText = nameAttr;
//    _monthMoney.text = [NSString stringWithFormat:@"月交易额:%@",merchant];
    _totalMoney.text = [NSString stringWithFormat:@"总交易额:￥%@",money];
    self.tip.attributedText = tip;
}

-(void)reloadTrade:(NSString*)trade {
    self.monthMoney.text = trade;
}

-(void)reloadMonth:(NSString*)date{
    [_dateBtn setTitle:date forState:UIControlStateNormal];
}

@end
