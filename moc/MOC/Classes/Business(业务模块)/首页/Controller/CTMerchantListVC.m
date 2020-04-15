//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "CTMerchantListVC.h"
#import "MerchantListCell.h"
#import "SSSearchBar.h"
#import "NSObject+Home.h"
#import "MerchantPosModel.h"
#import "TextChangeVC.h"
static NSString* reuseIdentifierBar = @"reuseIdentifierBar";
@interface CTMerchantListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) SSSearchBar* barView;

@property (strong, nonatomic) NSString* keyword;

@property (strong, nonatomic) NSString* last_id;

@end

@implementation CTMerchantListVC
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

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)initData{
    @weakify(self)
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"last_id":self.last_id,@"key_word":self.keyword,@"pos_type":[self.type isEqualToString:@"EPOS"]?@"epos":@""}];
    if ([self.merchantType isEqualToString:@"QBSH"]) {
        [self getAllMerchantTraditionalPosList:param completion:^(id object, NSString *error) {
            @strongify(self)
            if (object) {
                self.dataSource = object;
                [self.tableView reloadData];
                MerchantPosModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.trapos_id;
            }
        }];
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            self.last_id = @"";
            NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"last_id":self.last_id,@"key_word":self.keyword,@"pos_type":[self.type isEqualToString:@"EPOS"]?@"epos":@""}];
            [self getAllMerchantTraditionalPosList:param completion:^(id array, NSString *error) {
                [self.tableView.header endRefreshing];
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.trapos_id;
                }
            }];
        }];
        
        [self.tableView addLegendFooterWithRefreshingBlock:^{
            @strongify(self)
            NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"last_id":self.last_id,@"key_word":self.keyword,@"pos_type":[self.type isEqualToString:@"EPOS"]?@"epos":@""}];
            [self getAllMerchantTraditionalPosList:param completion:^(id array, NSString *error) {
                [self.tableView.footer endRefreshing];
                if (array) {
                    [self.dataSource addObjectsFromArray:array];
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.trapos_id;
                }
            }];
        }];
    }else if([self.merchantType isEqualToString:@"YZSH"]){
        [self getExcellentMerchantTraditionalPosList:param completion:^(id object, NSString *error) {
            @strongify(self)
            if (object) {
                self.dataSource = object;
                [self.tableView reloadData];
                MerchantPosModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.trapos_id;
            }
        }];
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            self.last_id = @"";
            NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"last_id":self.last_id,@"key_word":self.keyword,@"pos_type":[self.type isEqualToString:@"EPOS"]?@"epos":@""}];
            [self getExcellentMerchantTraditionalPosList:param completion:^(id array, NSString *error) {
                [self.tableView.header endRefreshing];
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.trapos_id;
                }
            }];
        }];
        
        [self.tableView addLegendFooterWithRefreshingBlock:^{
            @strongify(self)
            NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"last_id":self.last_id,@"key_word":self.keyword,@"pos_type":[self.type isEqualToString:@"EPOS"]?@"epos":@""}];
            [self getExcellentMerchantTraditionalPosList:param completion:^(id array, NSString *error) {
                [self.tableView.footer endRefreshing];
                if (array) {
                    [self.dataSource addObjectsFromArray:array];
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.trapos_id;
                }
            }];
        }];
    }else if([self.merchantType isEqualToString:@"HYSH"]){
        [self getActiveMerchantTraditionalPosList:param completion:^(id object, NSString *error) {
            @strongify(self)
            if (object) {
                self.dataSource = object;
                [self.tableView reloadData];
            }
        }];
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            self.last_id = @"";
            NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"last_id":self.last_id,@"key_word":self.keyword,@"pos_type":[self.type isEqualToString:@"EPOS"]?@"epos":@""}];
            [self getActiveMerchantTraditionalPosList:param completion:^(id array, NSString *error) {
                [self.tableView.header endRefreshing];
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.trapos_id;
                }
            }];
        }];
        
        [self.tableView addLegendFooterWithRefreshingBlock:^{
            @strongify(self)
            NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"last_id":self.last_id,@"key_word":self.keyword,@"pos_type":[self.type isEqualToString:@"EPOS"]?@"epos":@""}];
            [self getActiveMerchantTraditionalPosList:param completion:^(id array, NSString *error) {
                [self.tableView.footer endRefreshing];
                if (array) {
                    [self.dataSource addObjectsFromArray:array];
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.trapos_id;
                }
            }];
        }];
    }else if([self.merchantType isEqualToString:@"XMSH"]){
        [self getDormantMerchantTraditionalPosList:param completion:^(id object, NSString *error) {
            @strongify(self)
            if (object) {
                self.dataSource = object;
                [self.tableView reloadData];
                MerchantPosModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.trapos_id;
            }
        }];
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            self.last_id = @"";
            NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"last_id":self.last_id,@"key_word":self.keyword,@"pos_type":[self.type isEqualToString:@"EPOS"]?@"epos":@""}];
            [self getDormantMerchantTraditionalPosList:param completion:^(id array, NSString *error) {
                [self.tableView.header endRefreshing];
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.trapos_id;
                }
            }];
        }];
        
        [self.tableView addLegendFooterWithRefreshingBlock:^{
            @strongify(self)
            NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"last_id":self.last_id,@"key_word":self.keyword,@"pos_type":[self.type isEqualToString:@"EPOS"]?@"epos":@""}];
            [self getDormantMerchantTraditionalPosList:param completion:^(id array, NSString *error) {
                [self.tableView.footer endRefreshing];
                if (array) {
                    [self.dataSource addObjectsFromArray:array];
                    [self.tableView reloadData];
                    MerchantPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.trapos_id;
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
//    return 120;
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
    
    NSString* desc = [NSString stringWithFormat:@"%@\n%@\n%@",model.sn,([StringUtil isEmpty:model.mer_name]?@"--":model.mer_name),[StringUtil isEmpty:model.mer_id]?@"--":model.mer_id];
    NSString* mdesc = [NSString stringWithFormat:@"%@\n%@",(![StringUtil isEmpty:model.name]?model.name:@"--"),(![StringUtil isEmpty:model.tel]?model.tel:@"--")];
    [tmp reload:@"SN码:\n商户名称:\n商户号:" desc:desc mTitle:@"客户名:\n联系电话" mDesc:mdesc];
    cell.nameAndTel = ^{
        [MXRouter openURL:@"lcwl://UpdateNameTelVC" parameters:@{@"model":model}];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
      MerchantPosModel* model = self.dataSource[indexPath.section];
      [MXRouter openURL:@"lcwl://MerchantDetailVC" parameters:@{@"type":self.type,@"subType":self.merchantType,@"sn":model.sn}];
}


- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
        
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
