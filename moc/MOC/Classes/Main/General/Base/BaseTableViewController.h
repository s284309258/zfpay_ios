//
//  BaseTableViewController.h
//  MoPal_Developer
//
//  Created by Fly on 15/8/12.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "BaseViewController.h"

static NSString* cellReuseID = @"cellReuseIdentifier";

typedef NS_ENUM(NSInteger, SubItemSplitType)
{
    kSplitTypeSingleSection = 0,//section:1,row:N
    kSplitTypeSingleRow     = 1,//section:N,row:1
    kSplitTypeSectionsRows  = 2,//section:N,row:N
};


@interface BaseTableViewController : BaseViewController

<UITableViewDelegate,UITableViewDataSource>

@property (strong, readonly, nonatomic) NSString* cellReuseIdentifier;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray*   mutableDataSource;
@property (assign, nonatomic) SubItemSplitType  spliteType;

//缩略显示的行数,只对kSplitTypeSingleSection有效，且小于[mutableDataSource count]时无效
@property (assign, nonatomic) NSUInteger        showMinifiedRow;
@property (assign, readonly, nonatomic) BOOL  shouldShowMoreCell;

//是否需要刷新当前页面的数据,请求完数据后因该赋值为NO，一般是在viewWillAppear的时候调用,
@property (assign, nonatomic) BOOL          isNeedReloadData;

- (instancetype)initWithStyle:(UITableViewStyle)style;

//registerCell
- (void)registerTableViewNibWithCellClass:(Class)cellClass;
- (void)registerTableViewWithCellClass:(Class)cellClass;

- (void)registerCellNibName:(NSString*)nibName
                cellReuseId:(NSString *)identifier;
- (void)registerCellClass:(Class)cellClass
              cellReuseId:(NSString *)identifier;
- (void)registerTableViewReuseHeaderFooter:(Class)viewClass;

- (id)subItemAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Public
/**
 *  用来计算AutoLayout状态下的cell的动态高度
 *
 *  @param indexPath 需要计算高度的cell
 *
 *  @return 返回当前cell的高度
 */
- (CGFloat)dynamicHeightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end