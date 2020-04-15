//
//  FenRunDetailCell.m
//  XZF
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "FenRunDetailCell2.h"
#import "ProfitFormView.h"
static NSInteger padding = 10;
static NSInteger height = 28;
@interface FenRunDetailCell2()

@property (nonatomic , strong) ProfitFormView* orderId;

@property (nonatomic , strong) UILabel* moneyTitleLbl;

@property (nonatomic , strong) UILabel* moneyLbl;

@property (nonatomic , strong) ProfitFormView* snId;

@property (nonatomic , strong) ProfitFormView* type;

@property (nonatomic , strong) ProfitFormView* date;

@property (nonatomic , strong) ProfitFormView* time;

@property (nonatomic , strong) UIView* backView;

@end
@implementation FenRunDetailCell2

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
    [self addSubview:self.date];
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
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.type.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orderId);
        make.top.equalTo(self.date.mas_bottom);
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

-(ProfitFormView*)date{
    if (!_date) {
        _date = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _date;
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

-(void)reload:(MachineBackPosModel*)model type:(NSString*)type{
    if ([type isEqualToString:@"jhfx"]) {
        NSString* orderId = [NSString stringWithFormat:@"订单号:%@",model.order_id];
        [_orderId reloadData:orderId money:@"" btnTitle:@""];
        
        _moneyLbl.text = [NSString stringWithFormat:@"¥%@",model.money];
        
        [_snId reloadData:@"SN号" money:model.sn];
        
        [_type reloadData:@"交易类型" money:@"激活返现"];
        
        [_date reloadData:@"激活时间" money:model.frozen_time];
        
        [_time reloadData:@"收益时间" money:model.cre_datetime];
    }else if([type isEqualToString:@"hdjl"]){
        NSString* orderId = [NSString stringWithFormat:@"订单号:%@",model.order_id];
        [_orderId reloadData:orderId money:@"" btnTitle:@""];
        
        _moneyLbl.text = [NSString stringWithFormat:@"¥%@",model.money];
        
        [_snId reloadData:@"SN号" money:model.sn];
        
        [_type reloadData:@"活动类型" money:model.activity_name];
        
        [_date reloadData:@"活动周期" money:[NSString stringWithFormat:@"%@-%@",model.start_date,model.end_date]];
        
        [_time reloadData:@"收益时间" money:model.cre_datetime];
    }else if([type isEqualToString:@"khwdbkc"]){
        NSString* orderId = [NSString stringWithFormat:@"订单号:%@",model.order_id];
        [_orderId reloadData:orderId money:@"" btnTitle:@""];
        
        _moneyLbl.text = [NSString stringWithFormat:@"¥%@",model.money];
        
        [_snId reloadData:@"SN号" money:model.sn];
        
        [_type reloadData:@"考核类型" money:model.assess_name];
        
        [_date reloadData:@"考核周期" money:[NSString stringWithFormat:@"%@-%@",model.start_date,model.end_date]];
        
        [_time reloadData:@"扣除时间" money:model.cre_datetime];
    }
    
   
}
@end
