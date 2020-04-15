//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "MerchantAgentDetailVC.h"
#import "MerchantListCell.h"
#import "SSSearchBar.h"
#import "RFHeader.h"
static NSString* reuseIdentifierHeader = @"reuseIdentifierHeader";
static NSString* reuseIdentifierBar = @"reuseIdentifierBar";
@interface MerchantAgentDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation MerchantAgentDetailVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarTitle:@"优质商户"];
    self.dataSource = @[ @[@{@"title":@"基本资料"},@{@"title":@"SN码:\n商户姓名:\n手机号码:\n激活状态:",@"desc":@"00112233445566\n00112233445566\n00112233445566\n00112233445566"}],
                         
                         @[@{@"title":@"费率参数"},@{@"title":@"刷卡费率:\n云闪付费率:",@"desc":@"2.07%\n2.07%"}],
                         @[@{@"title":@"分润参数"},@{@"title":@"刷卡结算价:\n云闪付结算价:\n微信结算价:\n支付宝结算价",@"desc":@"2.07%\n2.07%\n2.07%\n2.07%"}]
                         ];
    
    AdjustTableBehavior(self.tableView);
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 44;
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        return 60;
    }
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
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
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierHeader];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifierHeader];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor whiteColor];
            RFHeader *header = [[RFHeader alloc]init];
            header.tag = 101;
            [cell.contentView addSubview:header];
            cell.backgroundColor = [UIColor clearColor];
            [header mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
            }];
        }
        RFHeader *tmp = [cell.contentView viewWithTag:101];
        NSArray* array = self.dataSource[indexPath.section];
        NSDictionary* dict = array[0];
        [tmp reloadColor:@"#1CCC9A" left:dict[@"title"] right:@""];
        return cell;
    }else if(indexPath.row == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBar];
        if(cell == nil) {
            cell = [[MerchantListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifierBar];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
        }
        MerchantListCell* tmp = (MerchantListCell*)cell;
        NSArray* array = self.dataSource[indexPath.section];
        NSDictionary* dict = array[1];
        [tmp reload:dict[@"title"] desc:dict[@"desc"]];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 0, 0));
        }];
    }
    return _tableView;
}

-(void)next:(id)sender{
    [MXRouter openURL:@"lcwl://AdjustRateVC"];
}

@end
