//
//  MineHeaderCenterView.m
//  MOC
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "MineHeaderCenterView.h"
@interface MineHeaderCenterView ()

@property (strong, nonatomic) UILabel *titleLbl1;

@property (strong, nonatomic) UILabel *valueLbl1;

@property (strong, nonatomic) UILabel *titleLbl2;

@property (strong, nonatomic) UILabel *valueLbl2;

@property (strong, nonatomic) MXSeparatorLine *line;


@end

@implementation MineHeaderCenterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.titleLbl1];
    [self addSubview:self.valueLbl1];
    [self addSubview:self.titleLbl2];
    [self addSubview:self.valueLbl2];
    self.line = [MXSeparatorLine initVerticalLineHeight:0 orginX:0 orginY:0];
    self.line.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.line];
    [self reloadUI];
}

- (void)reloadUI {
//    self.titleLbl1.text =  AppUserModel.stoneNum;
//    self.titleLbl2.text = AppUserModel.tokenSuperNum;
}

-(void)layout{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.titleLbl1.mas_top).offset(2);
        make.bottom.equalTo(self.valueLbl1.mas_bottom).offset(-2);
        make.width.equalTo(@(0.5));
    }];
    [self.titleLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).multipliedBy(0.5);
        make.centerX.equalTo(self.mas_centerX).multipliedBy(0.5);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
    }];
    [self.valueLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.mas_centerY).multipliedBy(1.5);
        make.top.equalTo(self.titleLbl1.mas_bottom).offset(8);
        make.centerX.equalTo(self.mas_centerX).multipliedBy(0.5);
        make.width.equalTo(self.titleLbl1.mas_width);
    }];
    [self.titleLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).multipliedBy(0.5);
        make.centerX.equalTo(self.mas_centerX).multipliedBy(1.5);
         make.width.equalTo(self.titleLbl1.mas_width);
    }];
    [self.valueLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.mas_centerY).multipliedBy(1.5);
        make.top.equalTo(self.titleLbl2.mas_bottom).offset(8);
        make.centerX.equalTo(self.mas_centerX).multipliedBy(1.5);
        make.width.equalTo(self.titleLbl1.mas_width);
    }];
}

-(UILabel* )titleLbl1{
    if (!_titleLbl1) {
        _titleLbl1 = [[UILabel alloc] init];
        _titleLbl1.textColor = [UIColor whiteColor];
        _titleLbl1.textAlignment = NSTextAlignmentCenter;
        _titleLbl1.text = @"";
        [_titleLbl1 setFont:[UIFont systemFontOfSize:16]];
    }
    return _titleLbl1;
}

-(UILabel* )valueLbl1{
    if (!_valueLbl1) {
        _valueLbl1 = [[UILabel alloc] init];
        _valueLbl1.textColor = [UIColor whiteColor];
        _valueLbl1.textAlignment = NSTextAlignmentCenter;
        _valueLbl1.text = Lang(@"魔晶石(个)");
        [_valueLbl1 setFont:[UIFont systemFontOfSize:13]];
    }
    return _valueLbl1;
}

-(UILabel* )titleLbl2{
    if (!_titleLbl2) {
        _titleLbl2 = [[UILabel alloc] init];
        _titleLbl2.textColor = [UIColor whiteColor];
        _titleLbl2.textAlignment = NSTextAlignmentCenter;
        _titleLbl2.text = @"";
        [_titleLbl2 setFont:[UIFont systemFontOfSize:16]];
    }
    return _titleLbl2;
}

-(UILabel* )valueLbl2{
    if (!_valueLbl2) {
        _valueLbl2 = [[UILabel alloc] init];
        _valueLbl2.textColor = [UIColor whiteColor];
        _valueLbl2.textAlignment = NSTextAlignmentCenter;
        _valueLbl2.text = Lang(@"超级通证(个)");
        [_valueLbl2 setFont:[UIFont systemFontOfSize:13]];
    }
    return _valueLbl2;
}

-(void)reloadTitleLbl1:(NSString *)title1 titleLbl2:(NSString* )title2 value1:(NSString* )value1 value2:(NSString* )value2{
    self.titleLbl1.text = title1;
    self.titleLbl2.text = title2;
    self.valueLbl1.text = value1;
    self.valueLbl2.text = value2;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (self.block) {
        if (point.x < SCREEN_WIDTH/2) {
            self.block(@(0));
        }else{
            self.block(@(1));
        }
    }
}
@end
