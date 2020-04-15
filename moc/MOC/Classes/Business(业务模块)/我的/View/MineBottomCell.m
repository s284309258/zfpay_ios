//
//  ChatSettingItemCell.m
//  Lcwl
//
//  Created by mac on 2018/12/1.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "MineBottomCell.h"

@interface MineBottomCell ()

@end

@implementation MineBottomCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _iconWidth = 35;
        [self initUI];
    }
    return self;
}

#pragma mark - UI
- (void)initUI
{
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.logoImgView];
    [self addSubview:self.nameLbl];
    
    [self layoutView];
}

-(void)layoutView{
    @weakify(self)
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY).offset(-10);
        make.centerX.equalTo(self.mas_centerX);
        make.width.height.equalTo(@(self.iconWidth));
    }];
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.logoImgView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(20));
        
    }];
    return;
}
- (UIImageView *)logoImgView
{
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _logoImgView.layer.masksToBounds = YES;
//        _logoImgView.layer.cornerRadius =  width/2;
        
    }
    
    return _logoImgView;
}

- (UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLbl.textAlignment = NSTextAlignmentCenter;
        _nameLbl.font = [UIFont boldFont14];
        _nameLbl.textColor = [UIColor moBlack];
    }
    
    return _nameLbl;
}

-(void)reloadImg:(NSString* )path name:(NSString* )name{
    self.logoImgView.image = [UIImage imageNamed:path];
    self.nameLbl.text = name;
}

-(void)setIconWidth:(int)width{
    _iconWidth = width;
    [self.logoImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(-10);
        make.centerX.equalTo(self.mas_centerX);
        make.width.height.equalTo(@(_iconWidth));
    }];
}
@end
