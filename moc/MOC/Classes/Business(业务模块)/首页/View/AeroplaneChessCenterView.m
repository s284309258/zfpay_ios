//
//  AeroplaneChessCenterView.m
//  MOC
//
//  Created by mac on 2019/6/19.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "AeroplaneChessCenterView.h"
#import "NSMutableAttributedString+Attributes.h"

@interface AeroplaneChessCenterView ()
@property(nonatomic, strong) UIImageView *bgImgView;
@property(nonatomic, strong) UIImageView *arrowUpImgView;
@property(nonatomic, strong) UIImageView *arrowDownImgView;
@property(nonatomic, strong) UIButton *bnt;
@property(nonatomic, strong) UIButton *saleBnt;
@property(nonatomic, strong) UIButton *consumeBnt;
@property(nonatomic, strong) UILabel *contentLbl;
@property(nonatomic, strong) UIImageView *diceImgView;
@end

@implementation AeroplaneChessCenterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgImgView];
        [self.bgImgView addSubview:self.bnt];
        [self addSubview:self.contentLbl];
        [self addSubview:self.chessBnt];
        
        self.contentLbl.attributedText = [self fullContentAtt:@"0" passPort:@"0"];
        [self.bgImgView addSubview:self.diceImgView];
        [self.diceImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.bgImgView.mas_centerY);
            make.width.height.equalTo(@(53));
        }];
        
        [self addSubview:self.arrowUpImgView];
        [self.arrowUpImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(0));
            make.bottom.equalTo(self.contentLbl.mas_top).offset(20);
            make.width.equalTo(@(14));
            make.height.equalTo(@(82));
        }];
        
        [self addSubview:self.arrowDownImgView];
        [self.arrowDownImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(0));
            make.bottom.equalTo(self.contentLbl.mas_top).offset(20);
            make.width.equalTo(@(14));
            make.height.equalTo(@(82));
        }];
        
        [self layout];
    }
    return self;
}

- (void)layout {
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.centerX.equalTo(self);
    }];
    
    [self.bnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImgView.mas_centerY).offset(10);
        make.centerX.equalTo(self);
        make.width.equalTo(@(129));
        make.height.equalTo(@(51));
    }];
    
    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImgView.mas_bottom).offset(15);
        make.centerX.equalTo(self);
    }];
    
    [self.chessBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLbl.mas_bottom).offset(15);
        make.centerX.equalTo(self);
        make.width.equalTo(@(128));
        make.height.equalTo(@(46));
    }];
}

- (NSMutableAttributedString *)fullContentAtt:(NSString *)saleCount passPort:(NSString *)passPort {
    NSMutableAttributedString *titleAtt = [self contentAtt:Lang(@"已消耗") tail:Lang(@"个可售额度") count:saleCount color:[UIColor colorWithHexString:@"#ffff66"]];
    NSMutableAttributedString *subAtt = [self contentAtt:Lang(@"已获取") tail:Lang(@"个超级通证") count:passPort color:[UIColor colorWithHexString:@"#8FED90"]];
    NSMutableAttributedString *fullAtt = [[NSMutableAttributedString alloc] initWithAttributedString:titleAtt];
    [fullAtt appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];
    [fullAtt appendAttributedString:subAtt];
    [fullAtt setLineSpacing:10 substring:titleAtt.string alignment:NSTextAlignmentCenter];
    return fullAtt;
}

- (NSMutableAttributedString *)contentAtt:(NSString *)head tail:(NSString *)tail count:(NSString *)count color:(UIColor *)color {
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",head,count,tail]];
    [attString addFont:[UIFont systemFontOfSize:14] substring:attString.string];
    [attString addColor:[UIColor whiteColor] substring:attString.string];
    [attString addColor:[UIColor whiteColor] substring:attString.string];
    [attString addColor:color substring:count];
    return attString;
}

- (void)multiClick {
    Block_Exec(self.multiBlock,nil);
    //[self startAnimationView];
}

- (void)throwDiceClick:(UIButton *)sender {
    Block_Exec(self.throwDiceblock,nil);
}

- (void)reloadUI:(NSString *)multi saleCount:(NSString *)saleCount {
    if(multi == nil || saleCount == nil) {
        return;
    }
    
    self.contentLbl.attributedText = [self fullContentAtt:multi passPort:saleCount];
}

- (void)reloadMultiLabel:(NSString *)multi {
    UILabel *label = [self.bnt viewWithTag:100001];
    label.text = [NSString stringWithFormat:@"x%@",multi];
}

- (UIImageView *)bgImgView {
    if(!_bgImgView) {
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.image = [UIImage imageNamed:@"盘底"];
        _bgImgView.userInteractionEnabled = YES;
    }
    return _bgImgView;
}

- (UILabel *)contentLbl {
    if(!_contentLbl) {
        _contentLbl = [[UILabel alloc] init];
        _contentLbl.textAlignment = NSTextAlignmentCenter;
        _contentLbl.numberOfLines = 2;
    }
    return _contentLbl;
}

- (UIButton *)bnt {
    if(!_bnt) {
        _bnt = [[UIButton alloc] init];
        [_bnt setBackgroundImage:[UIImage imageNamed:@"加倍"] forState:UIControlStateNormal];
        [_bnt addTarget:self action:@selector(multiClick) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = Lang(@"加倍");
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [_bnt addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(-10));
            make.left.equalTo(@(0));
            make.width.equalTo(@(45));
        }];
        
        UILabel *value = [[UILabel alloc] init];
        value.text = @"x1";
        value.font = [UIFont systemFontOfSize:14];
        value.textColor = [UIColor colorWithHexString:@"#FBE370"];
        value.tag = 100001;
        [_bnt addSubview:value];
        [value mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(-10));
            make.left.equalTo(label.mas_right).offset(4);
            make.right.equalTo(@(0));
            //make.width.equalTo(@(50));
        }];
        
        UIImageView *arrow = [[UIImageView alloc] init];
        arrow.image = [UIImage imageNamed:@"飞行棋按钮向下箭头"];
        [_bnt addSubview:arrow];
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.centerY.equalTo(value.mas_centerY);
        }];
        
    }
    return _bnt;
}

- (void)startAnimationView:(NSNumber *)jump {
    [self.diceImgView startAnimating];
    //自动移除动画图层，延迟2秒执行
    [self performSelector:@selector(showResult:) withObject:jump afterDelay:2.0f];
}

- (void)showResult:(NSNumber *)jump {
    [self.diceImgView stopAnimating];
    NSLog(@"==== %lu",(unsigned long)jump);
    self.diceImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",(unsigned long)[jump integerValue]]];
}

- (ChessBnt *)chessBnt {
    if(!_chessBnt) {
        _chessBnt = [[ChessBnt alloc] init];
        _chessBnt.titleLbl.text = Lang(@"可售额度");
        _chessBnt.subTitle.text = @"8";
        [_chessBnt addTarget:self action:@selector(throwDiceClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chessBnt;
}

- (UIImageView *)diceImgView {
    if(!_diceImgView) {
        _diceImgView = [[UIImageView alloc] init];
        _diceImgView.image = [UIImage imageNamed:@"1"];
        _diceImgView.contentMode = UIViewContentModeScaleAspectFit;
        
        //创建一个数组，数组中按顺序添加要播放的图片（图片为静态的图片）
        NSMutableArray *imageArr = [NSMutableArray array];
        for (int i = 1; i <= 9; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
            [imageArr addObject:image];
        }
        //把存有UIImage的数组赋给动画图片数组
        _diceImgView.animationImages = imageArr;
        //设置执行一次完整动画的时长
        _diceImgView.animationDuration = 0.3;
        //动画重复次数 （0为重复播放）
        _diceImgView.animationRepeatCount = 0;
        //开始播放动画
        //[_diceImgView startAnimating];
    }
    return _diceImgView;
}

- (UIImageView *)arrowUpImgView {
    if(!_arrowUpImgView) {
        _arrowUpImgView = [[UIImageView alloc] init];
        _arrowUpImgView.image = [UIImage imageNamed:@"向上"];
    }
    return _arrowUpImgView;
}

- (UIImageView *)arrowDownImgView {
    if(!_arrowDownImgView) {
        _arrowDownImgView = [[UIImageView alloc] init];
        _arrowDownImgView.image = [UIImage imageNamed:@"向下"];
    }
    return _arrowDownImgView;
}
@end
