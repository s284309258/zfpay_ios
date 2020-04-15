//
//  SettingHeader.m
//  XZF
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "RecallSelectView.h"
static NSInteger padding = 15;
@interface RecallSelectView()

@property (nonatomic ,strong) UIImageView* img;

@property (nonatomic ,strong) UILabel* title;

@property (nonatomic ,strong) UILabel* desc;

@property (nonatomic ,strong) MXSeparatorLine* line;

@end

@implementation RecallSelectView

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
    [self addSubview:self.img];
    [self addSubview:self.title];
    [self addSubview:self.desc];
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
}

-(void)layout{
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self);
        make.width.height.equalTo(@(20));
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img.mas_right).offset(padding);
        make.centerY.equalTo(self).offset(-5);
        make.right.equalTo(self).offset(-padding);
    }];
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img.mas_right).offset(padding);
        make.top.equalTo(self.title.mas_bottom).offset(5);
        make.right.equalTo(self);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img);
        make.right.equalTo(self.title);
        make.bottom.equalTo(self);
        make.height.equalTo(@(1));
    }];
}

-(UIImageView *)img{
    if (!_img) {
        _img = [UIImageView new];
//        _img.layer.masksToBounds = YES;
//        _img.layer.cornerRadius = 10;
        _img.image = [UIImage imageNamed:@"勾选"];
    }
    return _img;
}

-(UILabel *)title{
    if (!_title) {
        _title = [UILabel new];
        _title.font = [UIFont font15];
        _title.textColor = [UIColor moBlack];
        _title.text = @"SN300000000000";
    }
    return _title;
}

-(UILabel *)desc{
    if (!_desc) {
        _desc = [UILabel new];
        _desc.font = [UIFont systemFontOfSize:13];
        _desc.textColor = [UIColor moPlaceHolder];
        _desc.text = @"头像";
    }
    return _desc;
}

-(void)reload:(NSString* )state title:(NSString *)title desc:(NSString *)desc{
    self.title.text = title;
    self.desc.text = desc;
    _img.image = [UIImage imageNamed:state];
}


@end
