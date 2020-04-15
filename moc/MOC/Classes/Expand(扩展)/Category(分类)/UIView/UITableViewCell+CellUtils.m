//
//  UITableViewCell+CellUtils.m
//  WYPatient
//
//  Created by Fly on 2/10/15.
//  Copyright (c) 2015 FLy. All rights reserved.
//

#import "UITableViewCell+CellUtils.h"
#import "MXSeparatorLine.h"

#define TopSeparatorLineTag    2566
#define BottomSeparatorLineTag 2567

@implementation UITableViewCell (CellUtils)

- (CGFloat)getCellAutoLayoutDynamicHeight
{
    [self layoutIfNeeded];
    [self updateConstraintsIfNeeded];
    
    CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    //UITableViewCell的高度要比它的contentView要高1,也就是它的分隔线的高度
    return height + 1;
}

- (void)addBottomHorizontalLine:(CGFloat)leftEdge{
    [self addBottomHorizontalLine:leftEdge withRightEdge:0];
}


- (void)addBottomHorizontalLine:(CGFloat)leftEdge withRightEdge:(CGFloat)rightEdge{
    MXSeparatorLine *line = [self.contentView viewWithTag:BottomSeparatorLineTag];
    if (!line) {
        line = [MXSeparatorLine initHorizontalLineWidth:[UIScreen mainScreen].bounds.size.width orginX:leftEdge orginY:CGRectGetHeight(self.contentView.frame)];
        line.tag = BottomSeparatorLineTag;
        [self.contentView addSubview:line];
        [self.contentView bringSubviewToFront:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(leftEdge));
            make.right.equalTo(@(-rightEdge));
            make.bottom.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
    }else{
        [line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(leftEdge));
        }];
    }
    line.hidden = NO;
}


- (void)addTopHorizontalLine:(CGFloat)leftEdge{
    MXSeparatorLine *line = [self.contentView viewWithTag:TopSeparatorLineTag];
    if (!line) {
        line = [MXSeparatorLine initHorizontalLineWidth:[UIScreen mainScreen].bounds.size.width orginX:leftEdge orginY:0];
        line.backgroundColor = RGB(229, 229, 229);
        line.tag = TopSeparatorLineTag;
        [self.contentView addSubview:line];
        [self.contentView bringSubviewToFront:line];

        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(leftEdge));
            make.right.and.top.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
    }else{
        [line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(leftEdge));
        }];
    }
    line.hidden = NO;
}

- (void)hiddenBottomHorizontalLine{
    MXSeparatorLine *line = [self.contentView viewWithTag:BottomSeparatorLineTag];
    if (line) {
        line.hidden = YES;
    }
}
- (void)hiddenTopHorizontalLine{
    MXSeparatorLine *line = [self.contentView viewWithTag:TopSeparatorLineTag];
    if (line) {
        line.hidden = YES;
    }
}

@end
