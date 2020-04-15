//
//  WYBaseRefreshViewController.h
//  YiFa-Boss
//
//  Created by Fly on 14-1-23.
//  Copyright (c) 2014年 Fly. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MJRefresh.h"

#define kkPageSize              @"pageSize"
#define kkPageNo                @"pageIndex"

@class PageInfoObj;

typedef NS_ENUM(NSInteger, LoadDataType)
{
    kLoadDataTypeHeader = 0,//下拉刷新最新的数据
    kLoadDataTypeFooter = 1,//上拉加载更多数据
    kLoadDataTypeFirstLoad = 2,//页面刚进入时首次加载数据
};


@interface BaseRefreshViewController : BaseTableViewController

//是否在viewDidLoad完成后自动下拉刷新
@property (assign, nonatomic) BOOL              isAutoPullToRefresh;
@property (assign, nonatomic) BOOL              isValidPullToRefresh;
@property (assign, nonatomic) BOOL              isValidInfiniteScrolling;

@property (strong, nonatomic) PageInfoObj*      mPageInfo;
@property (assign, nonatomic) LoadDataType      loadType;

/**
 *  上拉或者下拉刷新的时候会调用该方法,子类必须要重载该方法
 *
 *  @param LoadDataType 请求来源的类型,同时会给loadType相应的赋值
 *
 */

- (void)willRequestNetData;
/**
 *  请求网络前的准备工作,默认是对_mPageInfo的pageNo的调整
 *
 *  @param LoadDataType 请求来源的类型
 *
 */
- (void)prepaerRequestNetData;
/**
 *  请求网络获取到的数据后的处理,默认是直接插入数据源mutableDataSource的操作
 *
 *  @param LoadDataType 请求来源的类型
 *
 */
- (void)doneRequestNetData:(NSArray*)itemList;
/**
 *  处理下拉请求最新数据的操作，默认是删除数据源里的所有操作，子类可以重载该操作
 */
- (void)willHandleHeaderRequest;
/**
 *  完成网络请求后把itemList插入到数据源里去，子类可以重载该操作，默认只处理SingleSection
 *  SingleRow两种类型，其它的类型需要子类重载
 *
 *  @param itemList 网络请求的数据
 */
- (void)willHandleInsertItems:(NSArray*)itemList;

/**
 *  停止上拉或者下拉的动画
 */

- (void)stopTableViewAnimating;

/**
 *  获取pageInfo的参数
 *
 *  @return @{kkPageNo:@(pageNo),kkPageSize:@(pageSize)}
 */

- (NSDictionary*)genPageInfoDict;


@end

@interface PageInfoObj : NSObject

@property (assign, nonatomic) NSInteger     pageSize;
@property (assign, nonatomic) NSInteger     pageNo;

- (void)setInitData;
- (NSDictionary*)genPageInfo;

@end
