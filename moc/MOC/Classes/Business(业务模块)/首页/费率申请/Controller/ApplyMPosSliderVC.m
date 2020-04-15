//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "ApplyMPosSliderVC.h"
#import "UIViewController+IIViewDeckAdditions.h"
#import "IIViewDeckController.h"
#import "SSSearchBar.h"
#import "ApplyMPosSliderView.h"
#import "NSObject+Home.h"
#import "MPosModel.h"
@interface ApplyMPosSliderVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) SSSearchBar* barView;

@property (strong, nonatomic) NSString* keyword;

@property (strong, nonatomic) NSString* last_id;

@property (strong, nonatomic) MPosModel* selectModel;

@end

@implementation ApplyMPosSliderVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    IIViewDeckController* tmp = [self viewDeckController];
    tmp.title = @"选择POS机SN码";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    IIViewDeckController* tmp = [self viewDeckController];
    tmp.title = @"MPOS";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.keyword = @"";
    self.last_id = @"";
    self.dataSource = @[];
    AdjustTableBehavior(self.tableView);
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        self.last_id = @"";
        [self getMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
            [self.tableView.header endRefreshing];
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                MPosModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.mpos_id;
            }
        }];
    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [self getMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
            [self.tableView.footer endRefreshing];
            if (array) {
                [self.dataSource addObjectsFromArray:array];
                [self.tableView reloadData];
                MPosModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.mpos_id;
            }
        }];
    }];
    
    [self getMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
        }
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
    return 50;
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
        ApplyMPosSliderView* view = [[ApplyMPosSliderView alloc]init];
        view.tag = 101;
        [cell.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
    }
    ApplyMPosSliderView* tmp = [cell.contentView viewWithTag:101];
    MPosModel* model = self.dataSource[indexPath.row];
    
    BOOL isSelected = NO;
    if (self.selectModel == model) {
        isSelected = YES;
    }
    [tmp reload:model select:isSelected];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MPosModel* model = self.dataSource[indexPath.row];
    self.selectModel = model;
    [self.tableView reloadData];
    if (self.block) {
        self.block(self.selectModel);
    }
    
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
        self.barView.delegate = self;
        self.barView.placeholder = @"搜索SN码";
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
    [self getMposList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
            MPosModel* lastObject = self.dataSource.lastObject;
            self.last_id = lastObject.mpos_id;
        }
    }];
}

-(void)dealloc{
    NSLog(@"%@",@"ApplyMPosSliderVC.m");
}
@end
