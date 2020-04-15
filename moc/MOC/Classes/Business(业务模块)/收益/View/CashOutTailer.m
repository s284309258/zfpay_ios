//
//  CashOutHeader.m
//  XZF
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "CashOutTailer.h"
static NSInteger padding = 15;
@interface CashOutTailer()<UITextFieldDelegate>

@property (nonatomic , strong) UILabel*     titleLbl;


@property (nonatomic , strong) UILabel*     titleLbl1;

@property (nonatomic , strong) UILabel*     titleLbl2;

@property (nonatomic , strong) UILabel*     titleLbl3;

@property (nonatomic , strong) UILabel*     titleLbl4;

@property (nonatomic , strong) UILabel*     titleLbl5;

@property (nonatomic , strong) UIButton*    submitBtn;

@property (nonatomic , strong) UIView*      backView;

@property (nonatomic , strong) MXSeparatorLine*      line;

@property (nonatomic , strong)  CashInfoModel* model;

@end
@implementation CashOutTailer

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.titleLbl];
    [self addSubview:self.numTf];
    [self addSubview:self.titleLbl1];
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
    
    [self addSubview:self.titleLbl2];
    [self addSubview:self.titleLbl3];
    [self addSubview:self.titleLbl4];
    [self addSubview:self.backView];
    [self.backView addSubview:self.titleLbl5];
    [self addSubview:self.submitBtn];
}

-(void)layout{
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
    }];
    [self.numTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLbl.mas_bottom).offset(5);
        make.left.right.equalTo(self.titleLbl);
        make.height.equalTo(@(60));
    }];
    [self.titleLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLbl);
        make.top.equalTo(self.numTf.mas_bottom);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLbl);
        make.top.equalTo(self.titleLbl1.mas_bottom).offset(5);
        make.height.equalTo(@(1));
    }];
    [self.titleLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numTf);
        make.top.equalTo(self.line.mas_bottom).offset(25);
    }];
    [self.titleLbl3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numTf);
        make.top.equalTo(self.titleLbl2);
    }];
    [self.titleLbl4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl2);
        make.top.equalTo(self.titleLbl2.mas_bottom).offset(15);
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLbl);
        make.top.equalTo(self.titleLbl4.mas_bottom).offset(20);
        make.height.equalTo(@(100));
    }];
    [self.titleLbl5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_bottom).offset(80);
        make.left.right.equalTo(self.titleLbl);
        make.height.equalTo(@(44));
    }];
    
}

-(UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.text = @"请输入提现金额";
        _titleLbl.font = [UIFont font15];
    }
    return _titleLbl;
}

-(UITextField* )numTf{
    if (!_numTf) {
        _numTf = [[UITextField alloc] init];
        _numTf.delegate = self;
        _numTf.placeholder = @"0.00";
//        [_numTf setValue:[UIColor moTextGray] forKeyPath:@"_placeholderLabel.textColor"];
         [_numTf setCustomPlaceholderColor:[UIColor moTextGray]];
        _numTf.textColor = [UIColor moBlack];
        _numTf.textAlignment = NSTextAlignmentLeft;
        _numTf.keyboardType = UIKeyboardTypeDecimalPad;
        [_numTf setFont:[UIFont systemFontOfSize:21]];
        _numTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _numTf.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:_numTf];
    }
    return _numTf;
}

-(void)textFieldChanged:(id)sender{
    if (self.model) {
        float total = [self.numTf.text floatValue];
        if (![StringUtil isEmpty:self.model.deduct_money]) {
            total -=([self.model.deduct_money floatValue]);
        }
        if (total < 10 || [self.model.can_cash_money floatValue]< [self.numTf.text floatValue] ) {
            _titleLbl2.text = @"总手续费:0.00";
            _titleLbl4.text = @"到账金额:0.00";
            self.submitBtn.enabled = NO;
            self.submitBtn.alpha = 0.5;
            return;
        }else{
            self.submitBtn.enabled = YES;
            self.submitBtn.alpha = 1;
        }
        float totalFeet = 3+total*([self.model.cashFeetRate floatValue]);
        //总手续费
        self.titleLbl2.text = [NSString stringWithFormat:@"总手续费:%.2lf",totalFeet];
        
        float totalMoney = (total - totalFeet);
        //到账金额
        self.titleLbl4.text = [NSString stringWithFormat:@"到账金额:%.2lf",totalMoney];
        
    }
}

-(UILabel *)titleLbl1{
    if (!_titleLbl1) {
        _titleLbl1 = [UILabel new];
        _titleLbl1.font = [UIFont systemFontOfSize:13];
        _titleLbl1.textColor = [UIColor darkGreen];
    }
    return _titleLbl1;
}

-(UILabel *)titleLbl2{
    if (!_titleLbl2) {
        _titleLbl2 = [UILabel new];
        _titleLbl2.font = [UIFont systemFontOfSize:13];
        _titleLbl2.textColor = [UIColor moBlack];
        _titleLbl2.text = @"总手续费:0.00";
    }
    return _titleLbl2;
}

-(UILabel *)titleLbl3{
    if (!_titleLbl3) {
        _titleLbl3 = [UILabel new];
        _titleLbl3.font = [UIFont systemFontOfSize:13];
        _titleLbl3.textColor = [UIColor moBlack];
        _titleLbl3.text = @"到账金额:0.00";
    }
    return _titleLbl3;
}

-(UILabel *)titleLbl4{
    if (!_titleLbl4) {
        _titleLbl4 = [UILabel new];
        _titleLbl4.font = [UIFont systemFontOfSize:13];
        _titleLbl4.textColor = [UIColor moBlack];
    }
    return _titleLbl4;
}

-(UILabel *)titleLbl5{
    if (!_titleLbl5) {
        _titleLbl5 = [UILabel new];
        _titleLbl5.numberOfLines = 4;
        _titleLbl5.font = [UIFont font12];
        _titleLbl5.textColor = [UIColor moPlaceHolder];
        
        NSString* str = @"*温馨提示：\n提现金额不得低于10.00元;\n提现自动扣取7%所得税.3.00元一笔提现费;\n提现到账时间T+1天.";
        NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        
        [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attr length])];
        [attr addColor:[UIColor moPlaceHolder] substring:str];
        [attr addFont:[UIFont systemFontOfSize:12] substring:str];
        _titleLbl5.attributedText = attr;
    }
    return _titleLbl5;
}

-(UIButton*)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setBackgroundColor:[UIColor darkGreen]];
        [_submitBtn setTitle:@"申请提现" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        [_submitBtn addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(UIView*)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    }
    return _backView;
}

-(void)commit:(id)sender{
    if (self.block) {
        self.block(nil);
    }
}

-(void)reload:(CashInfoModel*)model{
    self.model = model;
    float cash = [model.can_cash_money floatValue];
    _titleLbl1.text = [NSString stringWithFormat:@"可提现金额:%.2f",cash];
    if (![AppUserModel.algebra isEqualToString:@"1"]) {
        _titleLbl3.hidden = YES;
    }
    _titleLbl3.text = [NSString stringWithFormat:@"考核未达标扣除:%@",model.deduct_money];
}
@end
