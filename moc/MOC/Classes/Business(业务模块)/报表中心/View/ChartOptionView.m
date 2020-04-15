//
//  ChartOptionView.m
//  XZF
//
//  Created by mac on 2019/8/7.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ChartOptionView.h"
static NSInteger padding = 15;
static NSInteger height = 30;
@interface ChartOptionView()

@property (nonatomic, strong) UIButton* btn1;

@property (nonatomic, strong) UIButton* btn2;

@property (nonatomic, strong) UIButton* btn3;

@property (nonatomic) NSInteger selectIndex;

@end

@implementation ChartOptionView

-(instancetype)init{
    if (self = [super init]) {
        self.selectIndex = 101;
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.btn1];
    [self addSubview:self.btn2];
    [self addSubview:self.btn3];
    [self refreshIndex:101];
}

-(void)layout{
    
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self);
        make.height.equalTo(@(height));
    }];
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btn1.mas_right).offset(padding);
        make.centerY.equalTo(self);
        make.height.equalTo(@(height));
        make.width.equalTo(self.btn1);
    }];
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btn2.mas_right).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self);
        make.height.equalTo(@(height));
        make.width.equalTo(self.btn2);
    }];
    self.btn2.hidden = NO;
   
}

-(UIButton*)btn1{
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn1 setTitle:@"交易额走势" forState:UIControlStateNormal];
        _btn1.titleLabel.font = [UIFont font14];
        [_btn1 setTitleColor:[UIColor moPlaceHolder] forState:UIControlStateNormal];
        _btn1.layer.masksToBounds = YES;
        _btn1.layer.cornerRadius = 5;
        _btn1.layer.borderWidth = 1;
        _btn1.layer.borderColor = [UIColor moPlaceHolder].CGColor;
        _btn1.tag = 101;
        [_btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btn1;
}

-(UIButton*)btn2{
    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn2 setTitle:@"新增代理走势" forState:UIControlStateNormal];
        _btn2.titleLabel.font = [UIFont font14];
        [_btn2 setTitleColor:[UIColor moPlaceHolder] forState:UIControlStateNormal];
        _btn2.layer.masksToBounds = YES;
        _btn2.layer.cornerRadius = 5;
        _btn2.layer.borderWidth = 1;
        _btn2.layer.borderColor = [UIColor moPlaceHolder].CGColor;
        _btn2.tag = 102;
         [_btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}

-(UIButton*)btn3{
    if (!_btn3) {
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn3 setTitle:@"新增商户走势" forState:UIControlStateNormal];
        _btn3.titleLabel.font = [UIFont font14];
        [_btn3 setTitleColor:[UIColor moPlaceHolder] forState:UIControlStateNormal];
        _btn3.layer.masksToBounds = YES;
        _btn3.layer.cornerRadius = 5;
        _btn3.layer.borderWidth = 1;
        _btn3.layer.borderColor = [UIColor moPlaceHolder].CGColor;
        _btn3.tag = 103;
         [_btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn3;
}

-(void)btnClick:(id)sender{
    UIButton* btn = sender;
    [self refreshIndex:btn.tag];
    if (self.block) {
        self.block(@(btn.tag-101));
    }
}
-(void)refreshIndex:(NSInteger)index{
    UIButton* btn = [self viewWithTag:self.selectIndex];
    [btn setTitleColor:[UIColor moPlaceHolder] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.borderColor = [UIColor moPlaceHolder].CGColor;
    
    btn = [self viewWithTag:index];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor moGreen];
    btn.layer.borderColor = [UIColor clearColor].CGColor;
    self.selectIndex = index;
    
}
@end
