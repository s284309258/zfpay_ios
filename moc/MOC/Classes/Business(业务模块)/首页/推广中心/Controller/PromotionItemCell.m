//
//  PromotionItemCell.m
//  XZF
//
//  Created by mac on 2020/3/14.
//  Copyright © 2020 AlphaGo. All rights reserved.
//

#import "PromotionItemCell.h"
@interface PromotionItemCell()

@property (nonatomic,strong) UIImageView* logoImgView;

@end

@implementation PromotionItemCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI
- (void)setupUI
{
    [self addSubview:self.logoImgView];
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@(0));
    }];
}

-(void)layoutView{
    
}

- (UIImageView *)logoImgView
{
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
    }
    return _logoImgView;
}


-(void)reloadImg:(NSString*)url{
    if ([StringUtil isEmpty:url]) {
        return;
    }
    [_logoImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
}
@end
