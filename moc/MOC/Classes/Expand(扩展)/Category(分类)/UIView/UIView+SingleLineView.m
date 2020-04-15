//
//  UIView+SingleLineView.m
//  HarkLive
//
//  Created by Fly on 15/7/3.
//  Copyright (c) 2015年 kim. All rights reserved.
//

#import "UIView+SingleLineView.h"
#import "Masonry.h"
#import "MXSeparatorLine.h"
#import "UIView+SingleLineView.h"

@implementation UIView (SingleLineView)


- (void)addTopSingleLine:(UIColor*)color height:(float)height{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = color;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(@0);
        make.height.equalTo(@(height));
    }];
}


- (void)addTopSingleLine:(UIColor*)color{
    [self addTopSingleLine:color height:SINGLE_LINE_HEIGHT];
}

- (void)addBottomSingleLine:(UIColor*)color{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = color;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(@0);
        make.height.equalTo(@(SINGLE_LINE_HEIGHT));
    }];
}

- (void)addLeftSingleLine:(UIColor*)color{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = color;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(@0);
        make.width.equalTo(@(SINGLE_LINE_HEIGHT));
    }];
}

- (void)addLeftSingleLineAndOffset:(CGFloat)offset color:(UIColor*)color {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = color;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(offset));
        make.bottom.equalTo(@(-offset));
        make.width.equalTo(@(SINGLE_LINE_HEIGHT));
    }];
}

- (void)addRightSingleLine:(UIColor*)color{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = color;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.bottom.equalTo(@0);
        make.width.equalTo(@(SINGLE_LINE_HEIGHT));
    }];
}

- (void)addRightSingleLineAndLeftOffset:(CGFloat)offset color:(UIColor*)color {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = color;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.top.equalTo(@(offset));
        make.bottom.equalTo(@(-offset));
        make.width.equalTo(@(SINGLE_LINE_HEIGHT));
    }];
}

- (void)addSingleLine:(CGFloat)top withLineColor:(UIColor*)color{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = color;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(top));
        make.left.and.right.equalTo(@0);
        make.height.equalTo(@(SINGLE_LINE_HEIGHT));
    }];
}

- (void)addTopAndBottomLine {
    MXSeparatorLine *topLine = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:topLine];
    
    MXSeparatorLine *bottomLine = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:bottomLine];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(0.5f);
        make.height.equalTo(@0.5f);
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-0.5f);
        make.height.equalTo(@0.5f);
    }];
}

- (void)addTopSingleLineAndLeftOffset:(CGFloat)offset {
    MXSeparatorLine *topLine = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:topLine];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(offset);
        make.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(-0.5f);
        make.height.equalTo(@0.5f);
    }];
}

- (void)addTopSingleLineAndLeftRightOffset:(CGFloat)offset {
    MXSeparatorLine *topLine = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:topLine];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(offset);
        make.right.equalTo(self).offset(-offset);
        make.top.equalTo(self.mas_top).offset(-0.5f);
        make.height.equalTo(@0.5f);
    }];
}

- (void)addTopSingleLineAndLeftOffsetAndColor:(CGFloat)offset color:(UIColor *)color {
    MXSeparatorLine *topLine = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    topLine.backgroundColor = color;
    [self addSubview:topLine];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(offset);
        make.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(-0.5f);
        make.height.equalTo(@0.5f);
    }];
}

- (void)addCellBottomSingleLine:(UIColor*)color {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = color;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.and.bottom.equalTo(@0);
        make.height.equalTo(@(SINGLE_LINE_HEIGHT));
    }];
}

- (UIView *)addCellBottomSingleLine:(UIColor*)color Offset:(CGFloat)offset {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = color;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(offset));
        make.right.and.bottom.equalTo(@0);
        make.height.equalTo(@(SINGLE_LINE_HEIGHT));
    }];
    return lineView;
}

- (void)addBottomSingleLineAndLeftRightOffset:(CGFloat)offset color:(UIColor*)color {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = color;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(offset));
        make.right.equalTo(@(-offset));
        make.bottom.equalTo(@0);
        make.height.equalTo(@(SINGLE_LINE_HEIGHT));
    }];
}
@end
