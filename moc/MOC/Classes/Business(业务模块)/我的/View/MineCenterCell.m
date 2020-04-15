//
//  ChatSettingItemCell.m
//  Lcwl
//
//  Created by mac on 2018/12/1.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "MineCenterCell.h"
static int width = 35;
@interface MineCenterCell ()

@end

@implementation MineCenterCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

#pragma mark - UI
- (void)initUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.titleLbl];
    [self addSubview:self.nameLbl];
    
    [self layoutView];
}

-(void)layoutView{
    @weakify(self)
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY).offset(-10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.titleLbl.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        
    }];
    return;
}
- (UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLbl.textAlignment = NSTextAlignmentCenter;
        _nameLbl.font = [UIFont font14];
        _nameLbl.textColor = [UIColor moBlack];
    }
    
    return _nameLbl;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
        _titleLbl.textColor = [UIColor colorWithHexString:@"#3C6AE4"];
    }
    
    return _titleLbl;
}

-(void)reloadTitle:(NSString* )title name:(NSString* )name{
//    self.titleLbl.image = [UIImage imageNamed:path];
    self.titleLbl.text = title;
    self.nameLbl.text = name;
}
@end
