//
//  FenRunDetailCell.m
//  XZF
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "CTRewardView.h"
#import "ProfitFormView.h"
static NSInteger padding = 10;
static NSInteger height = 28;
@interface CTRewardView()

@property (nonatomic , strong) ProfitFormView* orderId;

@property (nonatomic , strong) UILabel* moneyTitleLbl;

@property (nonatomic , strong) UILabel* moneyLbl;

@property (nonatomic , strong) ProfitFormView* snId;

@property (nonatomic , strong) ProfitFormView* type;

@property (nonatomic , strong) ProfitFormView* businessDate;

@property (nonatomic , strong) ProfitFormView* getMoneyDate;

@property (nonatomic , strong) UIView* backView;

@end
@implementation CTRewardView

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
    [self addSubview:self.snId];
    [self addSubview:self.type];
    [self addSubview:self.businessDate];
    [self addSubview:self.getMoneyDate];
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
    [self.snId mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.moneyLbl.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.snId.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.businessDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.type.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.getMoneyDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.businessDate.mas_bottom);
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
        _moneyTitleLbl.text = @"收益金额";
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

-(ProfitFormView*)snId{
    if (!_snId) {
        _snId = [[ProfitFormView alloc]initWithFrame:CGRectZero];
     
    }
    return _snId;
}

-(ProfitFormView*)type{
    if (!_type) {
        _type = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _type;
}

-(ProfitFormView*)businessDate{
    if (!_businessDate) {
        _businessDate = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _businessDate;
}

-(ProfitFormView*)getMoneyDate{
    if (!_getMoneyDate) {
        _getMoneyDate = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _getMoneyDate;
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

-(void)reload:(PosRewardModel*)model{
    [_orderId reloadData:[NSString stringWithFormat:@"订单号:%@",model.order_id] money:@"" btnTitle:@""];
    _moneyLbl.text = [NSString stringWithFormat:@"￥%@",model.money];
    [_snId reloadData:@"SN号" money:model.sn];
    [_type reloadData:@"活动类型" money:model.activity_name];
    [_businessDate reloadData:@"活动周期" money:[NSString stringWithFormat:@"%@-%@",model.start_date,model.end_date]];
    [_getMoneyDate reloadData:@"收益时间" money:model.cre_datetime];
}
@end
