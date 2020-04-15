//
//  PhoneNumView.m
//  AdvertisingMaster
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "PhoneNumView.h"
#import "NumberPadTextField.h"
#import "UIViewController+FormatPhoneNumber.h"
static NSInteger iconWidth = 18;
static NSInteger padding = 10;
@interface PhoneNumView()<UITextFieldDelegate>
{
    //手机格式344定义的变量
    NSString *previousTextFieldContent;
    UITextRange *previousSelection;
}
@property (nonatomic,strong) UIImageView        *img;

@property (nonatomic,strong) NumberPadTextField *tf;

@property (nonatomic,strong) MXSeparatorLine    *line;

@property (nonatomic,strong) LoginRegModel*    model;

@property (nonatomic, strong) UIButton        *btn;

@property (nonatomic, strong) MXSeparatorLine    *horLine;
@end

@implementation PhoneNumView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    
    return self;
}

-(void)initUI{
    [self addSubview:self.img];
    [self addSubview:self.tf];
    [self addSubview:self.btn];
    self.btn.hidden = YES;
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
    self.line.hidden = YES;
    self.horLine = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    self.horLine.backgroundColor = [UIColor moBlueColor];
    [self addSubview:self.horLine];
    self.horLine.hidden = YES;
    [self layout];
}

-(void)layout{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@(1));
    }];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(iconWidth));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.line.mas_left);
    }];
    [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.img.mas_centerY);
        make.left.equalTo(self.img.mas_right).offset(padding);
        make.right.equalTo(self.line.mas_right);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.img.mas_centerY);
        make.width.equalTo(@(80));
        make.height.equalTo(@(22));
        make.right.equalTo(self.line.mas_right);
    }];
    
    [self.horLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btn.mas_left).offset(-0);
        make.centerY.equalTo(self.img.mas_centerY);
        make.height.equalTo(@(10));
        make.width.equalTo(@(0.5));
    }];
}

-(UIImageView*)img{
    if (!_img) {
        _img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"手机"]];
    }
    return _img;
}

-(NumberPadTextField* )tf{
    if (!_tf) {
        _tf = [[NumberPadTextField alloc] init];
        _tf.delegate = self;
        _tf.placeholder =  Lang(@"手机号码");
        [_tf setCustomPlaceholderColor:[UIColor moPlaceHolder]];
//        [_tf setValue:[UIColor moPlaceHolder] forKeyPath:@"_placeholderLabel.textColor"];
        _tf.textColor = [UIColor moBlack];
        _tf.keyboardType = UIKeyboardTypeNumberPad;
        [_tf setFont:[UIFont font15]];
        //3-4-4格式加的事件
        [_tf addTarget:self action:@selector(formatPhoneNumber:) forControlEvents:UIControlEventEditingChanged];
        _tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _tf;
}
-(UIButton*)btn{
    if (!_btn) {
        _btn = [[UIButton alloc]initWithFrame:CGRectZero];
        _btn.backgroundColor = [UIColor clearColor];
//        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_btn setTitle:@"+86中国" forState:UIControlStateNormal];
        [_btn setTitle:@"+86中国" forState:UIControlStateSelected];
        [_btn setTitleColor:[UIColor moBlueColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:13];
        //        _btn.hidden = YES;
    }
    return _btn;
}
- (void)textFiledEditChanged:(NSNotification *)obj {
    UITextField *textField = (UITextField *)obj.object;
    if (textField == self.tf) {
        if (self.getText) {
            self.getText(textField.text);
        }
    }
}
//3-4-4格式手机号输入
- (void)formatPhoneNumber:(UITextField *)textField {
    [self formatPhone:textField previousTextFieldContent:previousTextFieldContent previousSelection:previousSelection];
    if (textField == self.tf) {
        if (self.getText) {
            NSString* text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            self.getText(text);
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    previousTextFieldContent = textField.text;
    previousSelection = textField.selectedTextRange;
    return YES;
}

-(void)formatPhone:(UITextField *)textField previousTextFieldContent:(NSString *)previousTextFieldContent previousSelection:(UITextRange *)previousSelection{
    NSUInteger targetCursorPosition =
    [textField offsetFromPosition:textField.beginningOfDocument
                       toPosition:textField.selectedTextRange.start];
    // nStr表示不带空格的号码
    NSString *nStr = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *preTxt = [previousTextFieldContent stringByReplacingOccurrencesOfString:@" " withString:@""];
    char editFlag = 0;  // 正在执行删除操作时为0，否则为1
    
    if (nStr.length <= preTxt.length) {
        editFlag = 0;
    } else {
        editFlag = 1;
    }
    
    // textField设置text
    if (nStr.length > 11) {
        textField.text = previousTextFieldContent;
        textField.selectedTextRange = previousSelection;
        return;
    }
    
    // 空格
    NSString *spaceStr = @" ";
    
    NSMutableString *mStrTemp = [NSMutableString new];
    int spaceCount = 0;
    if (nStr.length < 3 && nStr.length > -1) {
        spaceCount = 0;
    } else if (nStr.length < 7 && nStr.length > 2) {
        spaceCount = 1;
        
    } else if (nStr.length < 12 && nStr.length > 6) {
        spaceCount = 2;
    }
    
    for (int i = 0; i < spaceCount; i++) {
        if (i == 0) {
            [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(0, 3)], spaceStr];
        } else if (i == 1) {
            [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(3, 4)], spaceStr];
        } else if (i == 2) {
            [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(7, 4)], spaceStr];
        }
    }
    
    if (nStr.length == 11) {
        [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(7, 4)], spaceStr];
    }
    
    if (nStr.length < 4) {
        [mStrTemp appendString:[nStr substringWithRange:NSMakeRange(nStr.length - nStr.length % 3,
                                                                    nStr.length % 3)]];
    } else if (nStr.length > 3) {
        NSString *str = [nStr substringFromIndex:3];
        [mStrTemp appendString:[str substringWithRange:NSMakeRange(str.length - str.length % 4,
                                                                   str.length % 4)]];
        if (nStr.length == 11) {
            [mStrTemp deleteCharactersInRange:NSMakeRange(13, 1)];
        }
    }
    textField.text = mStrTemp;
    // textField设置selectedTextRange
    NSUInteger curTargetCursorPosition = targetCursorPosition;  // 当前光标的偏移位置
    if (editFlag == 0) {
        //删除
        if (targetCursorPosition == 9 || targetCursorPosition == 4) {
            curTargetCursorPosition = targetCursorPosition - 1;
        }
    } else {
        //添加
        if (curTargetCursorPosition == 9 || curTargetCursorPosition == 4) {
            curTargetCursorPosition = targetCursorPosition + 1;
        }
    }
    
    UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument]
                                                              offset:curTargetCursorPosition];
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition
                                                          toPosition:targetPosition]];
}

-(void)reloadPlaceHolder:(NSString *) placeholder image:(NSString *)image{
    if ([StringUtil isEmpty:image]) {
        self.img.hidden = YES;
        [self.tf mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self).offset(padding);
            make.right.equalTo(self.mas_right).offset(-5);;
        }];
    }else{
        self.img.image = [UIImage imageNamed:image];
    }
    _tf.placeholder = placeholder;
}

-(void)showBorder{
    self.layer.borderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 21;
    
}

-(void)showDownLine:(BOOL)isShow{
    self.line.hidden = !isShow;
}

-(void)reloadText:(NSString *)text{
    self.tf.text = text;
}
@end

