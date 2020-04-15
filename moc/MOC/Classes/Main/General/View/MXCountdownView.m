//
//  MXCountdownView.m
//  MoPal_Developer
//
//  Created by aken on 15/2/5.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MXCountdownView.h"

@interface MXCountdownView()

@property (nonatomic,strong) UIButton *button;

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) long haveSecondNum; //还剩秒数(可点击发送验证码按钮),<=0表示可以按
@property (nonatomic,assign) long getCodeTime; //获取验证码的时间 time of get the code
@property (nonatomic,assign) long interval; //时间间隔

@end

@implementation MXCountdownView

- (instancetype)initWithFrame:(CGRect)frame timeInterval:(NSInteger)seconds {
    
    self=[super initWithFrame:frame];
    if (self) {
        _interval = seconds;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3;
        [self initUI];
    }
    
    return self;
}

- (void)initUI
{
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:Lang(@"获取验证码") forState:UIControlStateNormal];
    self.button.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.button addTarget:self action:@selector(toClickButotn:) forControlEvents:UIControlEventTouchUpInside];
    self.button.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.button.titleLabel.numberOfLines = 0;
    [self addSubview:self.button];
    [self setNormalTitleColor:_normalTitleColor];
    [self.button setBackgroundColor:_buttonNormalBackColor];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.button.frame = self.bounds;
}

- (void)clear
{
    [self.timer invalidate];
    self.timer=nil;
}

- (void)setCountdownViewTitle:(NSString*)title {
    [self.button setTitle:title forState:UIControlStateNormal];
    [self.button setTitle:title forState:UIControlStateHighlighted];
}

- (void)setNormalTitleColor:(UIColor *)normalTitleColor
{
    _normalTitleColor = normalTitleColor;
    [self.button setTitleColor:normalTitleColor forState:UIControlStateNormal];
}

#pragma mark - 定时器
- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerResetSender) userInfo:nil repeats:YES];
    [self.timer fire];
    if(self.fromClassType){
        [self setCountdownViewState:CountdownViewSendNewIng];
    }else{
        [self setCountdownViewState:CountdownViewSendIng];
    }
    
}

#pragma mark - 定时器循环每一秒调用一次
- (void)timerResetSender
{
    _haveSecondNum--;
    [self resetSmsSenderButton];
    
    if (_haveSecondNum <= 0) {
        [self clear];
        
        if (self.isBlank) {
            if(self.fromClassType){
                [self setCountdownViewState:CountdownViewSendNewAfterGray];
            }else{
                [self setCountdownViewState:CountdownViewSendAfterGray];
            }
            
        } else {
            
            if(self.fromClassType){
                [self setCountdownViewState:CountdownViewSendNewAfter];
            }else{
                [self setCountdownViewState:CountdownViewSendAfter];
            }
            
        }
    }
}

#pragma mark - 不断更新获取验证码按钮的状态
- (void)resetSmsSenderButton
{
    if ([[NSDate date] timeIntervalSince1970] - _getCodeTime >= _interval) {
        _haveSecondNum = 0;
    } else {
        _haveSecondNum = _interval - ([[NSDate date] timeIntervalSince1970] - _getCodeTime);
    }
    
    if (_haveSecondNum > 0) {
        if(self.fromClassType){
            [self setCountdownViewState:CountdownViewSendNewIng];
        }else{
            [self setCountdownViewState:CountdownViewSendIng];
        }
        
    }
}

#pragma mark - 启动定时器
- (void)start
{
    _haveSecondNum = _interval;
    _getCodeTime = [[NSDate date] timeIntervalSince1970];
    [self startTimer];
}

#pragma mark - 可用/禁用
- (void)enableCountdownView:(BOOL)enable
{
    self.button.enabled=enable;
}

#pragma mark - 点击按钮事件
- (void)toClickButotn:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(startToRequest)]) {
        [self.delegate startToRequest];
    }
}

-(void)setCountdownViewState:(CountdownState)state
{
    _countdownViewState = state;
    NSString* title = @"";
    NSString *showText = @"" ;
    switch (state) {//注册登录获取验证码倒计时状态
        case CountdownChangePhoneNumberState:{//更换手机号后重新回到起点
            [self clear];//停止计时器
            title = Lang(@"获取验证码");
            [self.button setUserInteractionEnabled:YES];
            [self.button setTitleColor:_normalTitleColor forState:UIControlStateNormal];
            [self enableCountdownView:YES];
            [self.button setBackgroundColor:[UIColor clearColor]];
            [self.button setAttributedTitle:[[NSMutableAttributedString alloc] initWithString:@""] forState:UIControlStateNormal];
            [self.button setTitle:title forState:UIControlStateNormal];
            [self.button setTitle:title forState:UIControlStateHighlighted];
            break;
        }
            
        case CountdownViewSendBeforeNewWhite:{
            title = Lang(@"获取验证码");
            [self.button setUserInteractionEnabled:NO];
            [self.button setBackgroundColor:[UIColor clearColor]];
            [self.button setTitleColor:_normalTitleColor forState:UIControlStateNormal];
            [self enableCountdownView:NO];
            [self.button setTitle:title forState:UIControlStateNormal];
            [self.button setTitle:title forState:UIControlStateHighlighted];
            
            break;
        }
            
        case CountdownViewSendNewBefore: {
            title =  Lang(@"获取验证码");
            [self.button setUserInteractionEnabled:YES];
            [self.button setTitleColor:_normalTitleColor forState:UIControlStateNormal];
            [self enableCountdownView:YES];
            [self.button setBackgroundColor:[UIColor clearColor]];
            [self.button setTitle:title forState:UIControlStateNormal];
            [self.button setTitle:title forState:UIControlStateHighlighted];
            break;
        }
            
        case CountdownViewSendNewIng: {
            [self enableCountdownView:NO];
            
            NSInteger timeLength = [NSString stringWithFormat:@"%ld",_haveSecondNum].length;
            showText = [NSString stringWithFormat:@"重新获取%lds",_haveSecondNum];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:showText];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor moDarkGray] range:NSMakeRange(0,4)];
            [str addAttribute:NSFontAttributeName value:[UIFont font12] range:NSMakeRange(0,4)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(4,timeLength)];
            [str addAttribute:NSFontAttributeName value:[UIFont font12] range:NSMakeRange(4,timeLength)];
            //title = [NSString stringWithFormat:MXLang(@"LoginRegister_resend_tip_1", @"重新发送%lds"),_haveSecondNum];
            [self.button setUserInteractionEnabled:NO];
            //[self.button setTitleColor:[UIColor moDarkGray] forState:UIControlStateNormal];
            self.button.backgroundColor = [UIColor clearColor];
            [self.button setAttributedTitle:str forState:UIControlStateNormal];
            break;
        }
        case CountdownViewSendNewAfterGray: {
            [self enableCountdownView:YES];
            title = Lang(@"重新获取");
            [self.button setUserInteractionEnabled:YES];
            self.button.backgroundColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.0];
            [self.button setTitle:title forState:UIControlStateNormal];
            [self.button setTitle:title forState:UIControlStateHighlighted];
            break;
        }
        case CountdownViewSendNewAfter: {
            [self enableCountdownView:YES];
            title = Lang(@"重新获取");
            [self.button setUserInteractionEnabled:YES];
            self.button.backgroundColor = [UIColor clearColor];
            [self.button setTitleColor:_normalTitleColor forState:UIControlStateNormal];
            self.verifyView.layer.borderColor = [UIColor whiteColor].CGColor;
            [self.button setAttributedTitle:[[NSMutableAttributedString alloc] initWithString:@""] forState:UIControlStateNormal];
            [self.button setTitle:title forState:UIControlStateNormal];
            [self.button setTitle:title forState:UIControlStateHighlighted];
            break;
        }
            
            
            
            
            //之前用到的获取验证码倒计时状态
            
        case CountdownViewSendBeforeGray: {
            title = Lang(@"获取验证码");
            [self.button setUserInteractionEnabled:NO];
            [self.button setBackgroundColor:self.buttonNormalBackColor];
            [self.button setTitleColor:_normalTitleColor forState:UIControlStateNormal];
            [self enableCountdownView:NO];
            break;
        }
        case CountdownViewSendBeforePurge: {
            title = Lang(@"获取验证码");
            [self.button setUserInteractionEnabled:YES];
            [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.button setBackgroundColor:[UIColor moPurple]];
            [self enableCountdownView:YES];
            break;
        }
        case CountdownViewSendBefore: {
            title =  Lang(@"获取验证码");
            [self.button setUserInteractionEnabled:YES];
            [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self enableCountdownView:YES];
            [self.button setBackgroundColor:[UIColor moPurple]];
            break;
        }
        case CountdownViewSendIng: {
            [self enableCountdownView:NO];
            title = [NSString stringWithFormat:@"%ld s",_haveSecondNum];
            //            [self.button setUserInteractionEnabled:NO];
            //            self.button.backgroundColor = self.buttonNormalBackColor;
            break;
        }
        case CountdownViewSendAfterGray: {
            [self enableCountdownView:YES];
            title = Lang(@"获取验证码");
            [self.button setUserInteractionEnabled:YES];
            [self.button setTitleColor:_normalTitleColor forState:UIControlStateNormal];
            self.button.backgroundColor = [UIColor moPurple];
            break;
        }
        case CountdownViewSendAfter: {
            [self enableCountdownView:YES];
            title =  Lang(@"获取验证码");
            [self.button setUserInteractionEnabled:YES];
            self.button.backgroundColor = self.buttonNormalBackColor;
            [self.button setTitleColor:_normalTitleColor forState:UIControlStateNormal];
            break;
        }
        default: {
            break;
        }
    }
    if(!self.fromClassType){
        [self.button setTitle:title forState:UIControlStateNormal];
        [self.button setTitle:title forState:UIControlStateHighlighted];
    }
    
}

@end
