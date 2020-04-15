//
//  MBReleaseButton.m
//  MoPromo_Develop
//
//  Created by yang.xiangbao on 15/5/19.
//  Copyright (c) 2015年 MoPromo. All rights reserved.
//

#import "MBReleaseButton.h"
#import "UIImage+Color.h"

@interface MBReleaseButton ()

@property (nonatomic, strong) UIButton    *releaseBtn;
//@property (nonatomic, strong) UILabel     *titleLbl;
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, assign) CGFloat     logoYOffset;
@property (nonatomic, assign) CGFloat     titleYOffset;

@end

@implementation MBReleaseButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _logoYOffset = 20;
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame logoOffset:(CGFloat)logoYOffset
{
    self = [super initWithFrame:frame];
    if (self) {
        _logoYOffset = logoYOffset;
        _titleYOffset = 15;
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                   logoOffset:(CGFloat)logoYOffset
                 titleYOffset:(CGFloat)titleOffset
{
    self = [super initWithFrame:frame];
    if (self) {
        _logoYOffset = logoYOffset;
        _titleYOffset = titleOffset;
        [self initUI];
    }
    return self;
}

#pragma mark - 布局
- (void)layoutView
{
    UIView *superView = self;
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView.mas_centerY).offset(-_logoYOffset);
        make.centerX.equalTo(superView.mas_centerX);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView.mas_centerX);
        make.centerY.equalTo(superView.mas_centerY).offset(_titleYOffset);
        make.left.equalTo(superView.mas_left).offset(2);
    }];
    
    [self.releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
}

#pragma mark - UI
- (void)initUI
{
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.releaseBtn];
    [self addSubview:self.titleLbl];
    [self addSubview:self.iconImgView];
    [self layoutView];
}

- (void)configureTitle:(NSString*)title icon:(NSString*)iconName
{
    self.titleLbl.text = title;
    [self.iconImgView setImage:[UIImage imageNamed:iconName]];
}

- (void)setEnable:(BOOL)enable
{
    [self.releaseBtn setUserInteractionEnabled:NO];
}

#pragma mark - Event
- (void)releaseAction:(UIButton*)sender
{
    if (self.releaseAction) {
        self.releaseAction(sender);
    }
}

#pragma mark - UI
- (UIButton *)releaseBtn
{
    if (!_releaseBtn) {
        _releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_releaseBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
        [_releaseBtn addTarget:self action:@selector(releaseAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _releaseBtn;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
            [_titleLbl setFont:[UIFont font14]];
       
        
        [_titleLbl setTextColor:[UIColor lightGrayColor]];
        [_titleLbl setTextAlignment:NSTextAlignmentCenter];
        _titleLbl.numberOfLines = 2;
        [_titleLbl setText:@""];
    }
    
    return _titleLbl;
}

- (UIImageView *)iconImgView
{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_iconImgView setImage:[UIImage imageNamed:@"productLaunch"]];
    }
    
    return _iconImgView;
}

@end
