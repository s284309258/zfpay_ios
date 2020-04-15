//
//  UITableViewCell+CellUtils.h
//  WYPatient
//
//  Created by Fly on 2/10/15.
//  Copyright (c) 2015 FLy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (CellUtils)

- (CGFloat)getCellAutoLayoutDynamicHeight;

- (void)addBottomHorizontalLine:(CGFloat)leftEdge;
- (void)addBottomHorizontalLine:(CGFloat)leftEdge withRightEdge:(CGFloat)rightEdge;

- (void)hiddenBottomHorizontalLine;

- (void)addTopHorizontalLine:(CGFloat)leftEdge;
- (void)hiddenTopHorizontalLine;

@end
