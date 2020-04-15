//
//  ChatSettingItemCell.m
//  Lcwl
//
//  Created by mac on 2018/12/1.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "ItemCollectionCell.h"
#import "JSBadgeView.h"
@interface ItemCollectionCell ()

@property (strong , nonatomic) JSBadgeView* badgeView;

@end

@implementation ItemCollectionCell
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
    [self badgeView];
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
    }
    return _logoImgView;
}

- (THLabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [[THLabel alloc] initWithFrame:CGRectZero];
        _nameLbl.textAlignment = NSTextAlignmentCenter;
    }
    
    return _nameLbl;
}

-(JSBadgeView* )badgeView{
    if (!_badgeView ) {
        _badgeView = [[JSBadgeView alloc] initWithParentView:self.logoImgView alignment:JSBadgeViewAlignmentTopRight];
        _badgeView.isCircle = YES;
        _badgeView.hidden = NO;
        _badgeView.badgeText = @" ";
    }
    return _badgeView;
}

-(void)reloadImg:(NSString* )path name:(NSString* )name imageSize:(CGSize )size{
    self.logoImgView.image = [UIImage imageNamed:path];
    if (!CGSizeEqualToSize(size, CGSizeZero)) {
        @weakify(self)
        [self.logoImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY).offset(-10);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@(size.width));
            make.height.equalTo(@(size.height));
        }];
    }
    self.nameLbl.text = name;
}


-(void)reloadData:(ItemModel*)item{
    self.logoImgView.image = [UIImage imageNamed:item.image];
    if (!CGSizeEqualToSize(item.imageSize, CGSizeZero)) {
        @weakify(self)
        [self.logoImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY).offset(-10);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@(item.imageSize.width));
            make.height.equalTo(@(item.imageSize.height));
        }];
    }
    self.nameLbl.textColor = item.textColor;
    self.nameLbl.text = item.text;
    self.nameLbl.strokeColor = item.strokeColor;
    self.nameLbl.strokeSize = item.strokeSize;
    self.nameLbl.font = item.font;
    self.badgeView.hidden = !item.hasPoint;
    
}
@end
