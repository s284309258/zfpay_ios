//
//  DatePickerToolView.m
//  MoPal_Developer
//
//  Created by lhy on 15/11/10.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import "DatePickerToolView.h"
#import "AmplifyRespondButton.h"

#define kDatePickerTopBar 44

@implementation DatePickerToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    // cancel
    AmplifyRespondButton *cancelBtn=[AmplifyRespondButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateHighlighted];
    cancelBtn.tag=1;
    [cancelBtn setTitleColor:[UIColor moOrange] forState:UIControlStateNormal];
    [self addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(40);
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(10);
    }];
    
    // ok
    AmplifyRespondButton *okBtn=[AmplifyRespondButton buttonWithType:UIButtonTypeCustom];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitle:@"确定" forState:UIControlStateHighlighted];
    okBtn.tag=2;
    okBtn.frame=CGRectMake(SCREEN_WIDTH - 100, kDatePickerTopBar/2 - 20, 100, 40);
    [okBtn setTitleColor:[UIColor moOrange] forState:UIControlStateNormal];
    [self addSubview:okBtn];
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(40);
        make.top.equalTo(self.mas_top).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    [okBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - ========用户点击==========
- (void)btnClick:(UIView *)sender
{
    //1:取消 2:确定
    if (sender.tag == 1) {
        if (_cancelBlock) {
            _cancelBlock();
        }
    }else if (sender.tag == 2){
        if (_okBlock) {
            _okBlock();
        }
    }
}

@end
