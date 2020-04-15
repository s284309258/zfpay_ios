//
//  ApplicationView.m
//  MOC
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ApplicationView.h"
static NSInteger imgWidth = 24;
static NSInteger padding = 15;
@interface ApplicationView()

@property (nonatomic, strong) UILabel     *lbl;

@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, strong) UIImageView *arrowImg;

@end

@implementation ApplicationView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.img];
    [self addSubview:self.lbl];
    [self addSubview:self.arrowImg];
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@(1));
        make.bottom.equalTo(self);
    }];
}

-(void)layout{
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.width.height.equalTo(@(imgWidth));
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img.mas_right).offset(14);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.width.equalTo(@(16));
        make.height.equalTo(@(16));
        make.centerY.equalTo(self.mas_centerY);
    }];
}

-(UIImageView*)img{
    if (!_img) {
        _img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"矩形 2"]];
    }
    return _img;
}

-(UIImageView*)arrowImg{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"矩形 2"]];
    }
    return _arrowImg;
}

- (UILabel *)lbl
{
    if (!_lbl) {
        _lbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbl.textAlignment = NSTextAlignmentCenter;
        _lbl.font = [UIFont systemFontOfSize:17];
        _lbl.textColor = [UIColor moBlack];
        _lbl.text = Lang(@"金融");
    }
    
    return _lbl;
}

-(void)reloadImg:(NSString* )imgPath text:(NSString* )text{
    self.img.image = [UIImage imageNamed:imgPath];
    self.lbl.text = text;
}

@end
