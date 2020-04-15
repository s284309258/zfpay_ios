//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "MRewardVC.h"
#import "CTRewardCell.h"
#import "NSObject+Home.h"
#import "TraditionalPosActivityApplyModel.h"
static NSString* reuseIdentifierBar = @"fenrun";
@interface MRewardVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSString *last_id;

@end

@implementation MRewardVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    [self.tableView.header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
      [self initData];
}

-(void)initUI{
    self.dataSource = @[];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[CTRewardCell class] forCellReuseIdentifier:reuseIdentifierBar];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    AdjustTableBehavior(self.tableView)
}

-(void)initData{
    @weakify(self)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        @strongify(self)
        self.last_id = @"";
        [self getMposActivityApplyList:@{@"last_id":self.last_id} completion:^(id array, NSString *error) {
            [self.tableView.header endRefreshing];
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                TraditionalPosActivityApplyModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.apply_id;
            }
        }];
    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        @strongify(self)
        [self getMposActivityApplyList:@{@"last_id":self.last_id} completion:^(id array, NSString *error) {
            [self.tableView.footer endRefreshing];
            if (array) {
                [self.dataSource addObjectsFromArray:array];
                [self.tableView reloadData];
                TraditionalPosActivityApplyModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.apply_id;
            }
        }];
    }];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 155;
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
    CTRewardCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBar forIndexPath:indexPath];
    if (!cell) {
        cell = [[CTRewardCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierBar];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TraditionalPosActivityApplyModel* model = self.dataSource[indexPath.section];
    [cell reload:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TraditionalPosActivityApplyModel* model = self.dataSource[indexPath.section];
    [MXRouter openURL:@"lcwl://ActivitiesOrderDetailVC" parameters:@{@"apply_id":model.apply_id,@"type":@"1"}];
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
