//
//  ImgCaptchaView.h
//  AdvertisingMaster
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "TextTextImgView.h"

static NSInteger iconWidth = 13;
static NSInteger padding = 15;
@interface TextTextImgView()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView     *arrow;



@property (nonatomic, strong) MXSeparatorLine *line;

@end

@implementation TextTextImgView

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
    [self addSubview:self.arrow];
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
        make.width.equalTo(@(100));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self);
    }];
    
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.title.mas_right);
        make.right.equalTo(self.arrow.mas_left).offset(-10).priority(900);
        make.right.equalTo(self).priority(800);
        make.bottom.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(15);
    }];
    
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.right.equalTo(self);
        make.centerY.equalTo(self.mas_centerY);
    }];
}



-(UILabel*)title{
    if (!_title) {
        _title = [UILabel new];
        _title.textColor = [UIColor moBlack];
        [_title setFont:[UIFont font15]];
    }
    return _title;
}

-(UILabel*)desc{
    if (!_desc) {
        _desc = [UILabel new];
        _desc.textColor = [UIColor moPlaceHolder];
        _desc.textAlignment = NSTextAlignmentRight;
        _desc.numberOfLines = 0;
        [_desc setFont:[UIFont systemFontOfSize:13]];
//        _desc.adjustsFontSizeToFitWidth = YES;
    }
    return _desc;
}

-(UIImageView*)arrow{
    if (!_arrow) {
        _arrow = [UIImageView new];
        _arrow.image = [UIImage imageNamed:@"选择"];
    }
    return _arrow;
}

-(void)reloadImg:(NSString *)img title:(NSString *)title desc:(NSString* )desc{
    self.title.text = title;
    if ([StringUtil isEmpty:desc]) {
        [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrow.mas_left).offset(-10).priority(900);
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self);
        }];
    }else{
        [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(100));
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self);
        }];
    }
    self.desc.text = desc;
    self.title.adjustsFontSizeToFitWidth = YES;
    if ([StringUtil isEmpty:img]) {
        if (self.arrow.superview) {
            self.arrow.hidden = YES;
//            [self.arrow removeFromSuperview];
        }
    }else{
        self.arrow.hidden = NO;
        self.arrow.image = [UIImage imageNamed:img];
    }
}

-(void)reloadTop:(NSString *)title bottom:(NSString *)desc right:(NSString* )img{
    self.arrow.image = [UIImage imageNamed:img];
    if ([title isKindOfClass:[NSMutableAttributedString class]]) {
        
        self.title.attributedText = title;
    }else{
        
        self.title.text = title;
    }
    self.desc.text = desc;
    self.desc.textAlignment = NSTextAlignmentLeft;
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrow.mas_left);
        make.centerY.equalTo(self).offset(-10);
        make.left.equalTo(self).offset(0);
    }];
    
    [self.desc mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.title);
        make.centerY.equalTo(self).offset(10);
        make.left.equalTo(self).offset(0);
    }];
    
    [self.arrow mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-0);
    }];
}


-(void)isHiddenLine:(BOOL)hidden{
    self.line.hidden = hidden;
}


@end
