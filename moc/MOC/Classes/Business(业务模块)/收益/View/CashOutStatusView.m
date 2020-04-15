//
//  CashOutStatusView.m
//  XZF
//
//  Created by mac on 2019/8/9.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "CashOutStatusView.h"
#import "ProfitFormView.h"
#import "CashOutStatusView.h"
static NSInteger height = 25;
@interface CashOutStatusView()

@property (nonatomic , strong) UILabel* title;

@property (nonatomic , strong) UIImageView* form1Img;

@property (nonatomic , strong) UIImageView* form2Img;

@property (nonatomic , strong) UIImageView* form3Img;

@property (nonatomic , strong) ProfitFormView* form1;

@property (nonatomic , strong) ProfitFormView* form2;

@property (nonatomic , strong) ProfitFormView* form3;


@end

@implementation CashOutStatusView


- (instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.title];
    [self addSubview:self.form1Img];
    [self addSubview:self.form2Img];
    [self addSubview:self.form3Img];
    [self addSubview:self.form1];
    [self addSubview:self.form2];
    [self addSubview:self.form3];
    
}

-(void)layout{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.form1);
        make.left.equalTo(self).offset(15);
        make.width.equalTo(@(80));
    }];
    [self.form1Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(10));
        make.centerY.equalTo(self.form1);
        make.left.equalTo(self.title.mas_right);
    }];
    [self.form1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.form1Img.mas_right);
        make.right.equalTo(self);
        make.height.equalTo(@(height));
    }];
    [self.form2Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(10));
        make.centerY.equalTo(self.form2);
        make.left.equalTo(self.form1Img);
    }];
    [self.form2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.form1.mas_bottom);
        make.left.equalTo(self.form2Img.mas_right);
        make.right.equalTo(self);
        make.height.equalTo(@(height));
    }];
    [self.form3Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(10));
        make.centerY.equalTo(self.form3);
        make.left.equalTo(self.form1Img);
    }];
    [self.form3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.form2.mas_bottom);
        make.left.equalTo(self.form3Img.mas_right);
        make.right.equalTo(self);
        make.height.equalTo(@(height));
    }];
    
}

-(UILabel*)title{
    if (!_title) {
        _title = [UILabel new];
        _title.text = @"处理进度";
        _title.font = [UIFont systemFontOfSize:13];
        _title.textColor = [UIColor moPlaceHolder];
    }
    return _title;
}

-(ProfitFormView*)form1{
    if (!_form1) {
        _form1 = [[ProfitFormView alloc]initWithFrame:CGRectZero];
        [_form1 reloadData:@"--" money:@"--"];
        _form1.moneyLbl.textColor = [UIColor moPlaceHolder];
    }
    return _form1;
}

-(ProfitFormView*)form2{
    if (!_form2) {
        _form2 = [[ProfitFormView alloc]initWithFrame:CGRectZero];
        [_form2 reloadData:@"--" money:@"--"];
         _form2.moneyLbl.textColor = [UIColor moPlaceHolder];
    }
    return _form2;
}

-(ProfitFormView*)form3{
    if (!_form3) {
        _form3 = [[ProfitFormView alloc]initWithFrame:CGRectZero];
        [_form3 reloadData:@"--" money:@"--"];
         _form3.moneyLbl.textColor = [UIColor moPlaceHolder];
    }
    return _form3;
}

-(UIImageView*)form1Img{
    if (!_form1Img) {
        _form1Img = [UIImageView new];
    }
    return _form1Img;
}

-(UIImageView*)form2Img{
    if (!_form2Img) {
        _form2Img = [UIImageView new];
    }
    return _form2Img;
}

-(UIImageView*)form3Img{
    if (!_form3Img) {
        _form3Img = [UIImageView new];
    }
    return _form3Img;
}


-(void)reloadArray:(NSArray*)data{
    if (data.count >0) {
        CashRecordDetailModel* model = data[0];
        [_form1 reloadData:@"申请提现" money:model.cre_date];
        _form1.typeLbl.textColor = [UIColor moGreen];
        _form1Img.image = [UIImage imageNamed:@"绿圈"];
    }
    if (data.count >1) {
        CashRecordDetailModel* model = data[1];
         [_form2 reloadData:@"处理中" money:model.cre_date];
        _form2.typeLbl.textColor = [UIColor moGreen];
        _form2Img.image = [UIImage imageNamed:@"绿圈"];
    }else{
        _form2Img.image = [UIImage imageNamed:@"灰圈"];
         [_form2 reloadData:@"--" money:@"--"];
        _form2.typeLbl.textColor = [UIColor moPlaceHolder];
    }
    if (data.count >2) {
        CashRecordDetailModel* model = data[2];
        if ([model.cash_status isEqualToString:@"08"]) {
            [_form3 reloadData:@"处理失败" money:model.cre_date];
            _form3Img.image = [UIImage imageNamed:@"红圈"];
            _form3.typeLbl.textColor = [UIColor redColor];
        }else if([model.cash_status isEqualToString:@"04"]){
            [_form3 reloadData:@"已撤销" money:model.cre_date];
            _form3Img.image = [UIImage imageNamed:@"红圈"];
            _form3.typeLbl.textColor = [UIColor redColor];
        }else if([model.cash_status isEqualToString:@"09"]){
            [_form3 reloadData:@"处理成功" money:model.cre_date];
            _form3Img.image = [UIImage imageNamed:@"绿圈"];
            _form3.typeLbl.textColor = [UIColor moGreen];
        }else{
            _form3Img.image = [UIImage imageNamed:@"灰圈"];
            [_form3 reloadData:@"--" money:@"--"];
            _form3.typeLbl.textColor = [UIColor moPlaceHolder];
        }
    }else{
        _form3Img.image = [UIImage imageNamed:@"灰圈"];
        [_form3 reloadData:@"--" money:@"--"];
        _form3.typeLbl.textColor = [UIColor moPlaceHolder];
    }
}
@end
