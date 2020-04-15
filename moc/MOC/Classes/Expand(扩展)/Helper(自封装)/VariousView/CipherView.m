//
//  ImageVerifyView.m
//  AdvertisingMaster
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CipherView.h"
static NSInteger iconWidth = 18;
static NSInteger padding = 10;
@interface CipherView()<UITextFieldDelegate>
{
    
}

@property (nonatomic, strong) UIImageView     *img;

@property (nonatomic, strong) UILabel         *lbl;

@property (nonatomic, strong) MXSeparatorLine *line;

@end

@implementation CipherView


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

-(void)initUI{
    [self addSubview:self.lbl];
    [self addSubview:self.img];
    [self addSubview:self.tf];
    [self addSubview:self.btn];
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    //     self.line.hidden = YES;
    [self addSubview:self.line];
    [self layout];
}

-(void)layout{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(1));
    }];
    
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(80));
        make.height.equalTo(@(iconWidth));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self);
    }];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self);
    }];
    [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.lbl.mas_right).offset(padding).priority(900);
        make.left.equalTo(self.img.mas_right).offset(padding).priority(800);
        make.left.equalTo(self).priority(790);
        make.right.equalTo(self.btn.mas_left).offset(-5);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
        make.right.equalTo(self);
    }];
}

-(void)click:(id)sender{
    self.tf.secureTextEntry = !self.tf.secureTextEntry;
    self.btn.selected =  !self.btn.selected ;
    if (self.btnClick) {
        self.btnClick(nil);
    }
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

-(void)reloadImg:(NSString *) image placeHolder:(NSString *)placeHolder{
    self.img.image = [UIImage imageNamed:image];
    self.tf.placeholder = placeHolder;
    [self.lbl removeFromSuperview];
    [self layoutIfNeeded];
}


-(void)reloadPlaceHolder:(NSString *)placeHolder{
    [self.img removeFromSuperview];
    [self.lbl removeFromSuperview];
    self.tf.placeholder = placeHolder;
    [self layoutIfNeeded];
}
-(void)isHiddenLine:(BOOL)isHidden{
    self.line.hidden = isHidden;
}

-(UILabel* )lbl{
    if (!_lbl) {
        _lbl = [[UILabel alloc] init];
        _lbl.textColor = [UIColor blackColor];
        [_lbl setFont:[UIFont font15]];
    }
    return _lbl;
}

-(UIImageView*)img{
    if (!_img) {
        _img = [UIImageView new];
    }
    return _img;
}

-(UIButton*)btn{
    if (!_btn) {
        _btn = [[UIButton alloc]initWithFrame:CGRectZero];
        _btn.backgroundColor = [UIColor clearColor];
//        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_btn setImage:[UIImage imageNamed:@"显示"] forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:@"隐藏"] forState:UIControlStateSelected];
        //        _btn.hidden = YES;
    }
    return _btn;
}


-(UITextField* )tf{
    if (!_tf) {
        _tf = [[UITextField alloc] init];
        _tf.delegate = self;
        _tf.secureTextEntry = YES;
        _tf.placeholder = Lang(@"请输入登录密码");
//        [_tf setValue:[UIColor moPlaceHolder] forKeyPath:@"_placeholderLabel.textColor"];
        [_tf setCustomPlaceholderColor:[UIColor moPlaceHolder]];
        _tf.textColor = [UIColor moBlack];
        _tf.keyboardType = UIKeyboardTypeDefault;
        _tf.returnKeyType = UIReturnKeyNext;
        [_tf setFont:[UIFont systemFontOfSize:14]];
        _tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _tf;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.rowClick) {
        self.rowClick(nil);
    }
}
@end
