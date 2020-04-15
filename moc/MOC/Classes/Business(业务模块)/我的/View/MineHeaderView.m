//
//  MineHeaderView.m
//  MOC
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "MineHeaderView.h"
#import "ZYLineProgressView.h"
#import "MineHeaderCenterView.h"
#import "UIView+AZGradient.h"

static NSInteger padding = 15;

@interface MineHeaderView ()

@property (strong, nonatomic) UIImageView *backImgView;

@property (strong, nonatomic) UILabel *levelNameLbl;

@property (strong, nonatomic) ZYLineProgressView *progressView;

@property (strong, nonatomic) UILabel *progressLbl;

@property (strong, nonatomic) UILabel *levelLbl;

@property (strong, nonatomic) UILabel *credibleTitleLbl;

@property (strong, nonatomic) UILabel *credibleValueLbl;

@property (strong, nonatomic) UIImageView *logoImgView;

@property (strong, nonatomic) UILabel *logoTitleLbl;

@property (strong, nonatomic) MineHeaderCenterView *header;


@end

@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

- (void)initUI {
    self.backImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.backImgView.backgroundColor = [UIColor colorWithHexString:@"#0E1066"];
    self.backImgView.alpha = 0.4;

    [self addSubview:self.backImgView];
    [self addSubview:self.levelNameLbl];
    [self addSubview:self.progressView];
    [self addSubview:self.progressLbl];
    [self addSubview:self.levelLbl];
    [self addSubview:self.credibleTitleLbl];
    [self addSubview:self.credibleValueLbl];
    [self addSubview:self.logoImgView];
    [self addSubview:self.logoTitleLbl];
    
    [self addSubview:self.header];
    
    
}

-(void)layout{
    [self.backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.levelNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(padding);
        make.width.equalTo(@(30));
        make.height.equalTo(@(16));
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.levelNameLbl.mas_right).offset(5);
        make.top.equalTo(self.levelNameLbl.mas_top);
        make.width.equalTo(@(60));
        make.height.equalTo(@(5));
    }];
    
    [self.progressLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.progressView.mas_left);
        make.top.equalTo(self.progressView.mas_bottom).offset(4);
        make.width.equalTo(@(40));
        make.height.equalTo(@(8));
    }];
    
    [self.levelLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.progressView.mas_right);
        make.top.equalTo(self.progressLbl);
        make.height.equalTo(@(8));
        make.width.equalTo(@(20));
    }];
    
    [self.credibleValueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(16));
        make.right.equalTo(self.mas_right).offset(-padding);
        make.top.equalTo(self.mas_top).offset(padding);
    }];
    
    [self.credibleTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.credibleValueLbl.mas_left).offset(-5);
        make.centerY.equalTo(self.levelNameLbl.mas_centerY);
        make.height.equalTo(@(16));
         make.width.equalTo(@(40));
    }];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(80));
//        make.top.equalTo(self.progressView.mas_bottom);
        make.centerY.equalTo(self).offset(-40);
        make.centerX.equalTo(self);
    }];
    
    [self.logoTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImgView.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        
    }];
    
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(56));
        make.bottom.equalTo(self.backImgView.mas_bottom);
        make.width.equalTo(self);
    }];
    
    
}

- (UILabel *)levelNameLbl {
    if(!_levelNameLbl) {
        _levelNameLbl = [[UILabel alloc] init];
        _levelNameLbl.text = @"会员";
        _levelNameLbl.layer.masksToBounds = YES;
        _levelNameLbl.layer.cornerRadius = 8;
        _levelNameLbl.font = [UIFont systemFontOfSize:10];
        _levelNameLbl.textAlignment = NSTextAlignmentCenter;
        _levelNameLbl.adjustsFontSizeToFitWidth = YES;
        _levelNameLbl.backgroundColor = [UIColor whiteColor];
        _levelNameLbl.textColor = [UIColor colorWithHexString:@"#5C52C1"];
    }
    return _levelNameLbl;
}

- (UILabel *)progressLbl {
    if(!_progressLbl) {
        _progressLbl = [[UILabel alloc] init];
        _progressLbl.text = @"20%";
        _progressLbl.font = [UIFont systemFontOfSize:9];
//        _progressLbl.textAlignment = NSTextAlignmentCenter;
        _progressLbl.adjustsFontSizeToFitWidth = YES;
        _progressLbl.backgroundColor = [UIColor clearColor];
        _progressLbl.textColor = [UIColor whiteColor];
    }
    return _progressLbl;
}

- (UILabel *)levelLbl {
    if(!_levelLbl) {
        _levelLbl = [[UILabel alloc] init];
        _levelLbl.text = @"V1";
        _levelLbl.font = [UIFont  systemFontOfSize:9];
        _levelLbl.textAlignment = NSTextAlignmentCenter;
        _levelLbl.adjustsFontSizeToFitWidth = YES;
        _levelLbl.textColor = [UIColor whiteColor];
        _levelLbl.backgroundColor = [UIColor colorWithHexString:@"#55C2F9"];
    }
    return _levelLbl;
}

- (UILabel *)credibleTitleLbl {
    if(!_credibleTitleLbl) {
        _credibleTitleLbl = [[UILabel alloc] init];
        _credibleTitleLbl.text = @"诚信值";
        _credibleTitleLbl.layer.masksToBounds = YES;
        _credibleTitleLbl.layer.cornerRadius = 8;
        _credibleTitleLbl.font = [UIFont  systemFontOfSize:10];
        _credibleTitleLbl.textAlignment = NSTextAlignmentCenter;
        _credibleTitleLbl.adjustsFontSizeToFitWidth = YES;
        _credibleTitleLbl.backgroundColor = [UIColor whiteColor];
        _credibleTitleLbl.textColor = [UIColor colorWithHexString:@"#5C52C1"];
    }
    return _credibleTitleLbl;
}

- (UILabel *)credibleValueLbl {
    if(!_credibleValueLbl) {
        _credibleValueLbl = [[UILabel alloc] init];
        _credibleValueLbl.text = @"良";
        _credibleValueLbl.font = [UIFont  fontWithName:@"PingFangSC-Regular" size:10];
        _credibleValueLbl.textAlignment = NSTextAlignmentCenter;
        _credibleValueLbl.adjustsFontSizeToFitWidth = YES;
        _credibleValueLbl.textColor = [UIColor whiteColor];
        _credibleValueLbl.backgroundColor = [UIColor colorWithHexString:@"#FD934D"];
    }
    return _credibleValueLbl;
}

-(UIImageView* )logoImgView{
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _logoImgView.image = [UIImage imageNamed:@"logo"];
        _logoImgView.layer.borderWidth = 2;
        _logoImgView.layer.borderColor = [UIColor whiteColor].CGColor;
        _logoImgView.layer.cornerRadius = 40;
    }
    return _logoImgView;
}

- (UILabel *)logoTitleLbl {
    if(!_logoTitleLbl) {
        _logoTitleLbl = [[UILabel alloc] init];
        _logoTitleLbl.text = @"000";
        _logoTitleLbl.font = [UIFont systemFontOfSize:16];
        _logoTitleLbl.textAlignment = NSTextAlignmentCenter;
        _logoTitleLbl.adjustsFontSizeToFitWidth = YES;
        _logoTitleLbl.textColor = [UIColor whiteColor];
        _logoTitleLbl.backgroundColor = [UIColor clearColor];
    }
    return _logoTitleLbl;
}

- (MineHeaderCenterView *)header {
    if(!_header) {
        _header = [[MineHeaderCenterView alloc] initWithFrame:CGRectZero];
        _header.block = ^(id data) {
            NSInteger position = [data integerValue];
            if (position == 0) {
                [MXRouter openURL:@"lcwl://InOutRecordVC" parameters:@{@"title":Lang(@"红贝收支记录"),@"keyword":@"flow"}];
            }else if(position == 1){
                 [MXRouter openURL:@"lcwl://InOutRecordVC" parameters:@{@"title":Lang(@"魔贝收支记录"),@"keyword":@"lock"}];
            }
        };
    }
    return _header;
}

-(ZYLineProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[ZYLineProgressView alloc]initWithFrame:CGRectMake(0, 0, 60, 6)];
        [_progressView updateConfig:^(ZYLineProgressViewConfig *config) {
//            config.isShowDot = YES;
        }];
        _progressView.layer.borderColor = [UIColor whiteColor].CGColor;
        _progressView.layer.masksToBounds = YES;
        _progressView.layer.cornerRadius = 3;
        _progressView.layer.borderWidth = 0.5;
        [_progressView setProgress:0.5];
    }
    return _progressView;
}

- (void)reloadModel:(UserModel* )model{
//    self.logoTitleLbl.text = [NSString stringWithFormat:@"%@(%@)",model.username,model.userId];
//    [self.header reloadTitleLbl1:model.flowNum titleLbl2:model.lockNum value1:Lang(@"红贝数量") value2: Lang(@"魔贝数量")];
//    [self.progressView setProgress:model.integralSchedule/100.0];
//    self.progressLbl.text =  [NSString stringWithFormat:@"%@%%",[StringUtil integerToString:model.integralSchedule]];
//    self.levelLbl.text = [NSString stringWithFormat:@"v%ld",model.level];
//    NSString* creditStr = @"";
//    if (model.credit < 1.5) {
//        creditStr = @"差";
//    }else if (model.credit >=1.5 && model.credit < 1.7) {
//        creditStr = @"良";
//    }else if (model.credit >=1.7 ) {
//         creditStr = @"优";
//        self.credibleValueLbl.backgroundColor = [UIColor colorWithHexString:@"#00BF00"];
//    }
//    self.credibleValueLbl.text = creditStr;
}

@end
