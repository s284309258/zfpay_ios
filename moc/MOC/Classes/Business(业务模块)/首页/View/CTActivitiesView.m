//
//  CTActivitiesView.m
//  XZF
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "CTActivitiesView.h"
#import "NSDate+String.h"
@interface CTActivitiesView()

@property (nonatomic , strong) UIImageView* image;

@property (nonatomic , strong) UILabel* title;

@property (nonatomic , strong) UILabel* desc;

@property (nonatomic , strong) UIButton* btn;

@property (nonatomic , strong) MXSeparatorLine* line;

@end
@implementation CTActivitiesView

- (id)init{
    self=[super init];
    
    if (self) {
        [self initUI];
        [self layout];
    }
    
    return self;
}
-(void)initUI{
    [self addSubview:self.image];
    [self addSubview:self.title];
    [self addSubview:self.desc];
    [self addSubview:self.btn];
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
    
}

-(void)layout{
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@(150));
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image);
        make.right.equalTo(self.btn.mas_left);
        make.top.equalTo(self.image.mas_bottom).offset(15);
    }];
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image);
        make.right.equalTo(self.btn.mas_left);
        make.top.equalTo(self.title.mas_bottom).offset(5);
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.image);
        make.width.equalTo(@(70));
        make.height.equalTo(@(28));
        make.bottom.equalTo(self).offset(-10);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.image);
        make.bottom.equalTo(self);
        make.height.equalTo(@(1));
    }];
}

-(UIImageView*)image{
    if (!_image) {
        _image = [UIImageView new];
    }
    return _image;
}

-(UILabel*)title{
    if (!_title) {
        _title = [UILabel new];
        _title.font = [UIFont systemFontOfSize:16];
    }
    return _title;
}

-(UILabel*)desc{
    if (!_desc) {
        _desc = [UILabel new];
        _desc.font = [UIFont systemFontOfSize:13];
        _desc.textColor = [UIColor moPlaceHolder];
    }
    return _desc;
}

-(UIButton*)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setBackgroundColor:[UIColor moGreen]];
        [_btn setTitle:@"立即参与" forState:UIControlStateNormal];
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = 5;
        _btn.enabled = NO;
        _btn.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _btn;
}

-(void)reload:(TraditionalPosActivityModel*) model{
    [_image sd_setImageWithURL:[NSURL URLWithString:model.cover_url] placeholderImage:nil];
    _title.text = model.activity_name;
    NSDate* start_date = [NSDate dateWithString:model.start_date withDateFormat:@"yyyyMMdd"];
    NSDate* end_date = [NSDate dateWithString:model.end_date withDateFormat:@"yyyyMMdd"];
    
    NSString* start_str = @"";
    if (start_date) {
        start_str =[NSDate dateString:start_date format:@"yyyy.MM.dd"];
    }
    NSString* end_str = @"";
    if (end_date) {
        end_str = [NSDate dateString:end_date format:@"yyyy.MM.dd"];
    }
    _desc.text = [NSString stringWithFormat:@"%@-%@",start_str,end_str];
}
@end
