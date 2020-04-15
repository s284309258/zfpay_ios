//
//  DCBarCell.m
//  UUChart
//
//  Created by 2014-763 on 15/3/13.
//  Copyright (c) 2015年 meilishuo. All rights reserved.
//

#import "SCBarCell.h"
#import "JHChartHeader.h"

@interface SCBarCell ()
{
    NSIndexPath *path;
    JHColumnChart *column;
}
@end

@implementation SCBarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    column = [[JHColumnChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
    /*       This point represents the distance from the lower left corner of the origin.         */
    column.originSize = CGPointMake(30, 20);
    /*    The first column of the distance from the starting point     */
    column.drawFromOriginX = 20;
    column.backgroundColor = [UIColor whiteColor];
    column.typeSpace = 10;
    column.isShowYLine = YES;
    column.contentInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    /*        Column width         */
    column.columnWidth = 35;
    /*        Column backgroundColor         */
    column.bgVewBackgoundColor = [UIColor whiteColor];
    UIColor* color = [UIColor colorWithRed:28/255.0 green:204/255.0 blue:154/255.0 alpha:1.0];
    /*        X, Y axis font color         */
    column.drawTextColorForX_Y = color;//[UIColor colorWithRed:50/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    /*        X, Y axis line color         */
    column.colorForXYLine = [UIColor blackColor];
    /*    Each module of the color array, such as the A class of the language performance of the color is red, the color of the math achievement is green     */
    column.columnBGcolorsArr = @[color,color];//如果为复合型柱状图 即每个柱状图分段 需要传入如上颜色数组
    
    column.delegate = self;
    
    [self addSubview:column];
    
}

-(void)layout{
    
}

-(void)configValueArr:(NSMutableArray*)valueArr showInfoText:(NSMutableArray*)showInfoText{
    column.valueArr = valueArr;
    column.xShowInfoText = showInfoText;
    [column showAnimation];
}
@end
