//
//  YQInputPayKeyWordView.m
//  Youqun
//
//  Created by 王崇磊 on 16/6/1.
//  Copyright © 2016年 W_C__L. All rights reserved.
//

#import "YQInputPayKeyWordView.h"
#import "WCLPassWordView.h"
static NSInteger padding = 15;
@interface YQInputPayKeyWordView ()

@property (copy, nonatomic) void(^selectBlock)(void);

@end

@implementation YQInputPayKeyWordView

+ (instancetype)initFromNibSelectBlock:(void(^)(void))block{
    YQInputPayKeyWordView *input = [[YQInputPayKeyWordView alloc]init];
    
    input.backgroundColor = [UIColor whiteColor];
    input.passWord = [[WCLPassWordView alloc]init];;
    [input addSubview:input.passWord];
   
    
    input.moneyLbl = ({
        UILabel* label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:36];
        label;
    });
    
    input.tipLbl = ({
        UILabel* label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor moPlaceHolder];
        label;
    });
    
    input.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    
    input.leftLbl = ({
        UILabel* label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor moPlaceHolder];
        label;
    });
    
    input.rightLbl = ({
        UILabel* label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor moBlack];
        label.lineBreakMode = NSLineBreakByTruncatingMiddle;
        label;
    });
    
    [input addSubview:input.moneyLbl];
    [input addSubview:input.tipLbl];
    [input addSubview:input.line];
    [input addSubview:input.leftLbl];
    [input addSubview:input.rightLbl];
    
    
    input.selectBlock = block;
    return input;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.y > 93 && point.y < 144) {
        if (self.selectBlock) {
            self.selectBlock();
        }
    }
}


-(void)layoutNormal{
    self.moneyLbl.hidden = YES;
    self.tipLbl.hidden = YES;
    self.leftLbl.hidden = YES;
    self.rightLbl.hidden = YES;
    self.line.hidden = YES;
    [self.passWord  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-15);
        make.height.equalTo(@(50));
        make.left.right.equalTo(self);
    }];
}

-(void)layoutQuota:(NSDictionary*)dict{
    self.moneyLbl.text = [NSString stringWithFormat:@"￥%@",dict[@"title"]];
    self.tipLbl.text = dict[@"tip"];
    self.leftLbl.text = dict[@"left"];
    self.rightLbl.text = dict[@"right"];
    [self.moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.right.equalTo(self);
        
    }];
    [self.tipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLbl.mas_bottom).offset(5);
        make.left.right.equalTo(self);
        
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipLbl.mas_bottom).offset(40);
        make.height.equalTo(@(1));
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
    }];
    [self.leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom);
        make.height.equalTo(@(50));
        make.left.equalTo(self.line);
    }];
    [self.rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom);
        make.height.equalTo(@(50));
        make.right.equalTo(self.line);
        make.width.equalTo(@(200));
    }];
    
    [self.passWord  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-15);
        make.height.equalTo(@(50));
        make.left.right.equalTo(self);
    }];
    
}
@end
