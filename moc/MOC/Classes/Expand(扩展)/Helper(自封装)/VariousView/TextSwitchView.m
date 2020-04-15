//
//  TextSwitchView.m
//  MOC
//
//  Created by mac on 2019/7/27.
//  Copyright © 2019 AlphaGo. All rights reserved.
//
static NSInteger padding = 15;
#import "TextSwitchView.h"
@interface TextSwitchView()

@property (nonatomic, strong) UILabel         *lbl;

@end
@implementation TextSwitchView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self layout];
    }
    
    return self;
}

-(void)initUI{
    [self addSubview:self.lbl];
    [self addSubview:self.btn];
}

-(void)layout{
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(padding);
    }];
//    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.mas_centerY);
//        make.right.equalTo(self).offset(-padding);
//        make.width.equalTo(@(51));
//        make.height.equalTo(@(44));
//    }];
}

-(UILabel*)lbl{
    if (!_lbl) {
        _lbl = [UILabel new];
        _lbl.textColor = [UIColor moBlack];
        [_lbl setFont:[UIFont font15]];
        _lbl.text = @"交易量达标返现领取";
    }
    return _lbl;
}

-(UISwitch*)btn{
    if (!_btn) {
        _btn = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50-2*padding, (55-28)/2, 50, 28)];
        [_btn addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _btn;
}

-(void)valueChanged:(id)sender{
    UISwitch* tmp = (UISwitch*)sender;
    if (self.block) {
        self.block(@(tmp.on));
    }
}

-(void)reload:(NSString* )title state:(NSString*)state{
    self.lbl.text = title;
    if ([state isEqualToString:@"0"]) {
        self.btn.on = NO;
    }else{
        self.btn.on = YES;
    }
}

-(void)setLeftPadding:(NSInteger)left{
    [self.lbl mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self);
           make.left.equalTo(self).offset(left);
       }];
}
@end
