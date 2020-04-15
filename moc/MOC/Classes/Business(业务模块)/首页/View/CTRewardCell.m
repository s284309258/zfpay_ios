//
//  FenRunDetailCell.m
//  XZF
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "CTRewardCell.h"
#import "ProfitFormView.h"
static NSInteger padding = 10;
static NSInteger height = 28;
@interface CTRewardCell()

@property (nonatomic , strong) ProfitFormView* orderId;

@property (nonatomic , strong) UILabel* orderStatus;

@property (nonatomic , strong) MXSeparatorLine* line;

@property (nonatomic , strong) ProfitFormView* type1;

@property (nonatomic , strong) ProfitFormView* type2;

@property (nonatomic , strong) ProfitFormView* date;

@property (nonatomic , strong) UIView* backView;

@end
@implementation CTRewardCell

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
    [self addSubview:self.orderStatus];
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
    [self addSubview:self.type1];
    [self addSubview:self.type2];
    [self addSubview:self.date];
}

-(void)layout{
    [self.orderId mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.orderStatus.mas_left).offset(-5);
        make.top.equalTo(self).offset(padding);
        make.height.equalTo(@(height));
    }];
    [self.orderStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-2*padding);
        make.centerY.equalTo(self.orderId);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.left.equalTo(self.orderId);
        make.right.equalTo(self.orderStatus);
        make.top.equalTo(self.orderId.mas_bottom).offset(10);
    }];
    [self.type1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.line);
        make.top.equalTo(self.line.mas_bottom).offset(padding);
        make.height.equalTo(@(height));
    }];
    [self.type2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.line);
        make.top.equalTo(self.type1.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.line);
        make.top.equalTo(self.type2.mas_bottom);
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

-(ProfitFormView*)type1{
    if (!_type1) {
        _type1 = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _type1;
}

-(ProfitFormView*)type2{
    if (!_type2) {
        _type2 = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _type2;
}

-(ProfitFormView*)date{
    if (!_date) {
        _date = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _date;
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

-(UILabel*)orderStatus{
    if (!_orderStatus) {
        _orderStatus = [UILabel new];
        _orderStatus.textColor = [UIColor redColor];
        _orderStatus.font = [UIFont systemFontOfSize:13];
        _orderStatus.textAlignment = NSTextAlignmentRight;
    }
    return _orderStatus;
}


-(void)reload:(TraditionalPosActivityApplyModel*)model{
    [_orderId reloadData:[NSString stringWithFormat:@"订单号:%@",model.order_id] money:@"" btnTitle:@""];
    [_type1 reloadData:@"活动类型" money:model.activity_name];
    [_type2 reloadData:@"奖励类型" money:[NSString stringWithFormat:@"库存%@台,交易额达到%@万,返现%@元",model.pos_num,model.expenditure,model.reward_money]];
    [_date reloadData:@"申请时间" money:model.cre_datetime ];
    if ([model.status isEqualToString:@"00"]) {
        _orderStatus.text = @"审核中";
        _orderStatus.textColor = [UIColor redColor];
    }else if([model.status isEqualToString:@"04"]){
        _orderStatus.text = @"取消活动";
        _orderStatus.textColor = [UIColor redColor];
    }else if([model.status isEqualToString:@"09"]){
        _orderStatus.text = @"审核成功";
        _orderStatus.textColor = [UIColor moGreen];
    }else if([model.status isEqualToString:@"08"]){
        _orderStatus.text = @"审核失败";
        _orderStatus.textColor = [UIColor moPlaceHolder];
    }else{
         _orderStatus.text = @"";
    }
}
@end
