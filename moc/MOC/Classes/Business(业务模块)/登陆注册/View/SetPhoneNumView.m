//
//  SetPhoneNumView.m
//  AdvertisingMaster
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SetPhoneNumView.h"
@interface SetPhoneNumView()

@property (nonatomic,strong) UILabel    *titleLbl;

@property (nonatomic,strong) UILabel    *rightLbl;

@property (nonatomic, strong) MXSeparatorLine *line;
@end

@implementation SetPhoneNumView

- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
       
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.titleLbl];
    [self addSubview:self.rightLbl];
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
    @weakify(self)
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(80));
    }];
    [self.rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.titleLbl.mas_right).offset(10);
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(-0);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@(0.5));
    }];
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLbl.font = [UIFont systemFontOfSize:15];
        _titleLbl.textColor = [UIColor moBlack];
        _titleLbl.text = @"当前手机号:";
    }
    return _titleLbl;
}

- (UILabel *)rightLbl
{
    if (!_rightLbl) {
        _rightLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightLbl.font = [UIFont systemFontOfSize:14];
        _rightLbl.textColor = [UIColor colorWithHexString:@"#666666"];
        _rightLbl.text = @"";
    }
    return _rightLbl;
}

-(void)reload:(NSString *)title desc:(NSString* )desc{
    self.titleLbl.text = title;
    self.rightLbl.text = desc;
}

-(void)setTitleColor:(UIColor* )titleCol descColor:(UIColor *)descCol{
    self.titleLbl.textColor = titleCol;
    self.rightLbl.textColor = descCol;
}
@end
