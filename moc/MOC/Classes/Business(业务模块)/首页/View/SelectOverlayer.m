//
//  SelectOverlayer.m
//  XZF
//
//  Created by mac on 2020/3/7.
//  Copyright © 2020 AlphaGo. All rights reserved.
//

#import "SelectOverlayer.h"
#import "SPButton.h"
static NSInteger padding = 15;
@interface SelectOverlayer()

@property (nonatomic , strong) UIView* centerView;

@property (nonatomic , strong) UILabel* titleLbl;

@property (nonatomic , strong) SPButton* ctposBtn;

@property (nonatomic , strong) SPButton* eposBtn;

@property (nonatomic , strong) CompletionBlock select;

@end
@implementation SelectOverlayer

-(instancetype)init{
    if (self = [super init]) {
        UIView* backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.5;
        [self addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self addSubview:self.centerView];
        [self.centerView addSubview:self.titleLbl];
        [self.centerView addSubview:self.ctposBtn];
        [self.centerView addSubview:self.eposBtn];
        [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(280));
            make.height.equalTo(@(180));
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(padding));
            make.left.right.equalTo(self.centerView);
            make.height.equalTo(@(44));
        }];
        [self.ctposBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLbl.mas_bottom);
            make.bottom.equalTo(@(-padding));
            make.centerX.equalTo(self.centerView).multipliedBy(.5);
        }];
        [self.eposBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLbl.mas_bottom);
            make.bottom.equalTo(@(-padding));
            make.centerX.equalTo(self.centerView).multipliedBy(1.5);
        }];
      
    }
    return self;
}

- (UIView *)centerView
{
    if (_centerView == nil) {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.layer.cornerRadius = 5;
    }
    return _centerView;
}

- (UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.textColor = [UIColor moBlack];
        _titleLbl.text = @"请选择类型";
    }
    return _titleLbl;
}

- (UIButton *)ctposBtn{
    if (!_ctposBtn) {
        _ctposBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _ctposBtn.frame = CGRectMake(0, 0,  SCREEN_WIDTH/2, 0);
        _ctposBtn.titleLabel.font = [UIFont font14];
        [_ctposBtn setImage:[UIImage imageNamed:@"传统POS_rate"] forState:UIControlStateNormal];
        [_ctposBtn setTitleColor:[UIColor moBlack] forState:UIControlStateNormal];
        [_ctposBtn setTitle:@"传统机" forState:UIControlStateNormal];
        _ctposBtn.imageTitleSpace = 15;
        [_ctposBtn addTarget:self action:@selector(ctposClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ctposBtn;
}

-(void)ctposClick:(id)sender{
    [self removeFromSuperview];
    !_select?:_select(@"lcwl://ApplyCTPosVC");
}

- (UIButton *)eposBtn{
    if (!_eposBtn) {
        _eposBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _eposBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 0);
        _eposBtn.titleLabel.font = [UIFont font14];
        [_eposBtn setImage:[UIImage imageNamed:@"EPOS_rate"] forState:UIControlStateNormal];
        [_eposBtn setTitleColor:[UIColor moBlack] forState:UIControlStateNormal];
        [_eposBtn setTitle:@"电签机" forState:UIControlStateNormal];
        _eposBtn.imageTitleSpace = 15;
        [_eposBtn addTarget:self action:@selector(eposClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eposBtn;
}

-(void)eposClick:(id)sender{
    [self removeFromSuperview];
    !_select?:_select(@"lcwl://ApplyEPosVC");
}

+(void)showOverLayer:(CompletionBlock)posBlock{
    SelectOverlayer *view = [SelectOverlayer new];
    view.select = posBlock;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

@end
