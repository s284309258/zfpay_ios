//
//  ImgCaptchaView.h
//  AdvertisingMaster
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "InvitationCodeView.h"

static NSString  * const MONEYNUMBERS = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.@";
static NSInteger iconWidth = 18;
static NSInteger padding = 0;
@interface InvitationCodeView()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel         *lbl;

@property (nonatomic, strong) UIImageView     *img;

@property (nonatomic, strong) MXSeparatorLine *line;

@end

@implementation InvitationCodeView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    if (self) {
        self.tag = 998877;
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
    [self addSubview:self.img];
    [self addSubview:self.lbl];
    [self addSubview:self.tf];
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    self.line.hidden = YES;
    [self addSubview:self.line];
    [self layout];
}

-(void)layout{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(1));
    }];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(iconWidth));
        make.width.equalTo(@(80));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(padding);
    }];
    
    [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.lbl.mas_right).offset(10).priority(900);
        make.left.equalTo(self.img.mas_right).offset(10).priority(800);
        make.left.equalTo(self).offset(padding).priority(760);
        make.right.equalTo(self.line.mas_right);
    }];
}

-(UIImageView*)img{
    if (!_img) {
        _img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"邀请"]];
    }
    return _img;
}

-(UILabel*)lbl{
    if (!_lbl) {
        _lbl = [UILabel new];
        _lbl.textColor = [UIColor moBlack];
        [_lbl setFont:[UIFont font15]];
        [_lbl setAdjustsFontSizeToFitWidth:YES];
    }
    return _lbl;
}

-(UITextField* )tf{
    if (!_tf) {
        _tf = [[UITextField alloc] init];
        _tf.delegate = self;
        _tf.placeholder = Lang(@"请输入邀请码");
//        [_tf setValue:[UIColor moPlaceHolder]  forKeyPath:@"_placeholderLabel.textColor"];
        [_tf setCustomPlaceholderColor:[UIColor moPlaceHolder]];
        _tf.textColor = [UIColor moBlack];
        _tf.keyboardType = UIKeyboardTypeDefault;
        _tf.returnKeyType = UIReturnKeyNext;
        [_tf setFont:[UIFont font15]];
        _tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _tf;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
    if (![string isEqualToString:@" "] && [StringUtil isEmpty:string]) {
        return YES;
    }
    if (self.regex) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regex];
        BOOL isMatch = [pred evaluateWithObject:string];
        return  isMatch;
    }
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:MONEYNUMBERS] invertedSet];
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(basicTest) {
        return YES;
    }
    return NO;
}
- (void)textFiledEditChanged:(NSNotification *)obj {
    UITextField *textField = (UITextField *)obj.object;
    if (textField == self.tf) {
        if (self.getText) {
            self.getText(textField.text);
        }
    }
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

-(void)reloadPlaceHoder:(NSString *)placeHolder{
    self.tf.placeholder = placeHolder;
    [self.img removeFromSuperview];
    [self.lbl removeFromSuperview];
    [self layoutIfNeeded];
}

-(void)isHiddenLine:(BOOL)isHidden{
    self.line.hidden = isHidden;
}
-(void)showBorder{
    self.layer.borderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 21;
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
        [self.tf mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self).offset(leftPadding);
            make.right.equalTo(self.line.mas_right);
        }];
    }
}

-(void)showDownLine:(BOOL)isShow{
    self.line.hidden = !isShow;
}
@end
