//
//  WYBaseRefreshViewController.m
//  YiFa-Boss
//
//  Created by Fly on 14-1-23.
//  Copyright (c) 2014年 Fly. All rights reserved.
//

#import "BaseRefreshViewController.h"
//#import "WYProgressHUD.h"

@interface BaseRefreshViewController ()

@end

@implementation BaseRefreshViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isAutoPullToRefresh = YES;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isAutoPullToRefresh = YES;
    }
    return self;
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    if (self.isNeedReloadData) {
//        [self.tableView triggerPullToRefresh];
//    }
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.isNeedReloadData &&
       self.tableView.header.state != MJRefreshHeaderStatePulling) {
        [self.tableView.header beginRefreshing];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupRefreshView];
}

- (void)setupRefreshView
{
    PageInfoObj* pageInfo   = [[PageInfoObj alloc] init];
    [pageInfo setInitData];
    self.mPageInfo = pageInfo;

    @weakify(self)
    [self.tableView addGifHeaderWithRefreshingBlock:^{
        @strongify(self)
        self.loadType = kLoadDataTypeHeader;
        [self willRequestNetData];
    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        @strongify(self)
        self.loadType = kLoadDataTypeFooter;
        [self willRequestNetData];
    }];

    self.isValidPullToRefresh     = YES;
    self.isValidInfiniteScrolling = NO; //默认禁用上拉刷新

    //初始调用下拉刷新
    self.loadType = kLoadDataTypeFirstLoad;
    if (self.isAutoPullToRefresh) {
        [self.tableView.header beginRefreshing];
    }
}

- (void)willRequestNetData{
    [self performSelector:@selector(doneRequestNetData:) withObject:nil afterDelay:1];
}

- (void)doneRequestNetData:(NSArray*)itemList{
    if (self.loadType == kLoadDataTypeHeader||
        self.loadType == kLoadDataTypeFirstLoad) {
        [self willHandleHeaderRequest];
    }
    [self willHandleInsertItems:itemList];
    [self.tableView reloadData];
    
    //上拉数据不足后，禁用上拉刷新
    if ([itemList count] < self.mPageInfo.pageSize) {
        [self.tableView.footer noticeNoMoreData];
        self.isValidInfiniteScrolling = NO;
    }else{
        [self.tableView.footer resetNoMoreData];
        self.isValidInfiniteScrolling = YES;
    }
    self.isNeedReloadData = NO;
    [self stopTableViewAnimating];
}

- (void)stopTableViewAnimating{
    if (self.loadType == kLoadDataTypeFooter) {
        [self.tableView.footer endRefreshing];
    }else {
        [self.tableView.header endRefreshing];
    }
}

#pragma mark - Default Handle

- (void)willHandleHeaderRequest{
    [self.mutableDataSource removeAllObjects];
}

- (void)willHandleInsertItems:(NSArray*)itemList{
    switch (self.spliteType) {
        case kSplitTypeSingleSection:
        case kSplitTypeSingleRow://默认处理
            [self.mutableDataSource addObjectsFromArray:itemList];
            break;
        case kSplitTypeSectionsRows://该方法必须重写
            break;
        default:
            break;
    }
}

- (void)prepaerRequestNetData{
    if (self.loadType == kLoadDataTypeHeader||
        self.loadType == kLoadDataTypeFirstLoad) {
        [self.mPageInfo setInitData];
    }else{
        self.mPageInfo.pageNo++;
    }
}

- (NSDictionary*)genPageInfoDict{
    return [self.mPageInfo genPageInfo];
}


#pragma mark - Custom Accessors

- (void)setIsValidPullToRefresh:(BOOL)isValidPullToRefresh{
    _isValidPullToRefresh = isValidPullToRefresh;
    self.tableView.header.hidden = !isValidPullToRefresh;
}

- (void)setIsValidInfiniteScrolling:(BOOL)isValidInfiniteScrolling{
    _isValidInfiniteScrolling = isValidInfiniteScrolling;
    self.tableView.footer.hidden = !isValidInfiniteScrolling;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

@implementation PageInfoObj

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageNo   = 0;
        _pageSize = 0;
    }
    return self;
}

- (void)setInitData{
    _pageNo  = 1;
    _pageSize = ((_pageSize > 0) ? _pageSize : 10);
}

- (NSDictionary*)genPageInfo{
    return @{kkPageNo:@(self.pageNo)};
    //    ,kkPageSize:@(self.pageSize)};
}
@end
