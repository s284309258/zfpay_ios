//
//  VerityCodeView.m
//  AdvertisingMaster
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "TextCaptchaView.h"
#import "MXCountdownView.h"
#import "LoginRegModel.h"
static NSInteger  interval =  60 ;// 发送短信间隔时间:秒
static NSInteger iconWidth = 18;
static NSInteger padding = 10;
@interface TextCaptchaView()<UITextFieldDelegate,MXCountdownViewDelegate>
{
    
}

@property (nonatomic, strong) UILabel         *lbl;

@property (nonatomic, strong) UIImageView     *img;

@property (nonatomic, strong) MXCountdownView *countDowView;

@property (nonatomic, strong) MXSeparatorLine *line;

@property (nonatomic, strong) MXSeparatorLine *horLine;

@property (nonatomic, strong) LoginRegModel   *model;

@end

@implementation TextCaptchaView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:self.tf];
    }
    
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initUI{
    self.line = ({
        MXSeparatorLine* tmp = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
         tmp.hidden = YES;
        tmp;
    });
    
    self.horLine = ({
        MXSeparatorLine* tmp = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
        tmp.hidden = YES;
        tmp;
    });
    
    [self addSubview:self.lbl];
    [self addSubview:self.img];
    [self addSubview:self.tf];
    [self addSubview:self.countDowView];
    [self addSubview:self.line];
    [self addSubview:self.horLine];
    [self layout];
}

-(void)layout{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(-0);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@(1));
    }];
    
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(80));
        make.height.equalTo(@(iconWidth));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left);
    }];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left);
    }];
    
    [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.lbl.mas_right).offset(padding).priority(900);
        make.left.equalTo(self.img.mas_right).offset(padding).priority(850);
        make.left.equalTo(self).offset(padding).priority(800);
        make.right.equalTo(self.countDowView.mas_left).offset(-5);;
    }];
    
    [self.countDowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
//        make.top.bottom.equalTo(self);
        make.width.equalTo(@(100));
        make.height.equalTo(@(26));
        make.right.equalTo(self.mas_right);
    }];
    
    [self.horLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.countDowView.mas_left).offset(-0);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@(10));
        make.width.equalTo(@(1));
    }];
}

- (void)textFiledEditChanged:(NSNotification *)obj {
    UITextField *textField = (UITextField *)obj.object;
    if (textField == self.tf) {
        if (self.getText) {
            self.getText(textField.text);
        }
    }
}

- (void)startToRequest {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (self.sendCodeBlock) {
        self.sendCodeBlock(nil);
    }
}

-(void)isHiddenLine:(BOOL)isHidden{
    self.line.hidden = isHidden;
}

-(UILabel* )lbl{
    if (!_lbl) {
        _lbl = [[UILabel alloc] init];
        _lbl.textColor = [UIColor moBlack];
        _lbl.text = Lang(@"短信验证码");
        [_lbl setFont:[UIFont font15]];
    }
    return _lbl;
}

-(UIImageView*)img{
    if (!_img) {
        _img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"验证码"]];
    }
    return _img;
}

-(MXCountdownView *)countDowView{
    if (!_countDowView) {
        _countDowView = [[MXCountdownView alloc] initWithFrame:CGRectZero timeInterval:interval];
        _countDowView.delegate = self;
        _countDowView.normalTitleColor = [UIColor moGreen];
        _countDowView.buttonNormalBackColor = [UIColor clearColor];
    }
    return _countDowView;
}

-(UITextField* )tf{
    if (!_tf) {
        _tf = [[UITextField alloc] init];
        _tf.delegate = self;
        _tf.placeholder = Lang(@"请输入验证码");
//        [_tf setValue:[UIColor moPlaceHolder] forKeyPath:@"_placeholderLabel.textColor"];
        [_tf setCustomPlaceholderColor:[UIColor moPlaceHolder]];
        _tf.textColor = [UIColor moBlack];
        _tf.keyboardType = UIKeyboardTypeDefault;
        _tf.returnKeyType = UIReturnKeyNext;
        [_tf setFont:[UIFont systemFontOfSize:15]];
        _tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _tf;
}

-(void)startCountDowView{
    [self.countDowView start];
}

-(void)reloadTitle:(NSString *) title placeHolder:(NSString *)placeHolder{
    self.lbl.text = title;
    self.tf.placeholder = placeHolder;
    [self.img removeFromSuperview];
    [self layoutIfNeeded];
}

-(void)reloadImg:(NSString *) image  placeHolder:(NSString *)placeHolder{
    self.img.image = [UIImage imageNamed:image];
    self.tf.placeholder = placeHolder;
    [self.lbl removeFromSuperview];
    [self layoutIfNeeded];
}

-(void)reloadplaceHolder:(NSString *)placeHolder{
     self.tf.placeholder = placeHolder;
    [self.lbl removeFromSuperview];
     [self.img removeFromSuperview];
    [self layoutIfNeeded];
}

-(void)showBorder{
    self.countDowView.layer.masksToBounds = YES;
    self.countDowView.layer.cornerRadius = 13;
    self.countDowView.backgroundColor = [UIColor whiteColor];
    self.countDowView.layer.borderColor = [UIColor moGreen].CGColor;
    self.countDowView.layer.borderWidth = 1;
}



-(void)setLeftPadding:(NSInteger)leftPadding{
    if (self.img.superview) {
        [self.img mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(iconWidth));
            make.left.equalTo(self).offset(leftPadding);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }else if(self.lbl.superview){
        [self.lbl mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(iconWidth));
            make.width.equalTo(@(80));
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self).offset(leftPadding);
        }];
    }else{
        self.tf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftPadding, 0)];
        //设置显示模式为永远显示(默认不显示)
        self.tf.leftViewMode = UITextFieldViewModeAlways;
        
        
        [self.tf mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(self);
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self);
            make.right.equalTo(self.countDowView.mas_left).offset(-5);
        }];
    }  
}

-(void)showDownLine:(BOOL)isShow{
    self.line.hidden = !isShow;
}
@end
