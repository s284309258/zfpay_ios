//
//  RecordHeaderView.m
//  MOC
//
//  Created by mac on 2019/6/20.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "RecordHeaderView.h"
static NSInteger width = 16;
static NSInteger padding = 15;
@interface RecordHeaderView()

@property (nonatomic ,strong) UIImageView* iconImg;

@property (nonatomic ,strong) UIButton* searchBtn;

@end

@implementation RecordHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.iconImg];
    [self addSubview:self.tipBtn];
    [self addSubview:self.searchBtn];
}

-(void)layout{
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.height.equalTo(@(width));
        make.left.equalTo(self.mas_left).offset(padding);
    }];
    [self.tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(padding);
        make.centerY.equalTo(self);
        make.width.equalTo(@(120));
        make.height.equalTo(self.iconImg.mas_height);
    }];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self);
        make.width.equalTo(@(50));
        make.height.equalTo(@(24));
    }];
}

-(UIImageView* )iconImg{
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"筛选"];
    }
    return _iconImg;
}

-(UIButton* )tipBtn{
    if (!_tipBtn) {
        _tipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tipBtn setTitle:Lang(@"请选择筛选日期") forState:UIControlStateNormal];
        [_tipBtn setImage:[UIImage imageNamed:@"多边形 1"] forState:UIControlStateNormal];
        _tipBtn.titleLabel.font = [UIFont font15];
        CGFloat titleWidth = _tipBtn.titleLabel.intrinsicContentSize.width;
        
        _tipBtn.imageEdgeInsets = UIEdgeInsetsMake(0,titleWidth,0,-titleWidth);
        _tipBtn.titleEdgeInsets = UIEdgeInsetsMake(0,-width,0,width);
        
        [_tipBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_tipBtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tipBtn;
}

-(void)select:(id)sender{
    if (self.block) {
        self.block(@"select");
    }
}

-(UIButton* )searchBtn{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_searchBtn setTitle:Lang(@"搜索") forState:UIControlStateNormal];
        _searchBtn.backgroundColor = [UIColor moBlueColor];
        _searchBtn.titleLabel.font = [UIFont font12];
        [_searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn.layer.masksToBounds = YES;
        _searchBtn.layer.cornerRadius = 5;
    }
    return _searchBtn;
}

-(void)search:(id)sender{
    if (self.block) {
        self.block(@"search");
    }
}

@end
