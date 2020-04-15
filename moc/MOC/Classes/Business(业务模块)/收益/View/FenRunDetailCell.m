//
//  FenRunDetailCell.m
//  XZF
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "FenRunDetailCell.h"
#import "ProfitFormView.h"
static NSInteger padding = 10;
static NSInteger height = 28;
@interface FenRunDetailCell()

@property (nonatomic , strong) ProfitFormView* orderId;

@property (nonatomic , strong) UILabel* moneyTitleLbl;

@property (nonatomic , strong) UILabel* moneyLbl;

@property (nonatomic , strong) ProfitFormView* snId;

@property (nonatomic , strong) ProfitFormView* type;

@property (nonatomic , strong) ProfitFormView* fenrunType;

@property (nonatomic , strong) ProfitFormView* trans_product;

@property (nonatomic , strong) ProfitFormView* money;

@property (nonatomic , strong) ProfitFormView* businessDate;

@property (nonatomic , strong) ProfitFormView* getMoneyDate;

@property (nonatomic , strong) ProfitFormView* cardType;

@property (nonatomic , strong) ProfitFormView* singleAmount;

@property (nonatomic , strong) UIView* backView;

@end
@implementation FenRunDetailCell

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
    [self addSubview:self.fenrunType];
    [self addSubview:self.trans_product];
    [self addSubview:self.money];
    [self addSubview:self.businessDate];
    [self addSubview:self.getMoneyDate];
    [self addSubview:self.cardType];
    [self addSubview:self.singleAmount];
    
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
    
    [self.cardType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.type.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.fenrunType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.cardType.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.trans_product mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.fenrunType.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.singleAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.trans_product.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.singleAmount.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.businessDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.money.mas_bottom);
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

-(ProfitFormView*)fenrunType{
    if (!_fenrunType) {
        _fenrunType = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _fenrunType;
}

-(ProfitFormView*)trans_product{
    if (!_trans_product) {
        _trans_product = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _trans_product;
}

-(ProfitFormView*)money{
    if (!_money) {
        _money = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _money;
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

-(ProfitFormView*)cardType{
    if (!_cardType) {
        _cardType = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _cardType;
}

-(ProfitFormView*)singleAmount{
    if (!_singleAmount) {
        _singleAmount = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _singleAmount;
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

-(void)reload:(ShareBenefitPosModel*)model{
    [_orderId reloadData:[NSString stringWithFormat:@"订单号:%@",model.order_id] money:@"" btnTitle:@""];
    _moneyLbl.text = [NSString stringWithFormat:@"¥%@",model.benefit_money];
    [_snId reloadData:@"SN号" money:model.sn];
    NSString* trans_type = @"";
    if ([model.trans_type isEqualToString:@"1"]) {
        trans_type = @"刷卡";
    }else if ([model.trans_type isEqualToString:@"2"]) {
        trans_type = @"快捷支付";
    }else if ([model.trans_type isEqualToString:@"3"]) {
        trans_type = @"微信";
    }else if ([model.trans_type isEqualToString:@"4"]) {
        trans_type = @"支付宝";
    }else if ([model.trans_type isEqualToString:@"5"]) {
        trans_type = @"银联二维码";
    }
    [_type reloadData:@"交易类型" money:trans_type];
    
     NSString* benefit_type = @"";
    if ([model.benefit_type isEqualToString:@"01"]) {
        benefit_type = @"结算价";
    }else if ([model.benefit_type isEqualToString:@"02"]) {
        benefit_type = @"单笔";
    }
    [_fenrunType reloadData:@"分润类型" money:benefit_type];
    NSString* trans_product = @"-";
   if ([model.trans_product isEqualToString:@"1"]) {
       trans_product = @"付款秒到(非商圈)";
   }else if ([model.trans_product isEqualToString:@"2"]) {
       trans_product = @"VIP秒到(商圈)";
   }else if([model.trans_product isEqualToString:@"3"]){
       trans_product = @"星券秒到";
   }
    [_trans_product reloadData:@"交易产品" money:trans_product];
      
      
    
    [_money reloadData:@"交易金额" money:model.trans_amount];
    
    [_businessDate reloadData:@"交易时间" money:model.trans_datetime];
    
    [_getMoneyDate reloadData:@"收益时间" money:model.cre_datetime];
    
    [_singleAmount reloadData:@"单笔金额" money:model.single_amount];
    
    NSString* type = model.card_type;
    if ([type isEqualToString:@"1"]) {
        type = @"借记卡";
    }else if([type isEqualToString:@"2"]){
        type = @"贷记卡";
    }else if([type isEqualToString:@"3"]){
        type = @"境外卡";
    }else if([type isEqualToString:@"4"]){
        type = @"云闪付";
    }
    [_cardType reloadData:@"卡类型" money:type ];
}
@end
