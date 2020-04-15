//
//  ImgCaptchaView.h
//  AdvertisingMaster
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "TextTextTextView.h"

static NSInteger iconWidth = 13;
static NSInteger padding = 15;
@interface TextTextTextView()<UITextFieldDelegate>


@property (nonatomic, strong) UILabel         *title;

@property (nonatomic, strong) UILabel         *desc;

@property (nonatomic, strong) MXSeparatorLine *line;

@end

@implementation TextTextTextView

- (instancetype)init{
    self=[super init];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.title];
    [self addSubview:self.desc];
    [self addSubview:self.tip];
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
    [self layout];
}

-(void)layout{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(1));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(200));
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(padding);
    }];
    
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(200));
        make.top.equalTo(self.title.mas_bottom).offset(5);
        make.left.equalTo(self).offset(padding);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    [self.tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(80));
        make.height.equalTo(@(20));
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-padding);
    }];
    
    
}



-(UILabel*)title{
    if (!_title) {
        _title = [UILabel new];
        _title.textColor = [UIColor moBlack];
        [_title setFont:[UIFont systemFontOfSize:16]];
        _title.adjustsFontSizeToFitWidth = YES;
        _title.numberOfLines = 2;
    }
    return _title;
}

-(UILabel*)desc{
    if (!_desc) {
        _desc = [UILabel new];
        _desc.textColor = [UIColor moPlaceHolder];
        [_desc setFont:[UIFont systemFontOfSize:13]];
    }
    return _desc;
}

-(UILabel*)tip{
    if (!_tip) {
        _tip = [UILabel new];
        _tip.textColor = [UIColor moPlaceHolder];
        _tip.textAlignment = NSTextAlignmentRight;
        [_tip setFont:[UIFont systemFontOfSize:13]];
        _tip.text = @"同意";
    }
    return _tip;
}

-(void)reloadTop:(NSString *)top bottom:(NSString *)bottom right:(NSString* )right{
   
    self.desc.text = bottom;
    self.title.text = top;
    if ([right isKindOfClass:[NSMutableAttributedString class]]) {
         self.tip.attributedText = right;
    }else{
         self.tip.text = right;
    }
}


@end
