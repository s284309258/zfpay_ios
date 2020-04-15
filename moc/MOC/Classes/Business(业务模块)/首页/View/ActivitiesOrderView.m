//
//  FenRunDetailCell.m
//  XZF
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ActivitiesOrderView.h"
#import "ProfitFormView.h"
#import "NSDate+String.h"
static NSInteger padding = 10;
static NSInteger height = 28;
@interface ActivitiesOrderView()

@property (nonatomic , strong) UIImageView* img;

@property (nonatomic , strong) UILabel* lbl;

@property (nonatomic , strong) ProfitFormView* orderId;

@property (nonatomic , strong) ProfitFormView* activityType;

@property (nonatomic , strong) ProfitFormView* rewardType;

@property (nonatomic , strong) ProfitFormView* activityTime;

@property (nonatomic , strong) ProfitFormView* applyTime;

@property (nonatomic , strong) ProfitFormView* updateTime;

@property (nonatomic , strong) MXSeparatorLine* bottomLine;

@end
@implementation ActivitiesOrderView

- (instancetype)init{
    if (self = [super init]) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.img];
    [self addSubview:self.lbl];
    [self addSubview:self.orderId];
    [self addSubview:self.activityType];
    [self addSubview:self.rewardType];
    [self addSubview:self.activityTime];
    [self addSubview:self.applyTime];
    [self addSubview:self.updateTime];
    self.bottomLine = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.bottomLine];
}

-(void)layout{
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(25);
        make.width.height.equalTo(@(44));
    }];
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.img.mas_bottom).offset(15);
        make.left.right.equalTo(self);
    }];
    [self.orderId mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self.lbl).offset(40);
        make.height.equalTo(@(height));
    }];
    [self.activityType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self.orderId.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.rewardType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self.activityType.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.activityTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self.rewardType.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.applyTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self.activityTime.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.updateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self.applyTime.mas_bottom);
        make.height.equalTo(@(height));
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(10));
        make.bottom.equalTo(self);
        make.left.right.equalTo(self);
    }];
}

-(ProfitFormView*)orderId{
    if (!_orderId) {
        _orderId = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _orderId;
}

-(ProfitFormView*)activityType{
    if (!_activityType) {
        _activityType = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _activityType;
}

-(ProfitFormView*)rewardType{
    if (!_rewardType) {
        _rewardType = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _rewardType;
}

-(ProfitFormView*)activityTime{
    if (!_activityTime) {
        _activityTime = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _activityTime;
}

-(ProfitFormView*)applyTime{
    if (!_applyTime) {
        _applyTime = [[ProfitFormView alloc]initWithFrame:CGRectZero];
    }
    return _applyTime;
}

-(ProfitFormView*)updateTime{
    if (!_updateTime) {
        _updateTime = [[ProfitFormView alloc]initWithFrame:CGRectZero];
        _updateTime.hidden = YES;
    }
    return _updateTime;
}

-(UIImageView*)img{
    if (!_img) {
        _img = [UIImageView new];
        
    }
    return _img;
}

-(UILabel*)lbl{
    if (!_lbl) {
        _lbl = [UILabel new];
        _lbl.font = [UIFont font18];
        _lbl.textColor = [UIColor moBlack];
        _lbl.textAlignment = NSTextAlignmentCenter;
       
    }
    return _lbl;
}

-(void)reload:(PosActivityApplyDetailModel*)model{
    if ([model.status isEqualToString:@"00"]) {
        _img.image = [UIImage imageNamed:@"审核中"];
        _lbl.text = @"审核中";
    }else if([model.status isEqualToString:@"04"]){
        _img.image = [UIImage imageNamed:@"审核失败1"];
        _lbl.text = @"取消活动";
    }else if([model.status isEqualToString:@"08"]){
        _img.image = [UIImage imageNamed:@"审核失败1"];
        _lbl.text = @"审核不通过";
    }else if([model.status isEqualToString:@"09"]){
         _img.image = [UIImage imageNamed:@"认证成功1"];
        _lbl.text = @"已通过";
    }
    
    
    [_orderId reloadData:@"订单号" money:model.order_id];
    [_activityType reloadData:@"活动类型" money:model.activity_name ];
    [_rewardType reloadData:@"奖励类型" money:[NSString stringWithFormat:@"奖励%@台,交易额达到%@万,返现%@元",model.pos_num,model.expenditure,model.reward_money]];
    
    NSDate* start_date = [NSDate dateWithString:model.start_date withDateFormat:@"yyyyMMdd"];
    NSDate* end_date = [NSDate dateWithString:model.end_date withDateFormat:@"yyyyMMdd"];
    
    NSString* start_str = @"";
    if (start_date) {
        start_str =[NSDate dateString:start_date format:@"yyyy.MM.dd"];
    }
    NSString* end_str = @"";
    if (end_date) {
        end_str = [NSDate dateString:end_date format:@"yyyy.MM.dd"];
    }
    [_activityTime reloadData:@"活动周期" money:[NSString stringWithFormat:@"%@-%@",start_str,end_str]];
    
    [_applyTime reloadData:@"申请时间" money:model.cre_datetime];
    
    [_updateTime reloadData:@"更新时间" money:model.cre_datetime];
}
@end
