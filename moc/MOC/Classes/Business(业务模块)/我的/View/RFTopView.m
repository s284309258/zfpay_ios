//
//  ReportFormHeader.m
//  XZF
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "RFTopView.h"
static NSInteger width = 50;
static NSInteger padding = 15;
@interface RFTopView()

@property (nonatomic ,strong) UIImageView* avatarImg;

@property (nonatomic ,strong) UILabel* nameLbl;

//@property (nonatomic ,strong) UILabel* tipLbl;

//@property (nonatomic ,strong) MXSeparatorLine* line;

@end

@implementation RFTopView

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
    [self addSubview:self.avatarImg];
    [self addSubview:self.nameLbl];
//    [self addSubview:self.tipLbl];
//    [self addSubview:self.leftBottomLbl];
//    [self addSubview:self.rightBottomLbl];
//    [self addSubview:self.line];
}

-(void)layout{
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@(padding));
        make.width.height.equalTo(@(width));
    }];
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.avatarImg.mas_bottom).offset(10);
    }];
//    [self.tipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.avatarImg.mas_bottom);
////        make.bottom.equalTo(self.leftBottomLbl.mas_top);
//
//        make.left.equalTo(self.avatarImg);
//    }];
//    [self.leftBottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.avatarImg);
//        make.bottom.equalTo(self).offset(-5);
//        make.height.equalTo(@(25));
//    }];
//    [self.rightBottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(@(-padding));
//        make.bottom.equalTo(self).offset(-5);
//        make.height.equalTo(@(25));
//    }];
//    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
//        make.centerY.equalTo(self.leftBottomLbl);
//        make.width.equalTo(@(1));
//        make.height.equalTo(@(10));
//    }];
}

-(UIImageView *)avatarImg{
    if (!_avatarImg) {
        _avatarImg = [UIImageView new];
        _avatarImg.layer.masksToBounds = YES;
        _avatarImg.layer.cornerRadius = width/2;
    }
    return _avatarImg;
}

-(UILabel *)nameLbl{
    if (!_nameLbl) {
        _nameLbl = [UILabel new];
        _nameLbl.numberOfLines = 0;
    }
    return _nameLbl;
}

//-(UILabel *)tipLbl{
//    if (!_tipLbl) {
//        _tipLbl = [UILabel new];
//        _tipLbl.numberOfLines = 0;
//    }
//    return _tipLbl;
//}

//-(MXSeparatorLine* )line{
//    if (!_line) {
//        _line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
//        _line.backgroundColor = [UIColor whiteColor];
//    }
//    return _line;
//}

-(void)reload:(RealNameModel*)model{
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:AppUserModel.head_photo]];
    {
        NSString* str1 = AppUserModel.real.real_name?:@"";
        NSString* str2 = AppUserModel.user_tel;
        NSString* str = [NSString stringWithFormat:@"%@\n%@",str1,str2];
        NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
        [attr addFont:[UIFont font14] substring:str1];
        [attr addFont:[UIFont font12] substring:str2];
        [attr addColor:[UIColor moBlack] substring:str1];
        [attr addColor:[UIColor grayColor] substring:str2];
        [attr setLineSpacing:5 substring:attr.string alignment:NSTextAlignmentCenter];
        self.nameLbl.attributedText = attr;
    }
//    {
//        NSString* str1 = [NSString stringWithFormat:@"今日交易额:%@",model.tradeAmountDay?:@"0"];
//        NSString* str2 = [NSString stringWithFormat:@"累计交易额:%@",model.tradeAmountAll?:@"0"];
//        NSString* str = [NSString stringWithFormat:@"%@\n%@",str1,str2];
//        NSMutableAttributedString* attr  = [[NSMutableAttributedString alloc]initWithString:str];
//        [attr addFont:[UIFont font14] substring:str1];
//        [attr addFont:[UIFont font17] substring:str2];
//        [attr addColor:[UIColor whiteColor] substring:attr.string];
//        [attr setLineSpacing:8 substring:attr.string alignment:NSTextAlignmentLeft];
//        self.tipLbl.attributedText = attr;
//    }
    
}


//-(void)reloadCTPos:(NSString*)ctpos mPos:(NSString*)mpos{
//    self.leftBottomLbl.text =  [NSString stringWithFormat:@"传统POS月台均:%@",ctpos];
//    self.rightBottomLbl.text =  [NSString stringWithFormat:@"MPOS月台均:%@",mpos];
//}
@end
