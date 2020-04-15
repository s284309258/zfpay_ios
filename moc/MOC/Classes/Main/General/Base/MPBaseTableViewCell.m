//
//  MPBaseTableViewCell.m
//  MoPal_Developer
//
//  Created by Fly on 15/8/12.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MPBaseTableViewCell.h"
#import "UIView+Frame.h"

@implementation MPBaseTableViewCell

- (void)dealloc{
    MLog(@"dealloc-->%@",NSStringFromClass([self class]));
}


+ (instancetype)cellWithNibIndex:(NSInteger)index{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    id cell = [nibs safeObjectAtIndex:index];
    if (cell) {
        
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self configCellSubViews];
//        [self layoutIfNeeded];
//        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (CGFloat)getCellHeight:(id)obj{
    return self.height;
}

+ (CGFloat)getCellHeight{
    return [[self cellWithNibIndex:0] getCellHeight:nil];
}

- (void)configCellSubViews{
    
}

- (void)configCellWithModel:(id)obj{
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


////IOS8里返回该属性，tableview's Separator inset
//#ifdef __IPHONE_8_0
//- (UIEdgeInsets)layoutMargins
//{
//    return UIEdgeInsetsZero;
//}
//#endif


@end
