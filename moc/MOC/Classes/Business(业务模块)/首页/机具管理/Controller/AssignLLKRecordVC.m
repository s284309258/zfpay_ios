//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "AssignLLKRecordVC.h"
#import "SSSearchBar.h"
#import "TextTextImgView.h"
#import "NSObject+Home.h"
#import "AllocationPosModel.h"
@interface AssignLLKRecordVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) SSSearchBar* barView;

@property (strong, nonatomic) NSString* keyword;

@property (strong, nonatomic) NSString* last_id;

@end

@implementation AssignLLKRecordVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavBarTitle:@"应用中心" color:[UIColor whiteColor]];
    self.dataSource = @[];
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    [self getAllocationTrafficCardList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
        }
    }];
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        self.last_id = @"";
        [self getAllocationTrafficCardList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
            [self.tableView.header endRefreshing];
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                AllocationPosModel* tmp = self.dataSource.lastObject;
                self.last_id = tmp.allocation_id;
            }
        }];
    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [self getAllocationTrafficCardList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
            [self.tableView.footer endRefreshing];
            if (array) {
                [self.dataSource addObjectsFromArray:array];
                [self.tableView reloadData];
                AllocationPosModel* tmp = self.dataSource.lastObject;
                self.last_id = tmp.allocation_id;
            }
        }];
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}



#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        TextTextImgView* view = [[TextTextImgView alloc]init];
        view.tag = 101;
        [cell.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
    }
    TextTextImgView* view = [cell.contentView viewWithTag:101];
    AllocationPosModel* model = self.dataSource[indexPath.row];
    
    {
        NSString* str1 = [NSString stringWithFormat:@"流量卡号:%@",model.card_no];
        NSString* str2 = [NSString stringWithFormat:@"(代理:%@)",[StringUtil isEmpty:model.real_name]?@"":model.real_name];
        NSString* agent = [NSString stringWithFormat:@"%@ %@",str1,str2];
        NSMutableAttributedString * attr = [[NSMutableAttributedString alloc]initWithString:agent];
        [attr addColor:[UIColor moPlaceHolder] substring:str1];
        [attr addFont:[UIFont systemFontOfSize:13] substring:str1];
        [attr addFont:[UIFont systemFontOfSize:12] substring:str2];
        [view reloadTop:attr bottom:model.cre_datetime right:@""];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [MXRouter openURL:@"lcwl://AssignUpdateVC" parameters:@{@"type":@(0)}];
    
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        self.barView  = [[SSSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 45.0)];
        self.barView.placeholder = @"搜索SN码";
        self.barView.delegate = self;
        _tableView.tableHeaderView = self.barView;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _tableView;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.last_id = @"";
    self.keyword = searchText;
    [self getAllocationTrafficCardList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
        if (array) {
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                AllocationPosModel* tmp = self.dataSource.lastObject;
                self.last_id = tmp.allocation_id;
            }
        }
    }];
}
@end
