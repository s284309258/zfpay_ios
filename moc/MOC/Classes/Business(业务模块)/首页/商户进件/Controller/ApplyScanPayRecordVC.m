//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "ApplyScanPayRecordVC.h"
#import "SearchRegionView.h"
#import "RFHeader.h"
#import "ApplyRateRecordCell.h"
#import "SSSearchBar.h"
#import "NSObject+Home.h"
#import "ApplyScanRecordModel.h"
@interface ApplyScanPayRecordVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) SSSearchBar* barView;

@property (strong, nonatomic) NSString* last_id;

@property (strong, nonatomic) NSString* keyword;


@end

@implementation ApplyScanPayRecordVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavBarTitle:@"申请扫码支付记录"];
    self.dataSource = [[NSMutableArray alloc]initWithCapacity:10];
    AdjustTableBehavior(self.tableView);
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initData{
    @weakify(self)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        @strongify(self)
        self.last_id = @"";
        [self getApplyScanRecordList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
            [self.tableView.header endRefreshing];
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                ApplyScanRecordModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.record_id;
            }
        }];
    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        @strongify(self)
        [self getApplyScanRecordList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
            [self.tableView.footer endRefreshing];
            if (array) {
                [self.dataSource addObjectsFromArray:array];
                [self.tableView reloadData];
                ApplyScanRecordModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.record_id;
            }
        }];
    }];
    [self.tableView.header beginRefreshing];
   
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplyRateRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if(cell == nil) {
        cell = [[ApplyRateRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ApplyScanRecordModel* model = self.dataSource[indexPath.row];
    [cell reload:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        _tableView.tableHeaderView = self.barView;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 0, 0));
        }];
    }
    return _tableView;
}

-(void)next:(id)sender{
    [MXRouter openURL:@"lcwl://AdjustRateVC"];
}

-(SSSearchBar*)barView{
    if (!_barView) {
        _barView  = [[SSSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 45.0)];
        _barView.placeholder = @"搜索SN码";
        _barView.delegate = self;
    }
    return _barView;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.last_id = @"";
    self.keyword = searchText;
    [self getApplyScanRecordList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
            ApplyScanRecordModel* lastObject = self.dataSource.lastObject;
            self.last_id = lastObject.record_id;
        }
    }];
}
@end
