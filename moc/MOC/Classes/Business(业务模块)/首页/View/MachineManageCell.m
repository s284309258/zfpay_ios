//
//  PosDetailCell.m
//  XZF
//
//  Created by mac on 2019/8/10.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "MachineManageCell.h"
static NSInteger iconWidth = 45;
static NSInteger padding = 15;
@interface MachineManageCell()


@property (nonatomic , strong) UILabel* titleLbl;

@property (nonatomic , strong) UILabel* descLbl1;

//@property (nonatomic , strong) UILabel* descLbl2;

@property (nonatomic , strong) UIButton* selectBtn;

@property (nonatomic , strong) MXSeparatorLine* line;

@end
@implementation MachineManageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.iconImg];
    [self addSubview:self.titleLbl];
    [self addSubview:self.descLbl1];
//    [self addSubview:self.descLbl2];
    [self addSubview:self.selectBtn];
    [self addSubview:self.line];
}

-(void)layout{
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self).offset(10);
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20));
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self);
    }];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(10);
        make.top.equalTo(self.iconImg);
        make.right.equalTo(self.selectBtn.mas_left);
        make.height.equalTo(@(25));
    }];
    [self.descLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl);
        make.top.equalTo(self.titleLbl.mas_bottom);
        make.right.equalTo(self.selectBtn.mas_left);
        make.bottom.equalTo(self);
    }];
//    [self.descLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.titleLbl);
//        make.top.equalTo(self.descLbl1.mas_bottom).offset(10);
//        make.right.equalTo(self.selectBtn.mas_left);
//    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg);
        make.right.equalTo(self.selectBtn);
        make.height.equalTo(@(1));
        make.bottom.equalTo(self);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(UIImageView*)iconImg{
    if (!_iconImg) {
        _iconImg = [UIImageView new];
    }
    return _iconImg;
}

-(UILabel*)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.textColor = [UIColor moBlack];
        _titleLbl.font = [UIFont systemFontOfSize:16];
        _titleLbl.adjustsFontSizeToFitWidth = YES;
        _titleLbl.numberOfLines = 2;
    }
    return _titleLbl;
}
-(UILabel*)descLbl1{
    if (!_descLbl1) {
        _descLbl1 = [UILabel new];
        _descLbl1.textColor = [UIColor moPlaceHolder];
        _descLbl1.font = [UIFont systemFontOfSize:13];
        _descLbl1.numberOfLines = 0;
    }
    return _descLbl1;
}

//-(UILabel*)descLbl2{
//    if (!_descLbl2) {
//        _descLbl2 = [UILabel new];
//        _descLbl2.textColor = [UIColor moPlaceHolder];
//        _descLbl2.font = [UIFont systemFontOfSize:13];
//    }
//    return _descLbl2;
//}

-(UIButton*)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
    }
    return _selectBtn;
}

-(MXSeparatorLine*) line{
    if (!_line) {
        _line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    }
    return _line;
}

-(void)reload:(PosAllocationModel*)model select:(BOOL)isSelect type:(NSInteger)type{
    if (isSelect) {
        [_selectBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
    }else{
        [_selectBtn setImage:[UIImage imageNamed:@"None"] forState:UIControlStateNormal];
    }
    if (type == 0) {
        self.iconImg.image = [UIImage imageNamed:@"MPOS-1"];
        self.titleLbl.text = [NSString stringWithFormat:@"SN码:%@",model.sn];
    }else if(type == 1){
        self.iconImg.image = [UIImage imageNamed:@"传统POS_rate"];
        self.titleLbl.text = [NSString stringWithFormat:@"SN码:%@",model.sn];
    }else if(type == 2){
        self.iconImg.image = [UIImage imageNamed:@"EPOS_rate"];
        self.titleLbl.text = [NSString stringWithFormat:@"SN码:%@",model.sn];
    }else if(type == 3){
        self.iconImg.image = [UIImage imageNamed:@"流量卡"];
        self.titleLbl.text = [NSString stringWithFormat:@"流量卡号:%@",model.card_no];
    }
    NSString* vipPrice = [StringUtil isEmpty:model.card_settle_price_vip]?@"--":model.card_settle_price_vip;
    _descLbl1.text = [NSString stringWithFormat:@"刷卡结算价:%@%%\n云闪付结算价:%@%%\n激活剩余天数:%@\nVIP结算价:%@\n政策:%@",model.card_settle_price,model.cloud_settle_price,[StringUtil isEmpty:model.expire_day]?@"0":model.expire_day,vipPrice,model.policy_name?:@"--"];
//    _descLbl2.text = [NSString stringWithFormat:@"",model.cloud_settle_price];
}

-(void)LLKLayout{
    [self.iconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self);
    }];
  
    [self.titleLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(10);
        make.right.equalTo(self.selectBtn.mas_left);
        make.centerY.equalTo(self);
    }];
    [self.selectBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20));
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self);
    }];
      self.descLbl1.hidden = YES;
//      self.descLbl2.hidden = YES;
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg);
        make.right.equalTo(self.selectBtn);
        make.height.equalTo(@(1));
        make.bottom.equalTo(self);
    }];
}
@end
