//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "PosInputInquiryCheckDetailVC.h"
#import "MerchantListCell.h"
#import "SSSearchBar.h"
#import "RFHeader.h"
#import "NSObject+Home.h"
#import "PosInstallDetailModel.h"
#import "ZFMerchantManager.h"
#import "NSObject+Home.h"
static NSString* reuseIdentifierHeader = @"reuseIdentifierHeader";
static NSString* reuseIdentifierBar = @"reuseIdentifierBar";
static NSString* reuseIdentifierList = @"reuseIdentifierList";
@interface PosInputInquiryCheckDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) PosInstallDetailModel *posModel;

@end

@implementation PosInputInquiryCheckDetailVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavBarTitle:@"详情"];
    self.dataSource = @[];
    
    AdjustTableBehavior(self.tableView);
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initData{
    self.dataSource = @[];
    [self getTraditionalPosInstallDetail:@{@"install_id":self.model.install_id} completion:^(id object, NSString *error) {
        if (object) {
            self.posModel = object;
            
            [self.tableView reloadData];
        }
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.posModel) {
        return 4;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 2) {
        return 1;
    }else if(section == 1){
        return 6;
    }
    return self.posModel.terminalList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 2) {
        return 30;
    }else if(indexPath.section == 3){
        return 130;
    }
    
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 10;
    }
    return 0.01;
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
    if (indexPath.section == 0 || indexPath.section == 2) {
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
        if (indexPath.section == 0) {
            [tmp reloadColor:@"#1CCC9A" left:@"基本资料"right:@""];
        }else if(indexPath.section == 2){
            [tmp reloadColor:@"#1CCC9A" left:@"终端列表"right:@""];
        }
        return cell;
    }else if(indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBar];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifierBar];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor whiteColor];
            cell.detailTextLabel.numberOfLines = 0;
            cell.textLabel.font = [UIFont font14];
            cell.textLabel.textColor = [UIColor moPlaceHolder];
            cell.detailTextLabel.font = [UIFont font14];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"商户名称:";
            cell.detailTextLabel.text = self.posModel.merchant_name;
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"审核状态:";
            cell.detailTextLabel.text = [self.posModel.biz_code isEqualToString:@"00"]?@"审核成功":@"审核失败";
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"商户编号:";
            cell.detailTextLabel.text = [StringUtil isEmpty:self.posModel.mer_code]?@"--":[NSString stringWithFormat:@"%@",self.posModel.mer_code];
        }else if(indexPath.row == 3){
            cell.textLabel.text = @"代理账号:";
            cell.detailTextLabel.text = [StringUtil isEmpty:self.posModel.agent_id]?@"--":[NSString stringWithFormat:@"%@",self.posModel.agent_id];
        }else if(indexPath.row == 4){
            cell.textLabel.text = @"到账标识:";
            cell.detailTextLabel.text = [StringUtil isEmpty:self.posModel.settle_flag]?@"--":[NSString stringWithFormat:@"%@到账",self.posModel.settle_flag];
        }else if(indexPath.row == 5){
            cell.textLabel.text = @"审核时间:";
            cell.detailTextLabel.text = self.posModel.cre_datetime;
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierList];
        if(cell == nil) {
            cell = [[MerchantListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifierList];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
        }
        MerchantListCell* tmp = (MerchantListCell*)cell;
        NSDictionary* dict =  self.posModel.terminalList[indexPath.row];
        NSString* title = @"终端号:\n机具编号:\nSIM卡号:\n携机入网:";
        
        NSString* desc = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",[StringUtil isEmpty:dict[@"terminal"]]?@"--":dict[@"terminal"],[StringUtil isEmpty:dict[@"machine_id"]]?@"--":dict[@"machine_id"],[StringUtil isEmpty:dict[@"sim_card"]]?@"--":dict[@"sim_card"],[StringUtil isEmpty:dict[@"is_take_machi"]]?@"--":[dict[@"is_take_machi"] isEqualToString:@"0"]?@"中付机":@"携机入网"];
        [tmp reload:title desc:desc];
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

@end
