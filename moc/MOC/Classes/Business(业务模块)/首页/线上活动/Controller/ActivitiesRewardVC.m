//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "ActivitiesRewardVC.h"
#import "CTRewardView.h"
#import "NSObject+Home.h"
#import "PosRewardModel.h"
static NSString* reuseIdentifierBar = @"fenrun";
@interface ActivitiesRewardVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSString *last_id;


@end

@implementation ActivitiesRewardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavBarTitle:@"活动奖励明细"];
    self.dataSource = @[];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[CTRewardView class] forCellReuseIdentifier:reuseIdentifierBar];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    if ([self.type isEqualToString:@"0"]) {
        [self getTraditionalPosRewardRecordList:@{@"last_id":self.last_id} completion:^(id array, NSString *error) {
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                PosRewardModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.record_id;
            }
        }];
        @weakify(self)
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            self.last_id = @"";
            [self getTraditionalPosRewardRecordList:@{@"last_id":self.last_id} completion:^(id array, NSString *error) {
                [self.tableView.header endRefreshing];
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    PosRewardModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
        }];
        
        [self.tableView addLegendFooterWithRefreshingBlock:^{
            @strongify(self)
            [self getTraditionalPosRewardRecordList:@{@"last_id":self.last_id} completion:^(id array, NSString *error) {
                [self.tableView.footer endRefreshing];
                if (array) {
                    [self.dataSource addObjectsFromArray:array];
                    [self.tableView reloadData];
                    PosRewardModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
        }];
        
    }else if([self.type isEqualToString:@"1"]){
        [self getMposRewardRecordList:@{@"last_id":self.last_id} completion:^(id array, NSString *error) {
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                PosRewardModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.record_id;
            }
        }];
        @weakify(self)
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            self.last_id = @"";
            [self getMposRewardRecordList:@{@"last_id":self.last_id} completion:^(id array, NSString *error) {
                [self.tableView.header endRefreshing];
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    PosRewardModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
        }];
        
        [self.tableView addLegendFooterWithRefreshingBlock:^{
            @strongify(self)
            [self getMposRewardRecordList:@{@"last_id":self.last_id} completion:^(id array, NSString *error) {
                [self.tableView.footer endRefreshing];
                if (array) {
                    [self.dataSource addObjectsFromArray:array];
                    [self.tableView reloadData];
                    PosRewardModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
        }];
        
    }else{
        [self getTraditionalPosRewardRecordList:@{@"last_id":self.last_id,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                PosRewardModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.record_id;
            }
        }];
        @weakify(self)
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            self.last_id = @"";
            [self getTraditionalPosRewardRecordList:@{@"last_id":self.last_id,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                [self.tableView.header endRefreshing];
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    PosRewardModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
        }];
        
        [self.tableView addLegendFooterWithRefreshingBlock:^{
            @strongify(self)
            [self getTraditionalPosRewardRecordList:@{@"last_id":self.last_id,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                [self.tableView.footer endRefreshing];
                if (array) {
                    [self.dataSource addObjectsFromArray:array];
                    [self.tableView reloadData];
                    PosRewardModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
        }];
        
    }
        
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 245;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CTRewardView* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBar forIndexPath:indexPath];
    if (!cell) {
        cell = [[CTRewardView alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierBar];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PosRewardModel* model = self.dataSource[indexPath.section];
    [cell reload:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [MXRouter openURL:@"lcwl://ActivitiesOrderDetailVC"];
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
