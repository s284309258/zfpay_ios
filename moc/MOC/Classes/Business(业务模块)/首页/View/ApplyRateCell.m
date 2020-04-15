//
//  PosDetailCell.m
//  XZF
//
//  Created by mac on 2019/8/10.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ApplyRateCell.h"
static NSInteger iconWidth = 45;
static NSInteger padding = 15;
@interface ApplyRateCell()

@property (nonatomic , strong) UIImageView* iconImg;

@property (nonatomic , strong) UILabel* titleLbl;

@property (nonatomic , strong) UILabel* descLbl;

@property (nonatomic , strong) UIButton* selectBtn;

@property (nonatomic , strong) MXSeparatorLine* line;

@end
@implementation ApplyRateCell
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
    [self addSubview:self.descLbl];
    [self addSubview:self.selectBtn];
    [self addSubview:self.line];
}

-(void)layout{
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self);
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20));
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self);
    }];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(padding);
        make.centerY.equalTo(self.mas_centerY).multipliedBy(0.5);
        make.right.equalTo(self.selectBtn.mas_left);
    }];
    [self.descLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl);
        make.centerY.equalTo(self.mas_centerY).multipliedBy(1.5);
        make.right.equalTo(self.selectBtn.mas_left);
    }];
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
        _iconImg.image = [UIImage imageNamed:@"传统POS_rate"];
    }
    return _iconImg;
}

-(UILabel*)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.text = @"SN码:CS0000001";
        _titleLbl.textColor = [UIColor moBlack];
        _titleLbl.font = [UIFont systemFontOfSize:16];
    }
    return _titleLbl;
}

-(UILabel*)descLbl{
    if (!_descLbl) {
        _descLbl = [UILabel new];
        _descLbl.text = @"当前费率";
        _descLbl.textColor = [UIColor moPlaceHolder];
        _descLbl.font = [UIFont systemFontOfSize:13];
    }
    return _descLbl;
}

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

-(void)reload:(ApplyRateModel*)model select:(BOOL)isSelect type:(NSString*)type{
    
    if ([type isEqualToString:@"MPOS"]) {
        self.iconImg.image = [UIImage imageNamed:@"MPOS-1"];
    }else if([type isEqualToString:@"CTPOS"]){
        self.iconImg.image = [UIImage imageNamed:@"传统POS_rate"];
    }else if([type isEqualToString:@"EPOS"]){
        self.iconImg.image = [UIImage imageNamed:@"EPOS_rate"];
    }
    if (isSelect) {
        [_selectBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
    }else{
        [_selectBtn setImage:nil forState:UIControlStateNormal];
    }
    self.titleLbl.text = [NSString stringWithFormat:@"SN码:%@",model.sn];
    self.descLbl.text = [NSString stringWithFormat:@"当前费率:%@%%",model.credit_card_rate];
}
@end
