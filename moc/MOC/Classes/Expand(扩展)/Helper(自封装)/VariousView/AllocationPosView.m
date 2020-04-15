//
//  AllocationPosView.m
//  XZF
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "AllocationPosView.h"

static NSInteger iconWidth = 13;
@interface AllocationPosView()

@property (nonatomic,strong) UILabel* leftLbl;

@property (nonatomic,strong) UILabel* centerLbl;

@property (nonatomic,strong) UILabel* rightLbl;

@property (nonatomic,strong) UIImageView* rightImg;

@property (nonatomic,strong) MXSeparatorLine* line;


@end
@implementation AllocationPosView

-(instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.leftLbl];
    [self addSubview:self.centerLbl];
    [self addSubview:self.rightLbl];
    [self addSubview:self.rightImg];
    
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
    [self.leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
    }];
    [self.centerLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.rightLbl.mas_left).offset(-10);
//        make.width.equalTo(@(30));
    }];
    [self.rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImg.mas_left).offset(-10);
        make.top.bottom.equalTo(self);
    }];
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.right.equalTo(self);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.left.right.bottom.equalTo(self);
    }];
}

-(UILabel*)leftLbl{
    if (!_leftLbl) {
        _leftLbl = [UILabel new];
        _leftLbl.numberOfLines = 0;
    }
    return _leftLbl;
}

-(UILabel*)centerLbl{
    if (!_centerLbl) {
        _centerLbl = [UILabel new];
        _centerLbl.numberOfLines = 0;
        _centerLbl.font = [UIFont font12];
        _centerLbl.textColor = [UIColor moBlack];
    }
    return _centerLbl;
}

-(UILabel*)rightLbl{
    if (!_rightLbl) {
        _rightLbl = [UILabel new];
        _rightLbl.numberOfLines = 0;
    }
    return _rightLbl;
}

-(UIImageView*)rightImg{
    if (!_rightImg) {
        _rightImg = [UIImageView new];
        _rightImg.image = [UIImage imageNamed:@"选择"];
    }
    return _rightImg;
}

-(void)reload:(AllocationPosBatchModel*)model{
    {
        NSString* leftStr = [NSString stringWithFormat:@"SN码:\n代理:%@\n%@",model.real_name?:@"--",model.allocate_date];
        NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:leftStr];
        [attr addFont:[UIFont font12] substring:leftStr];
        [attr addColor:[UIColor moBlack] substring:leftStr];
        [attr addFont:[UIFont font12] substring:model.allocate_date];
        [attr addColor:[UIColor lightGrayColor] substring:model.allocate_date];
        [attr setLineSpacing:5 substring:leftStr alignment:NSTextAlignmentLeft];
        self.leftLbl.attributedText = attr;
    }
    {
        NSString* rightStr = [NSString stringWithFormat:@"%@\n至\n%@",model.min_sn?:@"--",model.max_sn?:@"--"];
        NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:rightStr];
        [attr setLineSpacing:5 substring:rightStr alignment:NSTextAlignmentCenter];
         [attr addFont:[UIFont font12] substring:rightStr];
        self.rightLbl.attributedText = attr;
    }
    self.centerLbl.text = [NSString stringWithFormat:@"共%@台",model.cnt];
}
@end
