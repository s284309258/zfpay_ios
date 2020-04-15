//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "LLKRecallRefuseVC.h"
#import "TextTextTextView.h"
#import "NSObject+Home.h"
#import "ScanTraditionalPosModel.h"
@interface LLKRecallRefuseVC ()<UITableViewDelegate,UITableViewDataSource>

//@property (strong, nonatomic) UITableView *tableView;
//
//@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation LLKRecallRefuseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self initUI];
    //    [self initData];
}
//
//-(void)initUI{
//    self.dataSource = [[NSMutableArray alloc]initWithCapacity:10];
//    [self tableView];
//    AdjustTableBehavior(self.tableView);
//}
-(void)initData{
    [self getRecallTrafficCardList:@{@"status":@"08"} completion:^(id array, NSString *error) {
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
        }
    }];
}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}
//
//#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataSource.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 65;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.01;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 10;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    return [[UIView alloc]init];
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return [[UIView alloc]init];
//}
//
#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        TextTextTextView* view = [[TextTextTextView alloc]init];
        view.tag = 101;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view];
        cell.backgroundColor = [UIColor clearColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    TextTextTextView* view = [cell.contentView viewWithTag:101];
    ScanTraditionalPosModel* model = self.dataSource[indexPath.row];
    
    [view reloadTop: [NSString stringWithFormat:@"SN码:%@",model.card_no] bottom:model.cre_datetime right:@"已拒绝"];
    return cell;
}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}
//
//- (UITableView*)tableView{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.backgroundColor = [UIColor clearColor];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [self.view addSubview:_tableView];
//        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 55, 0));
//        }];
//    }
//    return _tableView;
//}

@end
