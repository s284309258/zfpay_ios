//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "MUnbindApplyRecordVC.h"
#import "SSSearchBar.h"
#import "TextTextTextView.h"
#import "NSObject+Home.h"
#import "UnbindRecordModel.h"
@interface MUnbindApplyRecordVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSMutableArray *headerData;

@property (strong, nonatomic) SSSearchBar* barView;

@property (strong, nonatomic) NSString* keyword;

@property (strong, nonatomic) NSString* last_id;

@end

@implementation MUnbindApplyRecordVC
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
    self.headerData = @[@{@"color":@"#01C088",@"left":@"搜索范围",@"right":@""},
                        @{@"color":@"#01C088",@"left":@"搜索结果",@"right":@"签到"}];
    self.dataSource = @[];
    
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    [self getMposUnbindRecordList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
            UnbindRecordModel* tmp = self.dataSource.lastObject;
            self.last_id = tmp.unbind_id;
        }
    }];
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        self.last_id = @"";
        [self getMposUnbindRecordList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
            [self.tableView.header endRefreshing];
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                UnbindRecordModel* tmp = self.dataSource.lastObject;
                self.last_id = tmp.unbind_id;
            }
        }];
    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [self getMposUnbindRecordList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
            [self.tableView.footer endRefreshing];
            if (array) {
                [self.dataSource addObjectsFromArray:array];
                [self.tableView reloadData];
                UnbindRecordModel* tmp = self.dataSource.lastObject;
                self.last_id = tmp.unbind_id;
            }
        }];
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.dataSource.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 65;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}



#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        TextTextTextView* view = [[TextTextTextView alloc]init];
        view.tag = 101;
        
        [cell.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
    }
    TextTextTextView* view = [cell.contentView viewWithTag:101];
    UnbindRecordModel* model = self.dataSource[indexPath.row];
    NSString* state = @"";
    UIColor* color = [UIColor moPlaceHolder];
    if ([model.status isEqualToString:@"00"]) {
        state = @"解绑中";
        color = [UIColor redColor];
    }else if([model.status isEqualToString:@"09"]){
        state = @"解绑成功";
        color = [UIColor moGreen];
    }else if([model.status isEqualToString:@"08"]){
        state = @"解绑不成功";
    }
    NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:state];
    [attr addColor:color substring:state];
    [view reloadTop:[NSString stringWithFormat:@"SN码:%@",model.sn] bottom:model.cre_datetime right:attr];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
        _tableView.estimatedRowHeight = 60;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _tableView;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.last_id = @"";
    self.keyword = searchText;
    [self getMposUnbindRecordList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
            UnbindRecordModel* tmp = self.dataSource.lastObject;
            self.last_id = tmp.unbind_id;
        }
    }];
}
@end
