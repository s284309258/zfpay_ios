//
//  PosSliderView.m
//  XZF
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ApplyScanPaySliderView.h"
static NSInteger iconWidth = 16;
@interface ApplyScanPaySliderView()

@property (nonatomic ,strong) UILabel* lbl;

@property (nonatomic , strong) UIButton* selectBtn;

@property (nonatomic , strong) MXSeparatorLine* line;

@end
@implementation ApplyScanPaySliderView

- (id)init{
    self=[super init];
    
    if (self) {
        [self initUI];
        [self layout];
    }
    
    return self;
}

-(void)initUI{
    [self addSubview:self.lbl];
    [self addSubview:self.selectBtn];
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
}

-(void)layout{
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self.selectBtn.mas_left);
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.right.equalTo(self);
        make.centerY.equalTo(self.lbl);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

-(UILabel*)lbl{
    if (!_lbl) {
        _lbl = [UILabel new];
        _lbl.font = [UIFont font15];
        _lbl.text = @"SN码:M3531313";
    }
    return _lbl;
}

-(UIButton*)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_selectBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
//        [_selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}


-(void)reload:(ScanTraditionalPosModel*)model select:(BOOL)isSelect{
    if (isSelect) {
        [_selectBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
    }else{
        [_selectBtn setImage:nil forState:UIControlStateNormal];
    }
    self.lbl.text = [NSString stringWithFormat:@"SN码: %@",model.sn];
}

-(void)reloadAgent:(RefererAgencyModel*)model select:(BOOL)isSelect{
    if (isSelect) {
        [_selectBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
    }else{
        [_selectBtn setImage:nil forState:UIControlStateNormal];
    }
    self.lbl.text = [NSString stringWithFormat:@"%@(%@)",model.real_name,model.user_tel];
}

-(void)reloadTitle:(NSString*)title select:(BOOL)isSelect{
    if (isSelect) {
        [_selectBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
    }else{
        [_selectBtn setImage:nil forState:UIControlStateNormal];
    }
    self.lbl.text = [NSString stringWithFormat:@"%@",title];
}

@end
