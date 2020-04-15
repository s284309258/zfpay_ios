//
//  ChessBnt.m
//  MOC
//
//  Created by mac on 2019/6/19.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ChessBnt.h"

@interface ChessBnt ()

@end

@implementation ChessBnt

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLbl];
        [self addSubview:self.subTitle];
        [self addSubview:self.leftImgView];
        [self addSubview:self.rightImgView];
        [self setBackgroundImage:[UIImage imageNamed:@"消耗蓝贝"] forState:UIControlStateNormal];
        [self layout];
    }
    return self;
}

- (void)layout {
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(5));
        make.left.right.equalTo(@(0));
    }];
    
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-8));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-11));
        make.right.equalTo(self.subTitle.mas_left).offset(-5);
    }];
    
    [self.rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-11));
        make.left.equalTo(self.subTitle.mas_right).offset(5);;
    }];
}

- (UILabel *)titleLbl {
    if(!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.font = [UIFont systemFontOfSize:15];
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLbl;
}

- (UILabel *)subTitle {
    if(!_subTitle) {
        _subTitle = [[UILabel alloc] init];
        _subTitle.font = [UIFont systemFontOfSize:11];
        _subTitle.textAlignment = NSTextAlignmentCenter;
        _subTitle.textColor = [UIColor colorWithHexString:@"#68F3FF"];
    }
    return _subTitle;
}

- (UIImageView *)leftImgView {
    if(!_leftImgView) {
        _leftImgView = [[UIImageView alloc] init];
        _leftImgView.image = [UIImage imageNamed:@"点点点"];
    }
    return _leftImgView;
}

- (UIImageView *)rightImgView {
    if(!_rightImgView) {
        _rightImgView = [[UIImageView alloc] init];
        _rightImgView.image = [UIImage imageNamed:@"点点点"];
    }
    return _rightImgView;
}

@end
