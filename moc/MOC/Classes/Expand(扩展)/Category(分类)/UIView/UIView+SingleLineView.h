//
//  UIView+SingleLineView.h
//  HarkLive
//
//  Created by Fly on 15/7/3.
//  Copyright (c) 2015年 kim. All rights reserved.
//

#import <UIKit/UIKit.h>


#define SINGLE_LINE_HEIGHT           (1 / SCREEN_SCALE)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / SCREEN_SCALE) / 2)

@interface UIView (SingleLineView)

- (void)addTopSingleLine:(UIColor*)color height:(float)height;
- (void)addTopSingleLine:(UIColor*)color;
- (void)addBottomSingleLine:(UIColor*)color;
- (void)addLeftSingleLine:(UIColor*)color;
- (void)addRightSingleLine:(UIColor*)color;
- (void)addLeftSingleLineAndOffset:(CGFloat)offset color:(UIColor*)color;

- (void)addSingleLine:(CGFloat)top withLineColor:(UIColor*)color;
- (void)addRightSingleLineAndLeftOffset:(CGFloat)offset color:(UIColor*)color;

- (void)addTopAndBottomLine;

- (void)addTopSingleLineAndLeftOffset:(CGFloat)offset;
- (void)addTopSingleLineAndLeftRightOffset:(CGFloat)offset;

- (void)addCellBottomSingleLine:(UIColor*)color;
- (UIView *)addCellBottomSingleLine:(UIColor*)color Offset:(CGFloat)offset;
- (void)addBottomSingleLineAndLeftRightOffset:(CGFloat)offset color:(UIColor*)color;
@end
