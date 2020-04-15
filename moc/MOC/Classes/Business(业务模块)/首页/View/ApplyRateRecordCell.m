//
//  PosDetailCell.m
//  XZF
//
//  Created by mac on 2019/8/10.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ApplyRateRecordCell.h"
static NSInteger iconWidth = 45;
static NSInteger padding = 15;
@interface ApplyRateRecordCell()

@property (nonatomic , strong) UILabel* titleLbl;

@property (nonatomic , strong) UILabel* descLbl;

@property (nonatomic , strong) UILabel* stateLbl;

@property (nonatomic , strong) UILabel* dateLbl;

@property (nonatomic , strong) UILabel* remarkLbl;

@property (nonatomic , strong) MXSeparatorLine* line;

@end
@implementation ApplyRateRecordCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.titleLbl];
    [self addSubview:self.descLbl];
    [self addSubview:self.stateLbl];
    [self addSubview:self.dateLbl];
    [self addSubview:self.remarkLbl];
    [self addSubview:self.line];
}

-(void)layout{
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(padding));
        make.right.equalTo(self.mas_centerX);
        make.top.equalTo(@(5));
//        make.bottom.equalTo(self.mas_centerY);
    }];
    [self.descLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl);
        make.right.equalTo(self.mas_centerX);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(5);
    }];
    [self.stateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX);
        make.top.equalTo(self.titleLbl);
        make.right.equalTo(self).offset(-padding);
    }];
    [self.dateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.descLbl.mas_centerY);
        make.right.equalTo(self).offset(-padding);
    }];
    [self.remarkLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl);
        make.right.equalTo(self.stateLbl);
        make.top.equalTo(self.descLbl.mas_bottom).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl);
        make.right.equalTo(self.stateLbl);
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

-(UILabel*)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.textColor = [UIColor moBlack];
        _titleLbl.font = [UIFont systemFontOfSize:15];
    }
    return _titleLbl;
}

-(UILabel*)descLbl{
    if (!_descLbl) {
        _descLbl = [UILabel new];
        
        _descLbl.textColor = [UIColor moPlaceHolder];
        _descLbl.font = [UIFont systemFontOfSize:13];
    }
    return _descLbl;
}

-(UILabel*)stateLbl{
    if (!_stateLbl) {
        _stateLbl = [UILabel new];
        _stateLbl.font = [UIFont systemFontOfSize:14];
        _stateLbl.textAlignment = NSTextAlignmentRight;
    }
    return _stateLbl;
}

-(UILabel*)dateLbl{
    if (!_dateLbl) {
        _dateLbl = [UILabel new];
        _dateLbl.textColor = [UIColor moPlaceHolder];
        _dateLbl.font = [UIFont systemFontOfSize:13];
        _dateLbl.textAlignment = NSTextAlignmentRight;
    }
    return _dateLbl;
}

-(UILabel*)remarkLbl{
    if (!_remarkLbl) {
        _remarkLbl = [UILabel new];
        _remarkLbl.textColor = [UIColor redColor];
        _remarkLbl.font = [UIFont systemFontOfSize:13];
//        _remarkLbl.textAlignment = NSTextAlignmentRight;
        _remarkLbl.numberOfLines = 0;
    }
    return _remarkLbl;
}

-(MXSeparatorLine*) line{
    if (!_line) {
        _line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    }
    return _line;
}
//00-申请中 08-申请失败 09-申请成功
-(void)reload:(ApplyScanRecordModel*)model{
    _titleLbl.text = [NSString stringWithFormat:@"SN码:%@",model.sn];
    _descLbl.text = @"申请类型:微信、支付宝";
    if ([model.status isEqualToString:@"00"]) {
        _stateLbl.text = @"申请中";
        _stateLbl.textColor = [UIColor redColor];
    }else if ([model.status isEqualToString:@"08"]) {
        _stateLbl.text = @"申请失败";
        _stateLbl.textColor = [UIColor moPlaceHolder];
    }else if ([model.status isEqualToString:@"09"]) {
        _stateLbl.text = @"申请成功";
        _stateLbl.textColor = [UIColor moGreen];
    }
    
    _dateLbl.text = model.cre_datetime;
}


-(void)reloadRate:(ApplyRateRecordModel *)model{
    _titleLbl.text = [NSString stringWithFormat:@"SN码:%@",model.sn];
    _descLbl.text = [NSString stringWithFormat:@"费率更改:%@-→%@",model.credit_card_rate_old,model.credit_card_rate_new];
    if ([model.status isEqualToString:@"00"]) {
        _stateLbl.text = @"申请中";
        _stateLbl.textColor = [UIColor redColor];
    }else if ([model.status isEqualToString:@"08"]) {
        _stateLbl.text = @"申请失败";
        _stateLbl.textColor = [UIColor moPlaceHolder];
    }else if ([model.status isEqualToString:@"09"]) {
        _stateLbl.text = @"申请成功";
        _stateLbl.textColor = [UIColor moGreen];
    }
    _dateLbl.text = model.cre_datetime;
    if (model.remark) {
        self.remarkLbl.text = model.remark;
    }
}

@end
