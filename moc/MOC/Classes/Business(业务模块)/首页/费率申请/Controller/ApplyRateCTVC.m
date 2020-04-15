//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "ApplyRateCTVC.h"
#import "SearchRegionView.h"
#import "RFHeader.h"
#import "ApplyRateCell.h"
#import "NSObject+Home.h"
#import "ApplyRateModel.h"
#import "IIViewDeckController.h"
#import "AdjustRateVC.h"
@interface ApplyRateCTVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSMutableArray *headerData;

@property (strong, nonatomic) UIButton *bottomBtn;

@property (strong, nonatomic) NSString *start_number;

@property (strong, nonatomic) NSString *end_number;

@property (strong, nonatomic) NSMutableArray* selectArray;

@property  (nonatomic) BOOL isSelect;
@property (strong , nonatomic) IIViewDeckController *viewDeckController;
@end

@implementation ApplyRateCTVC   
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    
}

-(void)initUI{
    self.selectArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.headerData = @[@{@"color":@"#01C088",@"left":@"搜索范围",@"right":@""},
                        @{@"color":@"#01C088",@"left":@"搜索结果",@"right":@"全选"}];
    self.dataSource = [[NSMutableArray alloc]initWithCapacity:10];
    
    AdjustTableBehavior(self.tableView);
    [self bottomBtn];
}

-(void)initData{
//    [self getApplyRateTraditionalPosList:@{} completion:^(id array, NSString *error) {
//
//    }];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 40;
    }
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
            if(cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell0"];
                SearchRegionView* view = [[SearchRegionView alloc]init];
                view.block = ^(id data) {
                    NSArray* tmp = data;
                    self.start_number = tmp[0];
                    self.end_number = tmp[1];
                    self.isSelect = NO;
                    [self requestAllocationList];
                };
                view.tag = 101;
                cell.contentView.backgroundColor = [UIColor whiteColor];
                [cell.contentView addSubview:view];
                cell.backgroundColor = [UIColor whiteColor];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
                }];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return cell;
            }
        case 1:{
            ApplyRateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if(cell == nil) {
                cell = [[ApplyRateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            ApplyRateModel* model = self.dataSource[indexPath.row];
            BOOL isSelected = NO;
            if ([self.selectArray containsObject:model]) {
                isSelected = YES;
            }
            [cell reload:model select:isSelected type:self.type];
            return cell;
        }
        default:
            break;
    }
  return  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"other"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.dataSource.count) {
        return;
    }
    ApplyRateModel* model = self.dataSource[indexPath.row];
    BOOL bol  = [self.selectArray containsObject:model];
    //是否存在
    if (bol) {
        [self.selectArray removeObject:model];
    }else{
        [self.selectArray addObject:model];
    }
    [self.tableView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    __block UIView* headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    headerView.backgroundColor = [UIColor whiteColor];
    RFHeader *header = [[RFHeader alloc]init];
    header.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headerView);
        make.left.equalTo(headerView).offset(15);
        make.right.equalTo(headerView).offset(-15);
    }];
    NSDictionary* dict =  self.headerData[section];
    if (section == 1) {
        [header reloadColor:dict[@"color"] left:dict[@"left"] rightImg:self.isSelect?@"勾选":@"None" rightText:[NSString stringWithFormat:@"全选(%d)",self.selectArray.count]];
        header.block = ^(id data) {
            self.isSelect = !self.isSelect;
            [self.selectArray removeAllObjects];
            if (self.isSelect) {
                [self.selectArray addObjectsFromArray:self.dataSource];
            }
            [self.tableView reloadData];
        };
    }else{
        [header reloadColor:dict[@"color"] left:dict[@"left"] right:dict[@"right"]];
    }
    return headerView;
    
//    NSDictionary* dict =  self.headerData[section];
//    [header reloadColor:dict[@"color"] left:dict[@"left"] right:dict[@"right"]];
//    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

-(UIButton*)bottomBtn{
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_bottomBtn setBackgroundColor:[UIColor darkGreen]];
        _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:_bottomBtn];
        [_bottomBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.equalTo(@(44));
        }];
    }
    return _bottomBtn;
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
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 44, 0));
        }];
    }
    return _tableView;
}

-(void)next:(id)sender{
    if (self.selectArray.count == 0) {
        [NotifyHelper showMessageWithMakeText:@"请选择机器"];
        return;
    }
    AdjustRateVC* vc = [[AdjustRateVC alloc]init];
    vc.type = self.type;
    vc.sn_list = [self getPosStr:self.selectArray];
    self.viewDeckController = [[IIViewDeckController alloc] initWithCenterViewController:vc rightViewController:nil];
    self.viewDeckController.title = @"调整费率";
    UIButton    * customBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [customBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [customBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    customBtn.enabled = NO;
    [customBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:customBtn];
    self.viewDeckController.navigationItem.leftBarButtonItem = barItem ;
    //添加完成btn
    [self.navigationController pushViewController:self.viewDeckController animated:YES];
    return;
    
}

-(NSString*)getPosStr:(NSArray*)array{
    NSArray *unionOfObjects = [array valueForKeyPath:@"@unionOfObjects.sn"];
    return [unionOfObjects componentsJoinedByString:@","];
}

-(void)requestAllocationList{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"start_number":self.start_number,@"end_number":self.end_number}];
    if ([self.type isEqualToString:@"EPOS"]) {
        [param setObject:@"epos" forKey:@"pos_type"];
    }
    [self getApplyRateTraditionalPosList:param completion:^(id array, NSString *error) {
        if (array) {
            [self.selectArray removeAllObjects];
            self.dataSource = array;
            [self.tableView reloadData];
        }
    }];
}
@end
