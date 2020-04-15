//
//  FastTradingItemCell.m
//  Lcwl
//
//  Created by mac on 2018/12/13.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "TradeCell.h"
@interface TradeCell ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation TradeCell

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
    
    [self addSubview:self.btn];
    [self layoutView];
}

-(void)layoutView{
    @weakify(self)
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 1));
    }];
    
    return;
}

- (UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.layer.masksToBounds = YES;
        _btn.layer.borderWidth = 0.5;
        _btn.layer.cornerRadius = 5;
        _btn.titleLabel.font = [UIFont font15];
        _btn.userInteractionEnabled = NO;
    }
    return _btn;
}

-(void)reload:(NSString* )text state:(ButtonType)type{
    [self.btn setTitle:text forState:UIControlStateNormal];
    if (type == NormalButtonType) {
        [self.btn setBackgroundColor:[UIColor whiteColor]];
        [self.btn setTitleColor:[UIColor colorWithHexString:@"#4B4D4C"] forState:UIControlStateNormal];
        self.btn.layer.borderColor = [UIColor moGreen].CGColor;
    }else if(type == UnableButtonType){
        [self.btn setBackgroundColor:[UIColor whiteColor]];
        [self.btn setTitleColor:[UIColor moPlaceHolder] forState:UIControlStateNormal];
        self.btn.layer.borderColor = [UIColor moPlaceHolder].CGColor;
    }else if(type == SelectedButtonType){
        [self.btn setBackgroundColor:[UIColor moGreen]];
        [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btn.layer.borderColor = [UIColor moGreen].CGColor;
    }
}

@end
