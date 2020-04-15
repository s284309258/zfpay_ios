//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "CTMerchantVC.h"
#import "MerchantCell.h"
#import "NSObject+Home.h"
static NSString* reuseIdentifierBar = @"reuseIdentifierBar";
@interface CTMerchantVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSDictionary *summaryDict;


@end

@implementation CTMerchantVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
   
}

-(void)initUI{
    self.dataSource = @[];
    [self.view addSubview:self.tableView];
    AdjustTableBehavior(self.tableView);
    [self.tableView registerClass:[MerchantCell class] forCellReuseIdentifier:reuseIdentifierBar];
}

-(void)initData{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{}];
    if ([self.type isEqualToString:@"EPOS"]) {
        [param setObject:@"epos" forKey:@"pos_type"];
    }
    [self getSummaryTraditionalPosList:param completion:^(id dict, NSString *error) {
        if (dict) {
            self.summaryDict = dict;
            self.dataSource = [[NSMutableArray alloc]initWithArray:@[
                @{@"image":@"全部商户",@"title":Lang(@"全部商户"),@"desc":Lang(@"发展的所有商户"),@"right":self.summaryDict[@"all_merchant"],@"vc":@"lcwl://CTMerchantListVC",@"merchantType":@"QBSH"},
             @{@"image":@"优质商户",@"title":Lang(@"优质商户"),@"desc":Lang(@"本月交易金额>=50000元"),@"right":self.summaryDict[@"excellent_merchant"],@"vc":@"lcwl://CTMerchantListVC",@"merchantType":@"YZSH"},
                 @{@"image":@"活跃商户",@"title":Lang(@"活跃商户"),@"desc":Lang(@"近30天交易笔数≥2笔 并 交易金额≥10元"),@"right":self.summaryDict[@"active_merchant"],@"vc":@"lcwl://CTMerchantListVC",@"merchantType":@"HYSH"},
            @{@"image":@"休眠商户",@"title":Lang(@"休眠商户"),@"desc":Lang(@"入网>=60天,连续无交易>60天"),@"right":self.summaryDict[@"dormant_merchant"],@"vc":@"lcwl://CTMerchantListVC",@"merchantType":@"XMSH"},
             @{@"image":@"达标商户",@"title":Lang(@"交易达标商户"),@"desc":Lang(@""),@"right":self.summaryDict[@"standard_merchant"],@"vc":@"lcwl://CTStandardMerchantVC"}
                                                                         ]];
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
    return 70;
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
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBar forIndexPath:indexPath];
    if (!cell) {
        cell = [[MerchantCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierBar];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary* dict = self.dataSource[indexPath.row];
    MerchantCell* tmp = (MerchantCell*)cell;
    [tmp reload:dict[@"image"] top:dict[@"title"] bottom:dict[@"desc"] right:dict[@"right"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* dict = self.dataSource[indexPath.row];
    NSString* vcString = dict[@"vc"];
    if (![StringUtil isEmpty:vcString]) {
        if ([vcString isEqualToString:@"lcwl://CTStandardMerchantVC"]) {
            if ([self.type isEqualToString:@"EPOS"]) {
                [MXRouter openURL:vcString parameters:@{@"pos_type":@"03"}];
            }else{
                [MXRouter openURL:vcString parameters:@{@"pos_type":@"01"}];
            }
            return;
        }
        [MXRouter openURL:vcString parameters:@{@"merchantType":dict[@"merchantType"],@"naviTitle":dict[@"title"],@"type":self.type}];
    }
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 0, 0));
        }];
    }
    return _tableView;
}


@end
