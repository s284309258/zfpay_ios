//
//  PosSliderView.m
//  XZF
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ApplyMPosSliderView.h"
static NSInteger iconWidth = 16;
@interface ApplyMPosSliderView()

@property (nonatomic ,strong) UILabel* lbl;

@property (nonatomic ,strong) UILabel* desc;

@property (nonatomic , strong) UIButton* selectBtn;

@property (nonatomic , strong) MXSeparatorLine* line;

@end
@implementation ApplyMPosSliderView

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
    [self addSubview:self.desc];
    [self addSubview:self.selectBtn];
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
}

-(void)layout{
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self).offset(-10);
        make.right.equalTo(self.selectBtn.mas_left);
    }];
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self).offset(10);
        make.right.equalTo(self.selectBtn.mas_left);
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.right.equalTo(self);
        make.centerY.equalTo(self);
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
    }
    return _lbl;
}

-(UILabel*)desc{
    if (!_desc) {
        _desc = [UILabel new];
        _desc.font = [UIFont systemFontOfSize:13];
        _desc.textColor = [UIColor moPlaceHolder];
    }
    return _desc;
}


-(UIButton*)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _selectBtn;
}


-(void)reload:(MPosModel*)model select:(BOOL)isSelect{
    if (isSelect) {
        [_selectBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
    }else{
        [_selectBtn setImage:nil forState:UIControlStateNormal];
    }
    self.lbl.text = [NSString stringWithFormat:@"SN码: %@",model.sn];
    
    self.desc.text = [NSString stringWithFormat:@"%@ %@",( model.name?:@"" ), model.tel?[NSString stringWithFormat:@"(%@)",model.tel]:@""];
}


-(void)reloadSN:(NSString*)sn select:(BOOL)isSelect{
    if (isSelect) {
        [_selectBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
    }else{
        [_selectBtn setImage:nil forState:UIControlStateNormal];
    }
    self.lbl.text = [NSString stringWithFormat:@"SN码: %@",sn];
    [self.lbl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.right.equalTo(self.selectBtn.mas_left);
    }];
    self.desc.hidden = YES;
}

@end
