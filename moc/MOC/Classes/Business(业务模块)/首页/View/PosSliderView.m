//
//  PosSliderView.m
//  XZF
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "PosSliderView.h"
static NSInteger iconWidth = 16;
@interface PosSliderView()

@property (nonatomic ,strong) UILabel* lbl;

@property (nonatomic , strong) UIButton* selectBtn;


@end
@implementation PosSliderView

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
}

-(void)layout{
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.centerY.equalTo(self);
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.right.equalTo(self);
        make.centerY.equalTo(self.lbl);
    }];
}

-(UILabel*)lbl{
    if (!_lbl) {
        _lbl = [UILabel new];
        _lbl.font = [UIFont font15];
        _lbl.adjustsFontSizeToFitWidth = YES;
        _lbl.numberOfLines = 2;
    }
    return _lbl;
}

-(UIButton*)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
      
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



@end
