//
//  NoBankCardView.m
//  XZF
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "NoBankCardView.h"
@interface NoBankCardView()

@property (nonatomic, strong) UIImageView* img;

@property (nonatomic, strong) UILabel* lbl;

@property (nonatomic, strong) UIButton* btn;

@end

@implementation NoBankCardView

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
    [self addSubview:self.img];
    [self addSubview:self.lbl];
    [self addSubview:self.btn];
}

-(void)layout{
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(160));
        make.height.equalTo(@(110));
        make.top.equalTo(@(50));
        make.centerX.equalTo(self);
    }];
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.img.mas_bottom).offset(15);
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbl.mas_bottom).offset(50);
        make.width.equalTo(@(180));
        make.height.equalTo(@(44));
        make.centerX.equalTo(self);
    }];
}

-(UIImageView*)img{
    if (!_img) {
        _img = [UIImageView new];
        _img.image = [UIImage imageNamed:@"暂无数据"];
    }
    return _img;
}

-(UILabel*)lbl{
    if (!_lbl) {
        _lbl = [UILabel new];
        _lbl.text = @"暂无结算卡";
        _lbl.textColor = [UIColor moPlaceHolder];
        _lbl.textAlignment = NSTextAlignmentCenter;
        _lbl.font = [UIFont systemFontOfSize:16];
    }
    return _lbl;
}

-(UIButton*)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"立即添加" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor darkGreen] forState:UIControlStateNormal];
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = 5;
        _btn.layer.borderColor = [UIColor darkGreen].CGColor;
        _btn.layer.borderWidth = 1.0;
        [_btn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

-(void)add:(id)sender{
    if (self.addBlock) {
        self.addBlock(nil);
    }
}
@end
