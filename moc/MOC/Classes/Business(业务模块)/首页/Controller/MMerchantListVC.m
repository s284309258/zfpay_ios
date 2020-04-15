//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "MMerchantListVC.h"
#import "MerchantListCell.h"
#import "SSSearchBar.h"
#import "NSObject+Home.h"
#import "MerchantPosModel.h"
static NSString* reuseIdentifierBar = @"reuseIdentifierBar";
@interface MMerchantListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) SSSearchBar* barView;

@property (strong, nonatomic) NSString* keyword;

@property (strong, nonatomic) NSString* last_id;

@end

@implementation MMerchantListVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    
}

-(void)initUI{
    [self setNavBarTitle:self.naviTitle];
    self.dataSource = @[];
    self.last_id = @"";
    AdjustTableBehavior(self.tableView);
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"merchanlist" object:nil];
}

-(void)refreshData{
    [self.tableView.header beginRefreshing];
}

-(void)initData{
    @weakify(self)
    if (self.type == 0) {
        [self getAllMerchantMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id object, NSString *error) {
            @strongify(self)
            if (object) {
                self.dataSource = object;
                [self.tableView reloadData];
                MerchantPosModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.mpos_id;
            }
        }];
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
             @strongify(self)
            self.last_id = @"";
            [self getAllMerchantMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
                [self.tableView.header endRefreshing];
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.mpos_id;
                }
            }];
        }];
        
        [self.tableView addLegendFooterWithRefreshingBlock:^{
             @strongify(self)
            [self getAllMerchantMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
                [self.tableView.footer endRefreshing];
                if (array) {
                    [self.dataSource addObjectsFromArray:array];
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.mpos_id;
                }
            }];
        }];
    }else if(self.type == 1){
        [self getExcellentMerchantMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id object, NSString *error) {
            if (object) {
                self.dataSource = object;
                [self.tableView reloadData];
                MerchantPosModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.mpos_id;
            }
        }];
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
             @strongify(self)
            self.last_id = @"";
            [self getExcellentMerchantMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
                [self.tableView.header endRefreshing];
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.mpos_id;
                }
            }];
        }];
        
        [self.tableView addLegendFooterWithRefreshingBlock:^{
             @strongify(self)
            [self getExcellentMerchantMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
                [self.tableView.footer endRefreshing];
                if (array) {
                    [self.dataSource addObjectsFromArray:array];
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.mpos_id;
                }
            }];
        }];
    }else if(self.type == 2){
        [self getActiveMerchantMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id object, NSString *error) {
            if (object) {
                self.dataSource = object;
                [self.tableView reloadData];
                MerchantPosModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.mpos_id;
            }
        }];
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
             @strongify(self)
            self.last_id = @"";
            [self getActiveMerchantMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
                [self.tableView.header endRefreshing];
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.mpos_id;
                }
            }];
        }];
        
        [self.tableView addLegendFooterWithRefreshingBlock:^{
             @strongify(self)
            [self getActiveMerchantMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
                [self.tableView.footer endRefreshing];
                if (array) {
                    [self.dataSource addObjectsFromArray:array];
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.mpos_id;
                }
            }];
        }];
    }else if(self.type == 3){
        [self getDormantMerchantMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id object, NSString *error) {
            if (object) {
                self.dataSource = object;
                [self.tableView reloadData];
                MerchantPosModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.mpos_id;
            }
        }];
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
             @strongify(self)
            self.last_id = @"";
            [self getDormantMerchantMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
                [self.tableView.header endRefreshing];
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.mpos_id;
                }
            }];
        }];
        
        [self.tableView addLegendFooterWithRefreshingBlock:^{
             @strongify(self)
            [self getDormantMerchantMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
                [self.tableView.footer endRefreshing];
                if (array) {
                    [self.dataSource addObjectsFromArray:array];
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.mpos_id;
                }
            }];
        }];
    }
    
    
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 150;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
       return 0.01;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];;
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MerchantListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBar];
    if(cell == nil) {
        cell = [[MerchantListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifierBar];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    MerchantListCell* tmp = (MerchantListCell*)cell;
    MerchantPosModel* model = self.dataSource[indexPath.section];
    NSString* mdesc = [NSString stringWithFormat:@"%@\n%@",(![StringUtil isEmpty:model.name]?model.name:@"--"),(![StringUtil isEmpty:model.tel]?model.tel:@"--")];
    [tmp reload:@"SN码:" desc:model.sn mTitle:@"商户名称:\n联系电话" mDesc:mdesc];
    cell.nameAndTel = ^{
          [MXRouter openURL:@"lcwl://UpdateNameTelVC" parameters:@{@"model":model}];
      };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MerchantPosModel* model = self.dataSource[indexPath.section];
    [MXRouter openURL:@"lcwl://MerchantDetailVC" parameters:@{@"type":@"MPOS",@"subType":@(self.type),@"sn":model.sn}];
    
}


- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
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
    [self initData];
}


@end
