//
//  ProfitView.m
//  XZF
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ProfitView.h"
#import "SPButton.h"
@interface ProfitView()

@property (nonatomic , strong) UILabel* titleLbl;

@property (nonatomic , strong) SPButton* dateBtn;

@property (nonatomic , strong) UILabel* titleLbl1;

@property (nonatomic , strong) UILabel* titleLbl2;

@property (nonatomic , strong) UILabel* titleLbl3;

@property (nonatomic , strong) UIImageView* bottomView;

@property (nonatomic, strong) MXSeparatorLine *line;

@end

@implementation ProfitView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
    [self addSubview:self.titleLbl];
    [self addSubview:self.dateBtn];
    [self addSubview:self.titleLbl1];
    [self addSubview:self.titleLbl2];
    [self addSubview:self.titleLbl3];
    [self addSubview:self.line];
}

-(void)layout{
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(5);
        make.width.equalTo(@(125));
        make.height.equalTo(@(30));
    }];
    
    [self.dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLbl);
        make.right.equalTo(self).offset(-10);
    }];
    
    [self.titleLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self).multipliedBy(0.5);
    }];
    
    [self.titleLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLbl1);
        make.centerX.equalTo(self).multipliedBy(1.5);
        make.height.equalTo(@(25));
    }];
    
    [self.titleLbl3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLbl1);
        make.centerX.equalTo(self.titleLbl2);
        make.height.equalTo(@(25));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
//        make.height.equalTo(@(35));
//        make.bottom.equalTo(self);
//        make.left.right.equalTo(self);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.titleLbl1);
        make.width.equalTo(@(1));
        make.centerX.equalTo(self);
    }];
    
}

- (UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = [UIFont systemFontOfSize:13];
        _titleLbl.textColor = [UIColor whiteColor];
    }
    return _titleLbl;
}

- (UIButton *)dateBtn{
    if (!_dateBtn) {
        _dateBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
        _dateBtn.frame = CGRectMake(0, 0, 65, 45);
        _dateBtn.titleLabel.font = [UIFont font14];
        [_dateBtn setImage:[UIImage imageNamed:@"选择_down"] forState:UIControlStateNormal];
        [_dateBtn setTitleColor:[UIColor moPlaceHolder] forState:UIControlStateNormal];
        [_dateBtn addTarget:self action:@selector(dateClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dateBtn;
}

- (UILabel *)titleLbl1{
    if (!_titleLbl1) {
        _titleLbl1 = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLbl1.textAlignment = NSTextAlignmentCenter;
        _titleLbl1.numberOfLines = 2;
    }
    return _titleLbl1;
}

- (UILabel *)titleLbl2{
    if (!_titleLbl2) {
        _titleLbl2 = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLbl2.textAlignment = NSTextAlignmentCenter;
        _titleLbl2.textColor = [UIColor whiteColor];
        
    }
    return _titleLbl2;
}

- (UILabel *)titleLbl3{
    if (!_titleLbl3) {
        _titleLbl3 = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLbl3.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLbl3;
}

-(MXSeparatorLine *)line{
    if (!_line) {
        _line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    }
    return _line;
}

-(UIImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIImageView new];
        
       
    }
    return _bottomView;
}

-(void)reload:(PosBenefitDetailModel*)model dateString:(NSString*)date{
    if (!model) {
        return;
    }
    if ([model.type isEqualToString:@"CTPOS"]) {
        _titleLbl.text = Lang(@"传统POS 收益(元)");
         _bottomView.image = [UIImage imageNamed:@"传统POS_bg"];
    }else if ([model.type isEqualToString:@"MPOS"]) {
        _titleLbl.text = Lang(@"MPOS 收益(元)");
         _bottomView.image = [UIImage imageNamed:@"MPOS_bg"];
    }else{
        _titleLbl.text = Lang(@"EPOS 收益(元)");
         _bottomView.image = [UIImage imageNamed:@"EPOS_bg"];
    }
    {
       
        NSString* str1 = model.benefit;
        NSString* str2 = @"月收益";
        NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",str1,str2]];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:8];
        [paragraphStyle setAlignment:NSTextAlignmentCenter];
        [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attr length])];
        [attr addColor:[UIColor moBlack] substring:str1];
        [attr addColor:[UIColor moPlaceHolder] substring:str2];
        [attr addFont:[UIFont systemFontOfSize:21] substring:str1];
        [attr addFont:[UIFont systemFontOfSize:13] substring:str2];
        _titleLbl1.attributedText = attr;
    }
    
    {
        NSString* str1 = @"直营收益：";
        NSString* str2 = model.merchant_benefit;
        NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",str1,str2]];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:0];
        
        [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attr length])];
        [attr addColor:[UIColor moPlaceHolder] substring:str1];
        [attr addColor:[UIColor moBlack] substring:str2];
        [attr addFont:[UIFont systemFontOfSize:13] substring:str1];
        [attr addFont:[UIFont systemFontOfSize:15] substring:str2];
        _titleLbl2.attributedText = attr;
    }
    {
        
        NSString* str1 = @"代理收益：";
        NSString* str2 = model.agency_benefit;
        NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",str1,str2]];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:0];
        
        [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attr length])];
        [attr addColor:[UIColor moPlaceHolder] substring:str1];
        [attr addColor:[UIColor moBlack] substring:str2];
        [attr addFont:[UIFont systemFontOfSize:13] substring:str1];
        [attr addFont:[UIFont systemFontOfSize:15] substring:str2];
        _titleLbl3.attributedText = attr;
    }
    [self.dateBtn setTitle:date forState:UIControlStateNormal];
    
}

-(void)dateClick:(id)sender{
    if (self.block) {
        self.block(nil);
    }
}
@end
