//
//  MerchantTradeDetailCell.m
//  XZF
//
//  Created by mac on 2020/3/14.
//  Copyright © 2020 AlphaGo. All rights reserved.
//

#import "MerchantTradeDetailCell.h"
@interface MerchantTradeDetailCell()

@property (nonatomic,strong) MXSeparatorLine* horiLine;

@property (nonatomic,strong) MXSeparatorLine* vertiLine1;

@property (nonatomic,strong) MXSeparatorLine* vertiLine2;


@end
@implementation MerchantTradeDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setupData];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self setupData];
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

-(void)setupUI{
    self.horiLine = [self createLine];
    self.vertiLine1 = [self createLine];
    self.vertiLine2 = [self createLine];
    self.vertiLine1.hidden = YES;
    self.vertiLine2.hidden = YES;
    self.timeLbl = [self createLbl];
    self.moneyLbl = [self createLbl];
    self.profitLbl = [self createLbl];
    [self addSubview:self.timeLbl];
    [self addSubview:self.moneyLbl];
    [self addSubview:self.profitLbl];
    [self addSubview:self.horiLine];
    [self addSubview:self.vertiLine1];
    [self addSubview:self.vertiLine2];
    [self.timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@(0));
        make.left.equalTo(@(15));
        make.right.equalTo(self.moneyLbl.mas_left);
    }];
    [self.moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLbl.mas_right);
        make.top.bottom.equalTo(self.timeLbl);
        make.width.equalTo(self.timeLbl);
    }];
    [self.profitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyLbl.mas_right);
        make.right.equalTo(@(-15));
        make.top.bottom.equalTo(self.timeLbl);
        make.width.equalTo(self.moneyLbl);
    }];
    [self.horiLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@(0));
        make.height.equalTo(@(.5));
    }];
    [self.vertiLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLbl.mas_right);
        make.top.bottom.equalTo(self.timeLbl);
        make.width.equalTo(@(.5));
    }];
    [self.vertiLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyLbl.mas_right);
        make.top.bottom.equalTo(self.timeLbl);
        make.width.equalTo(@(.5));
    }];
    
}

-(void)setupData{
    
}

-(void)reload:(PosTradeModel*)model{
    {
        NSString* amount_title = @"交易金额(元)";
        NSString* amount = model.trans_amount;
        NSString* str = [NSString stringWithFormat:@"%@\n%@",amount_title,amount];
        NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
        [attr addFont:[UIFont font12] substring:amount_title];
        [attr addFont:[UIFont systemFontOfSize:10] substring:amount];
        [attr addColor:[UIColor blackColor] substring:amount_title];
        [attr addColor:[UIColor lightGrayColor] substring:amount];
        [attr setLineSpacing:10 substring:str alignment:NSTextAlignmentLeft];
        self.timeLbl.attributedText = attr;
    }
    {
          NSString* money_title = @"贡献利润(元)";
          NSString* money = model.benefit_money;
          NSString* str = [NSString stringWithFormat:@"%@\n%@",money_title,money];
          NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
          [attr addFont:[UIFont font12] substring:money_title];
          [attr addFont:[UIFont systemFontOfSize:10] substring:money];
          [attr addColor:[UIColor blackColor] substring:money_title];
          [attr addColor:[UIColor lightGrayColor] substring:money];
          [attr setLineSpacing:10 substring:str alignment:NSTextAlignmentCenter];
          self.moneyLbl.attributedText = attr;
      }
    {
          NSString* time_title = @"交易时间";
          NSString* time = model.trans_time;
          NSString* str = [NSString stringWithFormat:@"%@\n%@",time_title,time];
          NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
          [attr addFont:[UIFont font12] substring:time_title];
          [attr addFont:[UIFont systemFontOfSize:10] substring:time];
          [attr addColor:[UIColor blackColor] substring:time_title];
          [attr addColor:[UIColor lightGrayColor] substring:time];
          [attr setLineSpacing:10 substring:str alignment:NSTextAlignmentRight];
          self.profitLbl.attributedText = attr;
      }
}

-(MXSeparatorLine*)createLine{
    return ({
        MXSeparatorLine* line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
        line.backgroundColor = [UIColor lightGrayColor];
        line;
    });
}

-(UILabel*)createLbl{
    return ({
        UILabel* tmp = [UILabel new];
        tmp.textColor = [UIColor moBlack];
        tmp.font = [UIFont font14];
        tmp.numberOfLines = 0;
        tmp.textAlignment = NSTextAlignmentCenter;
        tmp;
        });
}
@end
