//
//  PhoneNumView.m
//  AdvertisingMaster
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "PhoneNumView2.h"
#import "NumberPadTextField.h"
#import "UIViewController+FormatPhoneNumber.h"
static NSInteger iconWidth = 22;
@interface PhoneNumView2()<UITextFieldDelegate>


@end

@implementation PhoneNumView2

- (instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    
    return self;
}

-(void)initUI{
    self.tag = 998877;
    [self addSubview:self.titleLbl];
    [self addSubview:self.descLbl];
  
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
    [self layout];
}

-(void)layout{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(-0);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@(1));
    }];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(100));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.line.mas_left);
    }];
    [self.descLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(100));
        make.left.equalTo(self.titleLbl.mas_right).offset(15);
        make.right.equalTo(self.line.mas_right);
    }];
    
}

-(UILabel* )titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [UIColor moBlack];
        _titleLbl.text = Lang(@"当前手机号码");
        _titleLbl.numberOfLines = 0;
        [_titleLbl setFont:[UIFont font15]];
    }
    return _titleLbl;
}

-(UILabel* )descLbl{
    if (!_descLbl) {
        _descLbl = [[UILabel alloc] init];
        _descLbl.textColor = [UIColor moBlack];
        _descLbl.numberOfLines = 0;
        _descLbl.text = Lang(@"0000");
        [_descLbl setFont:[UIFont font15]];
        _descLbl.textAlignment = NSTextAlignmentRight;
    }
    return _descLbl;
}


-(void)reloadTitle:(NSString *) title desc:(NSString *)desc{
    self.titleLbl.text = title;
    self.descLbl.text = desc;
}

@end
