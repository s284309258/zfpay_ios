//
//  BaseSTDTableViewVC.m
//  BOB
//
//  Created by mac on 2019/6/27.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseSTDTableViewVC.h"
#import "LYEmptyViewHeader.h"
#import "BaseSTDCellModel.h"

@interface BaseSTDTableViewVC ()

@end

@implementation BaseSTDTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableView];
    
    [self setupTableViewDataSource];
    
    [self startGetData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - setup

- (void)setupTableView
{
    self.dataSource = [NSMutableArray arrayWithCapacity:1];
    
    _tableView = [UITableView std_tableViewWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]init];
    
    _tableView.std_viewController = self;
    
    [self configTableView:_tableView];
    
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:_tableView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:@{@"tableView":_tableView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:@{@"tableView":_tableView}]];
    
    AdjustTableBehavior(self.tableView);
    
    @weakify(self)
    if([self needPullDownRefresh]) {
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
           self.pageNum = [self pageNumDefaultValue];
           self.last_id = nil;
           [self startGetData];
        }];
    }
    
    if([self needPullUpRefresh]) {
        [self.tableView addLegendFooterWithRefreshingBlock:^{
            @strongify(self)
            self.pageNum = [@([self.pageNum integerValue] + 1) description];

            NSInteger sectionCount = [[self.tableView std_allSections] count];
            if([self getValueFromItemLastIdKey] && sectionCount > 0) {
                NSString *key = [self getValueFromItemLastIdKey];
                if(key) {
                    id model = [[self.tableView std_itemsAtSection:sectionCount - 1] lastObject].data;
                    id lastId = [model valueForKey:key];
                    self.last_id = [lastId isKindOfClass:[NSString class]] ? lastId : [@([lastId integerValue]) description];
                }
            }

            [self startGetData];
        }];
    }
}

- (void)configTableView:(UITableView *)tableView
{
    
}

- (void)setupTableViewDataSource
{
    
}

- (void)startGetData {
    
    if([self requestUrl] == nil) {
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot,[self requestUrl]];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:[self requestArgument]];
    if([self pageNumKey] != nil) {
        [param setValue:self.pageNum forKey:[self pageNumKey]];
    } else if([self httpRequstLastIdKey] != nil) {
        [param setValue:self.last_id forKey:[self httpRequstLastIdKey]];
    }
    
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).useEncrypt().params(param)
        .finish(^(id data) {
            [self endTableViewRefreshing];
            [self requestResponse:data];
        }).failure(^(id error) {
            [self endTableViewRefreshing];
        })
        .execute();
    }];
}

- (void)requestResponse:(NSDictionary *)data {
    if([data isSuccess]) {
        if([self pageNumKey] != nil && [self.pageNum isEqualToString:[self pageNumDefaultValue]]) {
            [self.tableView std_removeAllItemAtSection:0];
        } else if([self httpRequstLastIdKey] != nil && self.last_id == nil) {
            [self.tableView std_removeAllItemAtSection:0];
        }
        
        if([[self model] isSubclassOfClass:[BaseObject class]]) {
            NSArray *arr = [[self model] modelListParseWithArray:[data valueForKeyPath:[self dataListKeyPath]]];
            //[self.dataSource addObjectsFromArray:arr];
            if(arr && arr.count > 0) {
                [self.tableView std_addItems:arr atSection:0];
                [self.tableView reloadData];
            }
        }
    }
}

//停止tableview刷新
- (void)endTableViewRefreshing
{
//    if (self.tableView.mj_header.isRefreshing) {
//        [self.tableView.mj_header endRefreshing];
//    } else if (self.tableView.footer.isRefreshing) {
//        [self.tableView.footer endRefreshing];
//    }
}

#pragma mark - 网络请求配置
- (HTTPRequestMethod)httpMethod {
    return HTTPRequestMethodPost;
}

- (NSString *)requestUrl {
    return nil;
}

- (NSDictionary *)requestArgument {
    return nil;
}

///请求时传入pageNum的key
- (NSString *)pageNumKey {
    return nil;
}

///分页pagenum的默认值
- (NSString *)pageNumDefaultValue {
    return nil;
}

///请求时传入last id的key
- (NSString *)httpRequstLastIdKey {
    return nil;
}

///上拉刷新时从数据源数组中最后一个元素取值的key
- (NSString *)getValueFromItemLastIdKey {
    return nil;
}

///后台返回数据中数组的keypath
- (NSString *)dataListKeyPath {
    return nil;
}

///数据源中的model,需要结成BaseObject
- (Class)model {
    return Nil;
}

///是否需要上拉刷新
- (BOOL)needPullUpRefresh {
    return NO;
}

///是否需要下拉刷新
- (BOOL)needPullDownRefresh {
    return NO;
}

#pragma mark - 展示数据为空的各种页面

///隐藏空页面
- (void)hideEmptyView{
    [self.tableView ly_hideEmptyView];
}

- (void)showEmptyActionViewWithImage:(UIImage *)image
                                titleStr:(NSString *)titleStr
                               detailStr:(NSString *)detailStr
                             btnTitleStr:(NSString *)btnTitleStr
                                  target:(id)target
                                  action:(SEL)action {
    self.tableView.ly_emptyView = [LYEmptyView emptyActionViewWithImage:image
                                                               titleStr:titleStr
                                                              detailStr:detailStr
                                                            btnTitleStr:btnTitleStr
                                                                 target:target
                                                                 action:action];
    [self.tableView ly_showEmptyView];
    
}

- (void)showEmptyActionViewWithImage:(UIImage *)image
                                titleStr:(NSString *)titleStr
                               detailStr:(NSString *)detailStr
                             btnTitleStr:(NSString *)btnTitleStr
                           btnClickBlock:(LYActionTapBlock)btnClickBlock {
    self.tableView.ly_emptyView = [LYEmptyView emptyActionViewWithImage:image
                                                               titleStr:titleStr
                                                              detailStr:detailStr
                                                            btnTitleStr:btnTitleStr
                                                          btnClickBlock:btnClickBlock];
    [self.tableView ly_showEmptyView];
}

- (void)showEmptyActionViewWithImageStr:(NSString *)imageStr
                                   titleStr:(NSString *)titleStr
                                  detailStr:(NSString *)detailStr
                                btnTitleStr:(NSString *)btnTitleStr
                                     target:(id)target
                                     action:(SEL)action {
    self.tableView.ly_emptyView = [LYEmptyView emptyActionViewWithImageStr:imageStr
                                                                  titleStr:titleStr
                                                                 detailStr:detailStr
                                                               btnTitleStr:btnTitleStr
                                                                    target:target
                                                                    action:action];
    [self.tableView ly_showEmptyView];
}

- (void)showEmptyActionViewWithImageStr:(NSString *)imageStr
                                   titleStr:(NSString *)titleStr
                                  detailStr:(NSString *)detailStr
                                btnTitleStr:(NSString *)btnTitleStr
                              btnClickBlock:(LYActionTapBlock)btnClickBlock {
    self.tableView.ly_emptyView = [LYEmptyView emptyActionViewWithImageStr:imageStr
                                                                  titleStr:titleStr
                                                                 detailStr:detailStr
                                                               btnTitleStr:btnTitleStr
                                                             btnClickBlock:btnClickBlock];
    [self.tableView ly_showEmptyView];
}

- (void)showEmptyViewWithImage:(UIImage *)image
                          titleStr:(NSString *)titleStr
                         detailStr:(NSString *)detailStr {
    self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImage:image
                                                            titleStr:titleStr
                                                           detailStr:detailStr];
    [self.tableView ly_showEmptyView];
}

- (void)showEmptyView:(NSString *)imageStr
             titleStr:(NSString *)titleStr
            detailStr:(NSString *)detailStr {
    self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:imageStr
                                                            titleStr:titleStr
                                                           detailStr:detailStr];
    [self.tableView ly_showEmptyView];
};

- (void)showEmptyViewWithCustomView:(UIView *)customView {
    self.tableView.ly_emptyView = [LYEmptyView emptyViewWithCustomView:customView];
    [self.tableView ly_showEmptyView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STDTableViewItem *item = [tableView std_itemAtIndexPath:indexPath];
    
    return item.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    STDTableViewItem *item = [self.tableView std_itemAtIndexPath:indexPath];
    BaseSTDCellModel *model = (BaseSTDCellModel *)item.data;
    if([model isKindOfClass:[BaseSTDCellModel class]] && model.jumpVC != nil && model.jumpVC.length > 0) {
        NSString *prefix = @"lcwl://";
        if([model.jumpVC hasPrefix:@"lcwl://"]) {
            prefix = @"";
        }
        [MXRouter openURL:[NSString stringWithFormat:@"%@%@",prefix,model.jumpVC] parameters:model.jumpParam];
    }
}


@end
