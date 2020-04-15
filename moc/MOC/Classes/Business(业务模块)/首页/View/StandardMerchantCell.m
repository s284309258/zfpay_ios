//
//  StandardMerchantCell.m
//  XZF
//
//  Created by mac on 2019/12/20.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "StandardMerchantCell.h"
static NSInteger padding = 15;
@interface StandardMerchantCell()

@property (strong, nonatomic) UILabel *name;

@property (strong, nonatomic) UILabel *no;

@property (strong, nonatomic) UILabel *money;

@property (strong, nonatomic) UILabel *date;

@property (strong, nonatomic) UICollectionViewFlowLayout *layout;

@end
@implementation StandardMerchantCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    [self.layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    CGFloat width = (SCREEN_WIDTH-2*padding-3*10) / 4;
    [self.layout setItemSize:CGSizeMake( width, 25)];
    [self.layout setMinimumInteritemSpacing:10];
    [self.layout setMinimumLineSpacing:5];
    
    [self addSubview:self.name];
    [self addSubview:self.no];
    [self addSubview:self.money];
    [self addSubview:self.date];
    [self addSubview:self.rewardView];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@(padding));
        make.right.equalTo(self.mas_centerX);
    }];
    [self.no mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name);
        make.left.equalTo(self.mas_centerX);
        make.right.equalTo(@(-padding));
    }];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.name);
        make.top.equalTo(self.name.mas_bottom).offset(10);
    }];
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.no);
        make.top.equalTo(self.money);
    }];
    [self.rewardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.money.mas_bottom).offset(padding);
        make.height.equalTo(@(44));
        make.left.equalTo(@(padding));
        make.right.equalTo(@(-padding));
        make.bottom.equalTo(self);
    }];
}

-(UILabel*)name{
    if (!_name) {
        _name = [UILabel new];
        _name.numberOfLines = 0;
    }
    return _name;
}

-(UILabel*)no{
    if (!_no) {
        _no = [UILabel new];
        _no.numberOfLines = 0;
    }
    return _no;
}

-(UILabel*)money{
    if (!_money) {
        _money = [UILabel new];
        _money.numberOfLines = 0;
    }
    return _money;
}

-(UILabel*)date{
    if (!_date) {
        _date = [UILabel new];
        _date.numberOfLines = 0;
    }
    return _date;
}

-(StandardRewardView*) rewardView{
    if (!_rewardView) {
        _rewardView = [StandardRewardView new];
    }
    return _rewardView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)reload:(PolicyRecordModel*)model{
    [self reload:model.mer_name no:model.mer_id money:model.trade_amount date:model.expire_day data:model];
}
-(void)reload:(NSString*)name no:(NSString*)no money:(NSString*)money date:(NSString*)date data:(PolicyRecordModel*)data{
    NSMutableAttributedString* nameAttr = [self getString:Lang(@"商户名") desc:name];
    NSMutableAttributedString* noAttr = [self getString:Lang(@"商户号:") desc:no];
    NSMutableAttributedString* moneyAttr = [self getString:Lang(@"已达标金额:") desc:money];
    date = [NSString stringWithFormat:@"%@天",date];
    NSMutableAttributedString* dateAttr = [self getString:Lang(@"距离奖励到期还剩:") desc:date];
    self.name.attributedText = nameAttr;
    self.no.attributedText = noAttr;
    self.money.attributedText = moneyAttr;
    [dateAttr addColor:[UIColor moOrange] substring:date];
    self.date.attributedText = dateAttr;
    
    [_rewardView reloadData:data.policyList layout:self.layout];
    [self.rewardView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.money.mas_bottom).offset(20);
        int height = (data.policy3List.count/4+(data.policy3List.count%4==0?0:1))*30;
        make.height.equalTo(@(height+5));
        make.left.equalTo(@(padding));
        make.right.equalTo(@(-padding));
        make.bottom.equalTo(self);
    }];
    [self.rewardView setNeedsLayout];
}

-(NSMutableAttributedString*)getString:(NSString*) title desc:(NSString*)desc{
    NSString* str = [NSString stringWithFormat:@"%@ %@",title,desc];
    NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
    [attr addFont:[UIFont font12] substring:title];
    [attr addFont:[UIFont font12] substring:desc];
    [attr addColor:[UIColor grayColor] substring:title];
    [attr addColor:[UIColor moBlack] substring:desc];
    return attr;
}


@end
