//
//  RecallBottomView.m
//  XZF
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "RecallBottomView.h"

static NSInteger padding = 15;
@interface RecallBottomView()


@property(nonatomic, strong) UIButton    *btn1;

@property(nonatomic, strong) UIButton    *btn2;


@end
@implementation RecallBottomView


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
    [self addSubview:self.btn];
    [self addSubview:self.btn1];
    [self addSubview:self.btn2];
}

-(void)layout{
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.width.equalTo(@(80));
        make.height.equalTo(@(20));
        make.centerY.equalTo(self);
    }];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btn2.mas_left).offset(-10);
        make.centerY.equalTo(self);
        make.width.equalTo(@(100));
        make.height.equalTo(@(44));
    }];
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self);
        make.width.equalTo(@(100));
        make.height.equalTo(@(44));
    }];
}


- (SPButton *)btn{
    if (!_btn) {
        _btn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
        _btn.frame = CGRectMake(0, 0, 80, 45);
        _btn.titleLabel.font = [UIFont font14];
        [_btn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateSelected];
        [_btn setImage:[UIImage imageNamed:@"None"] forState:UIControlStateNormal];
        [_btn setTitle:@"全选(0)" forState:UIControlStateNormal];
        [_btn setTitle:@"全选(0)" forState:UIControlStateSelected];
        [_btn setTitleColor:[UIColor moBlack] forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor moBlack] forState:UIControlStateSelected];
        [_btn addTarget:self action:@selector(allClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

-(void)allClick:(id)sender{
    _btn.selected = !_btn.selected;
    if (self.allBlock) {
        self.allBlock(nil);
    }
}

-(void)updateAllNum:(int)count{
    if (_btn.selected) {
        [_btn setTitle:[NSString stringWithFormat:@"全选(%d)",count] forState:UIControlStateSelected];
    }else{
        [_btn setTitle:[NSString stringWithFormat:@"全选(%d)",count] forState:UIControlStateNormal];
    }
}

-(UIButton*)btn1{
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn1 setTitle:@"拒绝" forState:UIControlStateNormal];
        _btn1.backgroundColor = [UIColor colorWithHexString:@"#E9A231"];
        _btn1.titleLabel.font = [UIFont systemFontOfSize:16];
        _btn1.layer.masksToBounds = YES;
        _btn1.layer.cornerRadius = 5;
        [_btn1 addTarget:self action:@selector(disagree:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

-(UIButton*)btn2{
    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn2 setTitle:@"同意" forState:UIControlStateNormal];
        _btn2.backgroundColor = [UIColor colorWithHexString:@"#1CCC9A"];
        _btn2.titleLabel.font = [UIFont systemFontOfSize:16];
        _btn2.layer.masksToBounds = YES;
        _btn2.layer.cornerRadius = 5;
        [_btn2 addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}


-(void)disagree:(id)sender{
    if (self.disagreeBlock) {
        self.disagreeBlock(nil);
    }
}

-(void)agree:(id)sender{
    if (self.agreeBlock) {
        self.agreeBlock(nil);
    }
}
@end
