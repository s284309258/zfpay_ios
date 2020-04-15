//
//  ImgCaptchaView.h
//  AdvertisingMaster
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ImgTextTextView.h"

static NSInteger iconWidth = 18;
static NSInteger padding = 15;
@interface ImgTextTextView()<UITextFieldDelegate>

@property (nonatomic, strong) MXSeparatorLine *line;

@property (nonatomic) CGSize imgSize;

@end

@implementation ImgTextTextView

- (instancetype)init{
    self=[super init];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.img];
    [self addSubview:self.title];
    [self addSubview:self.desc];
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(1));
    }];
    
}

-(void)left_middle_right{
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.left.equalTo(self);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(iconWidth));
        make.width.equalTo(@(80));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.img.mas_right).offset(padding);
    }];
    
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.title.mas_right);
        make.right.equalTo(self);
    }];
}


-(void)left_top_bottom{
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.img.mas_height);
        make.top.bottom.equalTo(self);
        make.left.equalTo(self);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY);
        make.left.equalTo(self.img.mas_right).offset(10);
        make.right.equalTo(self);
    }];
    
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(10);
        make.left.right.equalTo(self.title);
    }];
    
    self.desc.textAlignment = NSTextAlignmentLeft;
}

-(UIImageView*)img{
    if (!_img) {
        _img = [UIImageView new];
    }
    return _img;
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
        _desc.textColor = [UIColor moBlack];
        _desc.textAlignment = NSTextAlignmentRight;
        [_desc setFont:[UIFont font15]];
        _desc.numberOfLines = 0;
    }
    return _desc;
}


-(void)reloadLeft:(NSString *)img middle:(NSString *)title right:(NSString* )desc{
    self.img.image = [UIImage imageNamed:img];
    self.title.text = title;
    self.desc.text = desc;
    [self left_middle_right];
}

-(void)reloadLeft:(NSString *)img top:(NSString *)top bottom:(NSString *)bottom{
   
    UIImage *tmp = [UIImage imageNamed:img];
    if (!tmp) {
        [self.img sd_setImageWithURL:[NSURL URLWithString:img]];
    }else{
        self.img.image = tmp;
    }
    
    self.title.text = top;
    self.desc.text = bottom;
    [self left_top_bottom];
    
}

-(void)setImageSize:(CGSize)size{
    [self.img mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(size.width));
        make.height.equalTo(@(size.height));
        make.left.equalTo(self);
        make.centerY.equalTo(self.mas_centerY);
    }];
    self.img.layer.masksToBounds = YES;
    self.img.layer.cornerRadius = size.width/2;
    [self setNeedsLayout];
    
}

-(void)isShowLine:(BOOL)isHidden{
    self.line.hidden = isHidden;
}
@end
