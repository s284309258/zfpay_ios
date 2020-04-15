//
//  MPBaseTableViewCell.h
//  MoPal_Developer
//
//  Created by Fly on 15/8/12.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPBaseTableViewCell : UITableViewCell

@property (weak, nonatomic) UIViewController    *dependVC;

+ (instancetype)cellWithNibIndex:(NSInteger)index;

- (void)configCellSubViews;
- (void)configCellWithModel:(id)obj;

- (CGFloat)getCellHeight:(id)obj;
+ (CGFloat)getCellHeight;

@end
