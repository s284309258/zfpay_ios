//
//  FenRunDetailCell.m
//  XZF
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "CashOutRecordCell.h"
#import "ProfitFormView.h"
#import "CashOutStatusView.h"
static NSInteger padding = 10;
static NSInteger height = 28;
@interface CashOutRecordCell()

@property (nonatomic , strong) ProfitFormView* orderId;

@property (nonatomic , strong) UILabel* moneyTitleLbl;

@property (nonatomic , strong) UILabel* moneyLbl;

@property (nonatomic , strong) CashOutStatusView* statusView;

@property (nonatomic , strong) ProfitFormView* totalMoney;

@property (nonatomic , strong) ProfitFormView* unitMoney;

@property (nonatomic , strong) ProfitFormView* tax;

@property (nonatomic , strong) ProfitFormView* check;

@property (nonatomic , strong) ProfitFormView* time;

@property (nonatomic , strong) UIView* backView;

@end
@implementation CashOutRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
        [self layout];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)initUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backView];
    [self addSubview:self.orderId];
    [self addSubview:self.moneyTitleLbl];
    [self addSubview:self.moneyLbl];
    [self addSubview:self.statusView];
    [self addSubview:self.totalMoney];
    [self addSubview:self.unitMoney];
    [self addSubview:self.tax];
    [self addSubview:self.check];
    [self addSubview:self.time];
}

-(void)layout{
    [self.orderId mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self).offset(padding);
        make.height.equalTo(@(height));
    }];
    [self.moneyTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderId).offset(15);
        make.top.equalTo(self.orderId.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.moneyTitleLbl.mas_bottom);
        make.height.equalTo(@(height*1.5));
    }];
    
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.moneyLbl.mas_bottom);
        make.height.equalTo(@(75));
    }];
    [self.totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.statusView.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.unitMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.totalMoney.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.tax mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.unitMoney.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.check mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.tax.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.check.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
}

-(ProfitFormView*)orderId{
    if (!_orderId) {
        _orderId = [[ProfitFormView alloc]initWithFrame:CGRectZero];
        _orderId.typeLbl.font = [UIFont systemFontOfSize:13];
    }
    return _orderId;
}

-(UILabel*)moneyTitleLbl{
    if (!_moneyTitleLbl) {
        _moneyTitleLbl = [UILabel new];
        _moneyTitleLbl.text = @"到账金额";
        _moneyTitleLbl.textColor = [UIColor moPlaceHolder];
        _moneyTitleLbl.font = [UIFont systemFontOfSize:13];
        
    }
    return _moneyTitleLbl;
}

-(UILabel*)moneyLbl{
    if (!_moneyLbl) {
        _moneyLbl = [UILabel new];
        _moneyLbl.textColor = [UIColor moBlack];
        _moneyLbl.font = [UIFont boldSystemFontOfSize:23];
        _moneyLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLbl;
}

-(CashOutStatusView*)statusView{
    if (!_statusView) {
        _statusView = [CashOutStatusView new];//CashRecordDetailModel
    }
    return _statusView;
}


-(ProfitFormView*)totalMoney{
    if (!_totalMoney) {
        _totalMoney = [[ProfitFormView alloc]initWithFrame:CGRectZero];
        
    }
    return _totalMoney;
}

-(ProfitFormView*)unitMoney{
    if (!_unitMoney) {
        _unitMoney = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _unitMoney;
}

-(ProfitFormView*)tax{
    if (!_tax) {
        _tax = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _tax;
}

-(ProfitFormView*)check{
    if (!_check) {
        _check = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _check;
}

-(ProfitFormView*)time{
    if (!_time) {
        _time = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _time;
}

-(UIView*)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 5;
    }
    return _backView;
}


-(void)reload:(CashRecordModel*)model{
    NSString* orderId = [NSString stringWithFormat:@"银行卡号:%@",model.account];
    [_orderId reloadData:orderId money:@"" btnTitle:@""];
    _moneyLbl.text = [NSString stringWithFormat:@"￥%@", model.cash_actual_money];
    [_totalMoney reloadData:@"提现总额" money:model.cash_money];
    [_unitMoney reloadData:@"单笔提现费" money:[NSString stringWithFormat:@"-%@",model.single_feet_money]];
    [_tax reloadData:@"所得税(7%)" money:[NSString stringWithFormat:@"-%@",model.rate_feet_money]];
    [_check reloadData:@"考核未达标" money:[NSString stringWithFormat:@"-%@",model.deduct_money]];
    [_time reloadData:@"提现时间" money:model.cre_date];
    [_statusView reloadArray:model.cashRecordDetailList];
    
}
@end
