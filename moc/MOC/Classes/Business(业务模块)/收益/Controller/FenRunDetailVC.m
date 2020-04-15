//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "FenRunDetailVC.h"
#import "FenRunDetailCell.h"
#import "NSObject+Profit.h"
#import "ShareBenefitPosModel.h"
static NSString* reuseIdentifierBar = @"fenrun";
@interface FenRunDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSString *last_id;

@end

@implementation FenRunDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
}

-(void)initUI{
    
    [self setNavBarTitle:self.navTitle];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[FenRunDetailCell class] forCellReuseIdentifier:reuseIdentifierBar];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    if ([self.type isEqualToString:@"CTPOS"]) {
        [self getShareBenefitTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                ShareBenefitPosModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.record_id;
            }
        }];
        
        @weakify(self)
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            self.last_id = @"";
            [self getShareBenefitTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                [self.tableView.header endRefreshing];
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    ShareBenefitPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
        }];
        
        [self.tableView addLegendFooterWithRefreshingBlock:^{
            @strongify(self)
            [self getShareBenefitTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                [self.tableView.footer endRefreshing];
                if (array) {
                    [self.dataSource addObjectsFromArray:array];
                    [self.tableView reloadData];
                    ShareBenefitPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
        }];
        
    }else  if ([self.type isEqualToString:@"EPOS"]) {
        [self getShareBenefitTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
              if (array) {
                  self.dataSource = array;
                  [self.tableView reloadData];
                  ShareBenefitPosModel* lastObject = self.dataSource.lastObject;
                  self.last_id = lastObject.record_id;
              }
          }];
          
          @weakify(self)
          [self.tableView addLegendHeaderWithRefreshingBlock:^{
              @strongify(self)
              self.last_id = @"";
              [self getShareBenefitTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                  [self.tableView.header endRefreshing];
                  if (array) {
                      self.dataSource = array;
                      [self.tableView reloadData];
                      ShareBenefitPosModel* lastObject = self.dataSource.lastObject;
                      self.last_id = lastObject.record_id;
                  }
              }];
          }];
          
          [self.tableView addLegendFooterWithRefreshingBlock:^{
              @strongify(self)
              [self getShareBenefitTraditionalPosList:@{@"date":self.date,@"last_id":self.last_id,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                  [self.tableView.footer endRefreshing];
                  if (array) {
                      [self.dataSource addObjectsFromArray:array];
                      [self.tableView reloadData];
                      ShareBenefitPosModel* lastObject = self.dataSource.lastObject;
                      self.last_id = lastObject.record_id;
                  }
              }];
          }];
          
      }else{
        [self getShareBenefitMposList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                ShareBenefitPosModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.record_id;
            }
        }];
        @weakify(self)
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            self.last_id = @"";
            [self getShareBenefitMposList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                [self.tableView.header endRefreshing];
                if (array) {
                    self.dataSource = array;
                    [self.tableView reloadData];
                    ShareBenefitPosModel* lastObject = self.dataSource.lastObject;
                    self.last_id = lastObject.record_id;
                }
            }];
        }];
        
        [self.tableView addLegendFooterWithRefreshingBlock:^{
            @strongify(self)
            [self getShareBenefitMposList:@{@"date":self.date,@"last_id":self.last_id} completion:^(id array, NSString *error) {
                [self.tableView.footer endRefreshing];
                if (array) {
                    [self.dataSource addObjectsFromArray:array];
                    [self.tableView reloadData];
                    ShareBenefitPosModel* lastObject = self.dataSource.lastObject;
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
    return 1;self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 360;
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
    UIView* view = [[UIView alloc]init];
//    view.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    return view;
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FenRunDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBar forIndexPath:indexPath];
    if (!cell) {
        cell = [[FenRunDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierBar];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ShareBenefitPosModel* model = self.dataSource[indexPath.section];
    [cell reload:model];
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
