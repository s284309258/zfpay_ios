//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "WalletStudyVC.h"
#import "ImgTextTextView.h"
#import "NSObject+Home.h"
#import "MoneyLockerCollegeModel.h"
#import "QNManager.h"
@interface WalletStudyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *loginoutBnt;
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation WalletStudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
   
}

-(void)initUI{
    [self setNavBarTitle:@"钱柜学院"];
    self.dataSource = @[];
    [self.view addSubview:self.tableView];
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    [self getMoneyLockerCollegeList:@{} completion:^(id array, NSString *error) {
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        ImgTextTextView* view = [[ImgTextTextView alloc]init];
        view.desc.textColor = [UIColor moPlaceHolder];
        view.desc.font = [UIFont systemFontOfSize:13];
        [view isShowLine:YES];
        view.tag = 101;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view];
        cell.backgroundColor = [UIColor clearColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(10, 15, 10, 15));
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MXSeparatorLine*line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
        [cell.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(15);
            make.right.equalTo(cell.contentView).offset(-15);
            make.height.equalTo(@(1));
            make.bottom.equalTo(cell.contentView);
        }];
    }
    
    ImgTextTextView* view = [cell.contentView viewWithTag:101];
    MoneyLockerCollegeModel* model = self.dataSource[indexPath.row];
    NSString* url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,model.money_locker_cover];
    [view reloadLeft:url top:model.money_locker_title bottom:model.cre_datetime];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     MoneyLockerCollegeModel* model = self.dataSource[indexPath.row];
    [MXRouter openURL:@"lcwl://WalletStudyDetailVC" parameters:@{@"money_locker_id":model.money_locker_id}];
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
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

@end
