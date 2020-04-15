//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "AssignMRecordVC.h"
#import "SSSearchBar.h"
#import "TextTextImgView.h"
#import "NSObject+Home.h"
#import "AllocationPosBatchModel.h"
#import "AssignUpdateVC.h"
#import "IIViewDeckController.h"
#import "AllocationPosBatchModel.h"
#import "AllocationPosView.h"
@interface AssignMRecordVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) SSSearchBar* barView;

@property (strong, nonatomic) NSString* keyword;

@property (strong, nonatomic) NSString* last_id;

@property (strong , nonatomic) IIViewDeckController *viewDeckController;

@end

@implementation AssignMRecordVC
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
   @weakify(self)
    [self selectPosBatchAllocate:@{@"last_id":self.last_id,@"key_word":self.keyword,@"pos_type":@"MPOS"} completion:^(id array, NSString *error) {
        @strongify(self)
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
            AllocationPosBatchModel* tmp = self.dataSource.lastObject;
            self.last_id = tmp.id;
        }
    }];
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        @strongify(self)
        self.last_id = @"";
        [self selectPosBatchAllocate:@{@"last_id":self.last_id,@"key_word":self.keyword,@"pos_type":@"MPOS"} completion:^(id array, NSString *error) {
            [self.tableView.header endRefreshing];
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                AllocationPosBatchModel* tmp = self.dataSource.lastObject;
                self.last_id = tmp.id;
            }
        }];
    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        @strongify(self)
        [self selectPosBatchAllocate:@{@"last_id":self.last_id,@"key_word":self.keyword,@"pos_type":@"MPOS"} completion:^(id array, NSString *error) {
            [self.tableView.footer endRefreshing];
            if (array) {
                [self.dataSource addObjectsFromArray:array];
                [self.tableView reloadData];
                AllocationPosBatchModel* tmp = self.dataSource.lastObject;
                self.last_id = tmp.id;
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
        AllocationPosView* view = [[AllocationPosView alloc]init];
        view.tag = 101;
        [cell.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
    }
    AllocationPosView* view = [cell.contentView viewWithTag:101];
    AllocationPosBatchModel* model = self.dataSource[indexPath.row];
    [view reload:model];
//    {
//        NSString* str1 = [NSString stringWithFormat:@"SN码:%@-%@",model.min_sn,model.max_sn];
//        NSString* str2 = [NSString stringWithFormat:@"(代理:%@)",[StringUtil isEmpty:model.real_name]?@"":model.real_name];
//        NSString* agent = [NSString stringWithFormat:@"%@ %@",str1,str2];
//        NSMutableAttributedString * attr = [[NSMutableAttributedString alloc]initWithString:agent];
//        [attr addColor:[UIColor moPlaceHolder] substring:str1];
//        [attr addFont:[UIFont systemFontOfSize:13] substring:str2];
//        [view reloadTop:attr bottom:model.allocate_date right:@"更多"];
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     AllocationPosBatchModel* model = self.dataSource[indexPath.row];
    AssignUpdateVC* vc = [[AssignUpdateVC alloc]init];
    vc.type = 0;
    vc.batchModel = model;
    self.viewDeckController = [[IIViewDeckController alloc] initWithCenterViewController:vc rightViewController:nil];
    self.viewDeckController.title = @"分配修改";
    UIButton    * customBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [customBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [customBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    customBtn.enabled = NO;
    [customBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:customBtn];
    self.viewDeckController.navigationItem.leftBarButtonItem = barItem ;
    //添加完成btn
    [self.navigationController pushViewController:self.viewDeckController animated:YES];
    
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
    @weakify(self)
    [self selectPosBatchAllocate:@{@"last_id":self.last_id,@"key_word":self.keyword,@"pos_type":@"MPOS"} completion:^(id array, NSString *error) {
        @strongify(self)
        if (array) {
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                AllocationPosBatchModel* tmp = self.dataSource.lastObject;
                self.last_id = tmp.id;
            }
        }
    }];
}
@end
