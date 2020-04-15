//
//  BankCardView.m
//  XZF
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BankCardView.h"
static NSInteger padding = 15;
static NSInteger iconWidth = 40;
@interface BankCardView()

@property(nonatomic, strong) UIImageView *back;

@property(nonatomic, strong) UIImageView *image;

@property(nonatomic, strong) UILabel     *title;

@property(nonatomic, strong) UILabel     *desc;

@property(nonatomic, strong) UILabel     *num;

@property(nonatomic, strong) UIButton    *btn;

@property(nonatomic, strong) UIButton    *btn1;

@end

@implementation BankCardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.back];
    [self addSubview:self.image];
    [self addSubview:self.title];
    [self addSubview:self.desc];
    [self addSubview:self.num];
    [self addSubview:self.btn];
    [self addSubview:self.btn1];
}

-(void)layout{
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(padding);
        make.width.height.equalTo(@(iconWidth));
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image.mas_right).offset(padding);
        make.centerY.equalTo(self.image).offset(-10);
        make.right.equalTo(self.btn1.mas_left);
    }];
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.title);
        make.centerY.equalTo(self.image).offset(10);
    }];
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image);
        make.bottom.equalTo(self).offset(-padding);
        make.right.equalTo(self.btn.mas_left);
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.width.equalTo(@(60));
        make.height.equalTo(@(30));
        make.centerY.equalTo(self.num);
    }];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self).offset(padding);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
    }];
    
}

-(UIImageView*)back{
    if (!_back) {
        _back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"卡片背景"]];
    }
    return _back;
}

-(UIImageView*)image{
    if (!_image) {
        _image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"银行卡_1"]];
    }
    return _image;
}

-(UILabel*)title{
    if (!_title) {
        _title = [UILabel new];
        _title.font = [UIFont systemFontOfSize:18];
        _title.textColor = [UIColor whiteColor];
        
    }
    return _title;
}

-(UILabel*)desc{
    if (!_desc) {
        _desc = [UILabel new];
        _desc.text = @"银行卡";
        _desc.font = [UIFont systemFontOfSize:13];
        _desc.textColor = [UIColor whiteColor];
    }
    return _desc;
}

-(UILabel*)num{
    if (!_num) {
        _num = [UILabel new];
        _num.font = [UIFont systemFontOfSize:24];
        _num.textColor = [UIColor whiteColor];
        _num.adjustsFontSizeToFitWidth = YES;
    }
    return _num;
}

-(UIButton*)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [_btn setTitle:@"删除" forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

-(UIButton*)btn1{
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn1 setBackgroundImage:[UIImage imageNamed:@"默认"] forState:UIControlStateNormal];
        
    }
    return _btn1;
}


-(void)reload:(UserCardModel*)model{
    self.title.text = model.bank_name;
    if ([model.is_default isEqualToString:@"1"]) {
        self.btn1.hidden = NO;
    }else{
        self.btn1.hidden = YES;
    }
    self.num.text = model.account;
    NSString* status = @"已添加";
    if ([model.status isEqualToString:@"00"]) {
        status = @"待审核";
    }else if([model.status isEqualToString:@"08"]){
        status = @"审核失败";
    }
    self.desc.text = status;
}

-(void)delete:(id)sender{
    if (self.deleteBlock) {
        self.deleteBlock(nil);
    }
}
@end
