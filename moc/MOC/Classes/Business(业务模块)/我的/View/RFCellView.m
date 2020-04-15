//
//  RFCellView.m
//  XZF
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "RFCellView.h"
#import "RFHeader.h"
@interface RFCellView()

@property (nonatomic ,strong) UIImageView* backImg;

@property (nonatomic ,strong) UILabel* moneyLbl;

@property (nonatomic ,strong) UILabel* moneyTitleLbl;

@property (nonatomic ,strong) UILabel* numLbl0;

@property (nonatomic ,strong) UILabel* numTitleLbl0;

@property (nonatomic ,strong) UILabel* numLbl1;

@property (nonatomic ,strong) UILabel* numTitleLbl1;

@property (nonatomic ,strong) UILabel* numLbl2;

@property (nonatomic ,strong) UILabel* numTitleLbl2;

@property (nonatomic ,strong) MXSeparatorLine* line;

@end
@implementation RFCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.backImg];
    [self addSubview:self.moneyLbl];
    [self addSubview:self.moneyTitleLbl];
    [self addSubview:self.numLbl0];
    [self addSubview:self.numTitleLbl0];
    [self addSubview:self.numLbl1];
    [self addSubview:self.numTitleLbl1];
    [self addSubview:self.numLbl2];
    [self addSubview:self.numTitleLbl2];
    [self addSubview:self.line];
    
}

-(void)layout{
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.moneyTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLbl.mas_bottom).offset(10);
        make.centerX.equalTo(self.moneyLbl);
    }];
    
    [self.numTitleLbl0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@(SCREEN_WIDTH/3));
    }];
    
    [self.numLbl0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.numTitleLbl0);
        make.bottom.equalTo(self.numTitleLbl1.mas_top).offset(-10);
    }];
    
    [self.numTitleLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@(SCREEN_WIDTH/3));
    }];
    [self.numLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.numTitleLbl1);
        make.bottom.equalTo(self.numTitleLbl1.mas_top).offset(-10);
    }];
    
    [self.numTitleLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@(SCREEN_WIDTH/3));
    }];
    [self.numLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.numTitleLbl2);
        make.bottom.equalTo(self.numTitleLbl1.mas_top).offset(-10);
    }];
    
}

-(UIImageView *)backImg{
    if (!_backImg) {
        _backImg = [UIImageView new];
    }
    return _backImg;
}

-(UILabel *)moneyLbl{
    if (!_moneyLbl) {
        _moneyLbl = [UILabel new];
        _moneyLbl.font = [UIFont systemFontOfSize:24];
        _moneyLbl.textAlignment = NSTextAlignmentCenter;
        _moneyLbl.textColor = [UIColor whiteColor];
    }
    return _moneyLbl;
}

-(UILabel *)moneyTitleLbl{
    if (!_moneyTitleLbl) {
        _moneyTitleLbl = [UILabel new];
        _moneyTitleLbl.font = [UIFont systemFontOfSize:13];
        _moneyTitleLbl.textAlignment = NSTextAlignmentCenter;
        _moneyTitleLbl.textColor = [UIColor whiteColor];
    }
    return _moneyTitleLbl;
}

-(UILabel *)numLbl0{
    if (!_numLbl0) {
        _numLbl0 = [UILabel new];
        _numLbl0.font = [UIFont font15];
        _numLbl0.textColor = [UIColor whiteColor];
        _numLbl0.textAlignment = NSTextAlignmentCenter;
    }
    return _numLbl0;
}

-(UILabel *)numTitleLbl0{
    if (!_numTitleLbl0) {
        _numTitleLbl0 = [UILabel new];
        _numTitleLbl0.font = [UIFont font12];
        _numTitleLbl0.textColor = [UIColor whiteColor];
        _numTitleLbl0.textAlignment = NSTextAlignmentCenter;
    }
    return _numTitleLbl0;
}

-(UILabel *)numLbl1{
    if (!_numLbl1) {
        _numLbl1 = [UILabel new];
        _numLbl1.font = [UIFont font15];
        _numLbl1.textColor = [UIColor whiteColor];
        _numLbl1.textAlignment = NSTextAlignmentCenter;
    }
    return _numLbl1;
}

-(UILabel *)numTitleLbl1{
    if (!_numTitleLbl1) {
        _numTitleLbl1 = [UILabel new];
        _numTitleLbl1.font = [UIFont font12];
        _numTitleLbl1.textColor = [UIColor whiteColor];
        _numTitleLbl1.textAlignment = NSTextAlignmentCenter;
    }
    return _numTitleLbl1;
}

-(UILabel *)numLbl2{
    if (!_numLbl2) {
        _numLbl2 = [UILabel new];
        _numLbl2.font = [UIFont font15];
        _numLbl2.textColor = [UIColor whiteColor];
        _numLbl2.textAlignment = NSTextAlignmentCenter;
    }
    return _numLbl2;
}

-(UILabel *)numTitleLbl2{
    if (!_numTitleLbl2) {
        _numTitleLbl2 = [UILabel new];
        _numTitleLbl2.font = [UIFont font12];
        _numTitleLbl2.textColor = [UIColor whiteColor];
        _numTitleLbl2.textAlignment = NSTextAlignmentCenter;
    }
    return _numTitleLbl2;
}

-(MXSeparatorLine* )line{
    if (!_line) {
        _line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    }
    return _line;
}

-(void)reloadBack:(NSString* )img
            title:(NSString* )title desc:(NSString* )desc
            sub:(NSString* )subTitle subDesc:(NSString* )subDesc
            sub1:(NSString* )subTitle1 subDesc:(NSString* )subDesc1
            sub2:(NSString*)subTitle2 subDesc:(NSString* )subDesc2{
    self.backImg.image = [UIImage imageNamed:img];
    self.moneyTitleLbl.text = title;
    self.moneyLbl.text = [StringUtil isEmpty:desc]?@"0":desc;
    
    self.numTitleLbl0.text = subTitle;
    self.numLbl0.text = [StringUtil isEmpty:subDesc]?@"0":subDesc;
    
    self.numTitleLbl1.text = subTitle1;
    self.numLbl1.text = [StringUtil isEmpty:subDesc1]?@"0":subDesc1;
    
    self.numTitleLbl2.text = subTitle2;
    self.numLbl2.text = [StringUtil isEmpty:subDesc2]?@"0":subDesc2;
}
@end
