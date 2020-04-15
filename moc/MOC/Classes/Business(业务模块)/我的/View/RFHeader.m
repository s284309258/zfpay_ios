//
//  RFHeader.m
//  XZF
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "RFHeader.h"
@interface RFHeader()

@property (nonatomic ,strong) UIImageView* leftImg;

@property (nonatomic ,strong) UILabel* leftLbl;


@end
@implementation RFHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.leftImg];
    [self addSubview:self.leftLbl];
    [self addSubview:self.rightLbl];
}

-(void)layout{
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(@(5));
        make.height.equalTo(@(15));
    }];
    [self.leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImg.mas_right).offset(5);
        make.centerY.equalTo(self);
//        make.right.equalTo(self.rightLbl.mas_left);
        make.height.equalTo(@(15));
    }];
    [self.rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@(30));
    }];
}

-(UIImageView *)leftImg{
    if (!_leftImg) {
        _leftImg = [UIImageView new];
    }
    return _leftImg;
}

-(UILabel *)leftLbl{
    if (!_leftLbl) {
        _leftLbl = [UILabel new];
        _leftLbl.font = [UIFont font15];
        _leftLbl.text = @"MPOS";
    }
    return _leftLbl;
}
- (UIButton *)rightLbl{
    if (!_rightLbl) {
        _rightLbl = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
        _rightLbl.frame = CGRectMake(0, 0, 80, 45);
        _rightLbl.titleLabel.font = [UIFont font14];
        _rightLbl.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_rightLbl setTitleColor:[UIColor moBlack] forState:UIControlStateNormal];
        [_rightLbl addTarget:self action:@selector(open:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightLbl;
}

-(void)open:(id)sender{
    if (self.block) {
        self.block(nil);
    }
}
- (void)reloadColor:(NSString *)color left:(NSString* )left right:(NSString* )right{
    self.leftImg.backgroundColor = [UIColor colorWithHexString:color];
    self.leftLbl.text = left;
    [self.rightLbl setTitle:right forState:UIControlStateNormal];
}

- (void)reloadColor:(NSString *)color left:(NSString* )left rightImg:(NSString*)image rightText:(NSString*)text{
    self.leftImg.backgroundColor = [UIColor colorWithHexString:color];
    self.leftLbl.text = left;
    [self.rightLbl setTitle:text forState:UIControlStateNormal];
    [self.rightLbl setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}
+(int)getHeight{
    return 55;
}

@end
