//
//  FenRunDetailCell.m
//  XZF
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "MerchantCell.h"
static NSInteger padding = 15;
static NSInteger height = 24;
@interface MerchantCell()

@property (nonatomic, strong) UIImageView     *img;

@property (nonatomic, strong) UILabel         *title;

@property (nonatomic, strong) UILabel         *desc;

@property (nonatomic, strong) UILabel         *right;

@property (nonatomic, strong) UIImageView     *arrow;

@property (nonatomic, strong) MXSeparatorLine *line;

@end
@implementation MerchantCell

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
    [self addSubview:self.img];
    [self addSubview:self.title];
    [self addSubview:self.desc];
    [self addSubview:self.right];
    [self addSubview:self.arrow];
    [self addSubview:self.line];
}

-(void)layout{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self.img);
        make.right.equalTo(self.arrow);
        make.height.equalTo(@(1));
    }];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(height));
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(padding);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right.mas_left);
        make.centerY.equalTo(self.img.mas_top);
        make.left.equalTo(self.img.mas_right).offset(padding);
    }];
    
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right.mas_left);
        make.centerY.equalTo(self.img.mas_bottom);
        make.left.equalTo(self.title);
    }];
    
    [self.right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(50));
        make.centerY.equalTo(self);
        make.right.equalTo(self.arrow.mas_left);
    }];
    
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(13));
        make.height.equalTo(@(13));
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

-(UIImageView*)img{
    if (!_img) {
        _img = [UIImageView new];
    }
    return _img;
}

-(UILabel*)title{
    if (!_title) {
        _title = [UILabel new];
        _title.textColor = [UIColor moBlack];
        [_title setFont:[UIFont font15]];
    }
    return _title;
}

-(UILabel*)desc{
    if (!_desc) {
        _desc = [UILabel new];
        _desc.textColor = [UIColor moPlaceHolder];
        [_desc setFont:[UIFont font12]];
    }
    return _desc;
}

-(UILabel*)right{
    if (!_right) {
        _right = [UILabel new];
        _right.textColor = [UIColor moPlaceHolder];
        _right.textAlignment = NSTextAlignmentCenter;
        [_right setFont:[UIFont font15]];
    }
    return _right;
}

-(UIImageView*)arrow{
    if (!_arrow) {
        _arrow = [UIImageView new];
        _arrow.image = [UIImage imageNamed:@"选择"];
    }
    return _arrow;
}

-(MXSeparatorLine*)line{
    if (!_line) {
        _line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    }
    return _line;
}

-(void)reload:(NSString *)image top:(NSString*)top bottom:(NSString*)bottom right:(NSString*)right{
    self.img.image = [UIImage imageNamed:image];
    self.title.text = top;
    self.desc.text = bottom;
    if ([right isKindOfClass:[NSNumber class]]) {
        self.right.text = [NSString stringWithFormat:@"%d",[right intValue] ];
    }else{
        self.right.text = right;
    }
}
@end
