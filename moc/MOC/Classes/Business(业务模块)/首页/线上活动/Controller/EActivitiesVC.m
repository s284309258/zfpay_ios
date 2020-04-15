//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "EActivitiesVC.h"
#import "CTActivitiesView.h"
#import "NSObject+Home.h"
#import "TraditionalPosActivityModel.h"
@interface EActivitiesVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation EActivitiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI{
    // Do any additional setup after loading the view.
    [self setNavBarTitle:@"应用中心" color:[UIColor whiteColor]];
    self.dataSource = @[];
    [self.view addSubview:self.tableView];
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    
    AdjustTableBehavior(self.tableView);
    @weakify(self)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        @strongify(self)
        [self getTraditionalPosOnlineActivityList:@{@"pos_type":@"epos"} completion:^(id array, NSString *error) {
            [self.tableView.header endRefreshing];
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
            }
        }];
    }];
    
    [self getTraditionalPosOnlineActivityList:@{@"pos_type":@"epos"} completion:^(id array, NSString *error) {
        @strongify(self)
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        CTActivitiesView* view = [[CTActivitiesView alloc]init];
        view.tag = 101;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view];
        cell.backgroundColor = [UIColor clearColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(15, 15, 15, 15));
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CTActivitiesView* view = [cell.contentView viewWithTag:101];
    TraditionalPosActivityModel* model = self.dataSource[indexPath.row];
    [view reload:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TraditionalPosActivityModel* model = self.dataSource[indexPath.row];
    [MXRouter openURL:@"lcwl://ActivityVC" parameters:@{@"activity_id":model.activity_id,@"type":@"2"}];
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 0, 0));
        }];
    }
    return _tableView;
}


@end
