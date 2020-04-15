//
//  ImgCaptchaView.h
//  AdvertisingMaster
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "TextTextTextTextView.h"

static NSInteger iconWidth = 13;
static NSInteger padding = 15;
@interface TextTextTextTextView()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel         *topLbl;

@property (nonatomic, strong) UILabel         *centerLbl;

@property (nonatomic, strong) UILabel         *bottomLbl;

@property (nonatomic, strong) UILabel         *rightLbl;

@property (nonatomic, strong) MXSeparatorLine *line;

@end

@implementation TextTextTextTextView

- (instancetype)init{
    self=[super init];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.topLbl];
    [self addSubview:self.centerLbl];
    [self addSubview:self.bottomLbl];
    [self addSubview:self.rightLbl];
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
    [self layout];
}

-(void)layout{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(1));
    }];
    
    [self.topLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(200));
        make.bottom.equalTo(self.centerLbl.mas_top).offset(-5);
        make.left.equalTo(self).offset(padding);
    }];
    
    [self.centerLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(200));
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(padding);
    }];
    
    [self.bottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(200));
        make.top.equalTo(self.centerLbl.mas_bottom).offset(5);
        make.left.equalTo(self).offset(padding);
    }];
    
    [self.rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(80));
        make.height.equalTo(@(20));
        make.centerY.equalTo(self.topLbl);
        make.right.equalTo(self).offset(-padding);
    }];
}

-(UILabel*)topLbl{
    if (!_topLbl) {
        _topLbl = [UILabel new];
        _topLbl.textColor = [UIColor moBlack];
        [_topLbl setFont:[UIFont systemFontOfSize:16]];
        _topLbl.text = @"SN码:cs111111";
    }
    return _topLbl;
}

-(UILabel*)centerLbl{
    if (!_centerLbl) {
        _centerLbl = [UILabel new];
        _centerLbl.textColor = [UIColor moPlaceHolder];
        [_centerLbl setFont:[UIFont systemFontOfSize:13]];
        _centerLbl.text = @"商户号";
    }
    return _centerLbl;
}

-(UILabel*)bottomLbl{
    if (!_bottomLbl) {
        _bottomLbl = [UILabel new];
        _bottomLbl.textColor = [UIColor moPlaceHolder];
        [_bottomLbl setFont:[UIFont systemFontOfSize:13]];
        _bottomLbl.text = @"2019.08.06 16:13";
    }
    return _bottomLbl;
}

-(UILabel*)rightLbl{
    if (!_rightLbl) {
        _rightLbl = [UILabel new];
        _rightLbl.textColor = [UIColor moPlaceHolder];
        _rightLbl.textAlignment = NSTextAlignmentRight;
        [_rightLbl setFont:[UIFont systemFontOfSize:15]];
        _rightLbl.text = @"同意";
    }
    return _rightLbl;
}

-(void)reloadTop:(NSString *)top center:(NSString*)center bottom:(NSString *)bottom right:(NSString* )right{
  
}


@end
