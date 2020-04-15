//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "FenRunDetailVC2.h"
#import "FenRunDetailCell2.h"
#import "NSObject+Profit.h"
static NSString* reuseIdentifierBar = @"fenrun";
@interface FenRunDetailVC2 ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSString *last_id;

@end

@implementation FenRunDetailVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    
}

-(void)initUI{
    // Do any additional setup after loading the view.
    [self setNavBarTitle:self.navTitle];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[FenRunDetailCell2 class] forCellReuseIdentifier:reuseIdentifierBar];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    self.dataSource = @[];
    if ([self.type isEqualToString:@"CTPOS"]) {
        if ([self.subType isEqualToString:@"jhfx"]) {
            [self getMachineBackTraditionalPosList:@{@"last_id":self.last_id,@"date":self.date} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    MachineBackPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
            @weakify(self)
            [self.tableView addLegendHeaderWithRefreshingBlock:^{
                @strongify(self)
                self.last_id = @"";
                [self getMachineBackTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                    [self.tableView.header endRefreshing];
                    if (array) {
                        self.dataSource = array;
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
            
            [self.tableView addLegendFooterWithRefreshingBlock:^{
                @strongify(self)
                [self getMachineBackTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                    [self.tableView.footer endRefreshing];
                    if (array) {
                        [self.dataSource addObjectsFromArray:array];
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
            
        }else if([self.subType isEqualToString:@"hdjl"]){
            [self getActivityRewardTraditionalPosList:@{@"last_id":self.last_id,@"date":self.date} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    
                    MachineBackPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
            @weakify(self)
            [self.tableView addLegendHeaderWithRefreshingBlock:^{
                @strongify(self)
                self.last_id = @"";
                [self getActivityRewardTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                    [self.tableView.header endRefreshing];
                    if (array) {
                        self.dataSource = array;
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
            
            [self.tableView addLegendFooterWithRefreshingBlock:^{
                @strongify(self)
                [self getActivityRewardTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                    [self.tableView.footer endRefreshing];
                    if (array) {
                        [self.dataSource addObjectsFromArray:array];
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
        }else if([self.subType isEqualToString:@"khwdbkc"]){
            [self getDeductTraditionalPosList:@{@"last_id":self.last_id,@"date":self.date} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    MachineBackPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
            @weakify(self)
            [self.tableView addLegendHeaderWithRefreshingBlock:^{
                @strongify(self)
                self.last_id = @"";
                [self getDeductTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                    [self.tableView.header endRefreshing];
                    if (array) {
                        self.dataSource = array;
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
            
            [self.tableView addLegendFooterWithRefreshingBlock:^{
                @strongify(self)
                [self getDeductTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                    [self.tableView.footer endRefreshing];
                    if (array) {
                        [self.dataSource addObjectsFromArray:array];
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
        }
    } else   if ([self.type isEqualToString:@"EPOS"]) {
        if ([self.subType isEqualToString:@"jhfx"]) {
            [self getMachineBackTraditionalPosList:@{@"last_id":self.last_id,@"date":self.date,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    MachineBackPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
            @weakify(self)
            [self.tableView addLegendHeaderWithRefreshingBlock:^{
                @strongify(self)
                self.last_id = @"";
                [self getMachineBackTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                    [self.tableView.header endRefreshing];
                    if (array) {
                        self.dataSource = array;
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
            
            [self.tableView addLegendFooterWithRefreshingBlock:^{
                @strongify(self)
                [self getMachineBackTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                    [self.tableView.footer endRefreshing];
                    if (array) {
                        [self.dataSource addObjectsFromArray:array];
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
            
        }else if([self.subType isEqualToString:@"hdjl"]){
            [self getActivityRewardTraditionalPosList:@{@"last_id":self.last_id,@"date":self.date,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    
                    MachineBackPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
            @weakify(self)
            [self.tableView addLegendHeaderWithRefreshingBlock:^{
                @strongify(self)
                self.last_id = @"";
                [self getActivityRewardTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                    [self.tableView.header endRefreshing];
                    if (array) {
                        self.dataSource = array;
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
            
            [self.tableView addLegendFooterWithRefreshingBlock:^{
                @strongify(self)
                [self getActivityRewardTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                    [self.tableView.footer endRefreshing];
                    if (array) {
                        [self.dataSource addObjectsFromArray:array];
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
        }else if([self.subType isEqualToString:@"khwdbkc"]){
            [self getDeductTraditionalPosList:@{@"last_id":self.last_id,@"date":self.date,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    MachineBackPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
            @weakify(self)
            [self.tableView addLegendHeaderWithRefreshingBlock:^{
                @strongify(self)
                self.last_id = @"";
                [self getDeductTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                    [self.tableView.header endRefreshing];
                    if (array) {
                        self.dataSource = array;
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
            
            [self.tableView addLegendFooterWithRefreshingBlock:^{
                @strongify(self)
                [self getDeductTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                    [self.tableView.footer endRefreshing];
                    if (array) {
                        [self.dataSource addObjectsFromArray:array];
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
        }
    }else{
        if ([self.subType isEqualToString:@"jhfx"]) {
            [self getMachineBackMposList:@{@"last_id":self.last_id,@"date":self.date} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    MachineBackPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
            @weakify(self)
            [self.tableView addLegendHeaderWithRefreshingBlock:^{
                @strongify(self)
                self.last_id = @"";
                [self getMachineBackMposList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                    [self.tableView.header endRefreshing];
                    if (array) {
                        self.dataSource = array;
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
            
            [self.tableView addLegendFooterWithRefreshingBlock:^{
                @strongify(self)
                [self getMachineBackMposList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                    [self.tableView.footer endRefreshing];
                    if (array) {
                        [self.dataSource addObjectsFromArray:array];
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
        }else if([self.subType isEqualToString:@"hdjl"]){
            [self getActivityRewardMposList:@{@"last_id":self.last_id,@"date":self.date} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    MachineBackPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
            @weakify(self)
            [self.tableView addLegendHeaderWithRefreshingBlock:^{
                @strongify(self)
                self.last_id = @"";
                [self getActivityRewardMposList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                    [self.tableView.header endRefreshing];
                    if (array) {
                        self.dataSource = array;
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
            
            [self.tableView addLegendFooterWithRefreshingBlock:^{
                @strongify(self)
                [self getActivityRewardMposList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                    [self.tableView.footer endRefreshing];
                    if (array) {
                        [self.dataSource addObjectsFromArray:array];
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
        }else if([self.subType isEqualToString:@"khwdbkc"]){
            [self getDeductMposList:@{@"last_id":self.last_id,@"date":self.date} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    MachineBackPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
            @weakify(self)
            [self.tableView addLegendHeaderWithRefreshingBlock:^{
                @strongify(self)
                self.last_id = @"";
                [self getDeductMposList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                    [self.tableView.header endRefreshing];
                    if (array) {
                        self.dataSource = array;
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
            
            [self.tableView addLegendFooterWithRefreshingBlock:^{
                @strongify(self)
                [self getDeductMposList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                    [self.tableView.footer endRefreshing];
                    if (array) {
                        [self.dataSource addObjectsFromArray:array];
                        [self.tableView reloadData];
                        MachineBackPosModel* lastObject = self.dataSource.lastObject;
                        self.last_id = lastObject.record_id;
                    }
                }];
            }];
        }
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
    return 1;self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
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
    FenRunDetailCell2* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBar forIndexPath:indexPath];
    if (!cell) {
        cell = [[FenRunDetailCell2 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierBar];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MachineBackPosModel* tmp = self.dataSource[indexPath.section];
    [cell reload:tmp type:self.subType];
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
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 0, 0));
        }];
    }
    return _tableView;
}


@end
