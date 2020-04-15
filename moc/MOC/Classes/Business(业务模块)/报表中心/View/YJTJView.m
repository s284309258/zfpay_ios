//
//  YJTJView.m
//  XZF
//
//  Created by mac on 2019/8/7.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "YJTJView.h"
#import "RFHeader.h"
#import "ImgTextTextView.h"
static NSInteger height = 50;
static NSInteger padding = 15;
@interface YJTJView()

@property (nonatomic ,strong) RFHeader* header;

@property (nonatomic ,strong) ImgTextTextView* moneyView;

@property (nonatomic ,strong) ImgTextTextView* addAgentView;

@property (nonatomic ,strong) ImgTextTextView* addMerchantView;

@property (nonatomic ,strong) UIButton* chartBtn;

@property (nonatomic ,strong) MXSeparatorLine* line;

@end

@implementation YJTJView

-(instancetype)init{
    if (self = [super init]) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.header];
    [self addSubview:self.moneyView];
    [self addSubview:self.addAgentView];
    [self addSubview:self.addMerchantView];
    [self addSubview:self.chartBtn];
}

-(void)layout{
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(height));
    }];
    [self.moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.header.mas_bottom);
        make.left.right.equalTo(self.header);
        make.height.equalTo(@(height));
    }];
    [self.addAgentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyView.mas_bottom);
        make.left.right.equalTo(self.header);
        make.height.equalTo(@(height));
    }];
    [self.addMerchantView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addAgentView.mas_bottom);
        make.left.right.equalTo(self.header);
        make.height.equalTo(@(height));
    }];
    [self.chartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addMerchantView.mas_bottom).offset(padding);
        make.centerX.equalTo(self);
        make.width.equalTo(@(180));
        make.height.equalTo(@(35));
    }];
   
}

-(RFHeader*)header{
    if (!_header) {
        _header = [[RFHeader alloc]init];
        _header.block = ^(id data) {
            if (self.dateBlock) {
                self.dateBlock(nil);
            }
        };
    }
    return _header;
}

-(ImgTextTextView*)moneyView{
    if (!_moneyView) {
        _moneyView = [[ImgTextTextView alloc]init];
    }
    return _moneyView;
}

-(ImgTextTextView*)addAgentView{
    if (!_addAgentView) {
        _addAgentView = [[ImgTextTextView alloc]init];
    }
    return _addAgentView;
}

-(ImgTextTextView*)addMerchantView{
    if (!_addMerchantView) {
        _addMerchantView = [[ImgTextTextView alloc]init];
    }
    return _addMerchantView;
}

-(UIButton*)chartBtn{
    if (!_chartBtn) {
        _chartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chartBtn.layer.borderColor = [UIColor moGreen].CGColor;
        _chartBtn.layer.borderWidth = 1;
        _chartBtn.layer.masksToBounds = YES;
        _chartBtn.layer.cornerRadius = 5;
        _chartBtn.titleLabel.font = [UIFont font15];
        [_chartBtn setTitleColor:[UIColor moGreen] forState:UIControlStateNormal];
        [_chartBtn addTarget:self action:@selector(chartClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chartBtn;
}

+(NSInteger)getHeight{
    return height*4+2*padding+35;
}

-(void)chartClick:(id)sender{
    if (self.chartBlock) {
        self.chartBlock(nil);
    }
}

-(void)refreshHeader:(NSString* )color text:(NSString *)text desc:(NSString *)desc{
    [_header reloadColor:@"#5B79E6" left:text rightImg:@"选择_down" rightText:desc];
}

-(void)reload:(RFPosDetailModel*)model btnTitle:(NSString*)title{
    
    [_moneyView reloadLeft:@"金额／资产" middle:@"交易额(元)" right:model.performance];
    
    [_addAgentView reloadLeft:@"新增代理" middle:@"新增代理" right:model.user_num];
    
    [_addMerchantView reloadLeft:@"新增商户_1" middle:@"新增商户" right:model.act_num];
    
    [_chartBtn setTitle:title forState:UIControlStateNormal];
}
@end
