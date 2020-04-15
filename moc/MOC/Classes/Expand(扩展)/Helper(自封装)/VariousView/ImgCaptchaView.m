//
//  ImgCaptchaView.h
//  AdvertisingMaster
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ImgCaptchaView.h"
#import "UIButton+WebCache.h"
static NSInteger iconWidth = 18;
static NSInteger padding = 10;
@interface ImgCaptchaView()<UITextFieldDelegate>
{
    
}

@property (nonatomic,strong) UILabel *lbl;

@property (nonatomic,strong) UIImageView *img;

@property (nonatomic, strong) UIButton        *btn;

@property (nonatomic, strong) MXSeparatorLine *line;

@end

@implementation ImgCaptchaView


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
    [self addSubview:self.btn];
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
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self);
    }];
    
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(80));
        make.height.equalTo(@(iconWidth));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self);
    }];
    
    
    [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.bottom.top.equalTo(self);
        make.right.equalTo(self.btn.mas_left).offset(-5);;
        make.left.equalTo(self.lbl.mas_right).offset(padding).priority(900);
        make.left.equalTo(self.img.mas_right).offset(padding).priority(800);
        make.left.equalTo(self).offset(padding).priority(760);
    }];
    
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(100));
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.line.mas_right);
    }];
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

- (void)textFiledEditChanged:(NSNotification *)obj {
    UITextField *textField = (UITextField *)obj.object;
    if (textField == self.tf) {
        if (self.getText) {
            self.getText(textField.text);
        }
    }
}

-(UIButton*)btn{
    if (!_btn) {
        _btn = [[UIButton alloc]initWithFrame:CGRectZero];
        _btn.backgroundColor = [UIColor lightGrayColor];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

-(void)click:(id)sender{
    if (self.picBlock) {
        self.picBlock(nil);
    }
}

-(UILabel* )lbl{
    if (!_lbl) {
        _lbl = [[UILabel alloc] init];
        _lbl.textColor = [UIColor blackColor];
        _lbl.text = Lang(@"图形验证码");
        [_lbl setFont:[UIFont font15]];
    }
    return _lbl;
}

-(UIImageView* )img{
    if (!_img) {
        _img = [UIImageView new];
    }
    return _img;
}
-(void)reloadTitle:(NSString *) title placeHolder:(NSString *)placeHolder{
    
    self.lbl.text = title;
    self.tf.placeholder = placeHolder;
    [self.img removeFromSuperview];
    [self layoutIfNeeded];
}


-(void)reloadImg:(NSString *) img placeHolder:(NSString *)placeHolder{
    self.img.image = [UIImage imageNamed:img];
    self.tf.placeholder = placeHolder;
    [self.lbl removeFromSuperview];
    [self layoutIfNeeded];
}

-(void)reloadRightImg:(UIImage *)image{
    [self.btn setBackgroundImage:image forState:UIControlStateNormal];
//    [self.btn setImage:image forState:UIControlStateNormal];
}

-(void)reloadRightImgUrl:(NSString *)image{
    [self.btn sd_setImageWithURL:[NSURL URLWithString:image] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageRefreshCached];
}

-(void)reloadplaceHolder:(NSString *)placeHolder{
     self.tf.placeholder = placeHolder;
    [self.lbl removeFromSuperview];
    [self.img removeFromSuperview];
    [self layoutIfNeeded];
}

-(void)showBorder{
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.cornerRadius = 21;
    self.tf.layer.masksToBounds = YES;
    self.tf.layer.cornerRadius = 21;
    self.tf.layer.borderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5].CGColor;
    self.tf.layer.borderWidth = 0.5;
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
            make.right.equalTo(self.btn.mas_left).offset(-5);
        }];
    }
    
    
    
    
}

-(void)showDownLine:(BOOL)isShow{
    self.line.hidden = !isShow;
}
@end
