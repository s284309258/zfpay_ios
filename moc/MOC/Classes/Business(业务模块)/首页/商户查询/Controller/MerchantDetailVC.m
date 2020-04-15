//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "MerchantDetailVC.h"
#import "MerchantListCell.h"
#import "SSSearchBar.h"
#import "RFHeader.h"
#import "NSObject+Home.h"
#import "PosDetailModel.h"
static NSString* reuseIdentifierHeader = @"reuseIdentifierHeader";
static NSString* reuseIdentifierBar = @"reuseIdentifierBar";
@interface MerchantDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataSource;

@property (strong, nonatomic) PosDetailModel *posModel;



@end

@implementation MerchantDetailVC
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
    if ([self.type isEqualToString:@"CTPOS"]) {
        NSMutableDictionary* param = [[NSMutableDictionary alloc]initWithDictionary:@{@"sn":self.sn}];
        [self getTraditionalPosDetail:param completion:^(id array, NSString *error) {
            if (array) {
                self.posModel = array;
                
                NSString* basic = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@",
                                   self.posModel.sn,
                                   [StringUtil isEmpty:self.posModel.mer_name]?@"--":self.posModel.mer_name,
                                   [StringUtil isEmpty:self.posModel.mer_id]?@"--":self.posModel.mer_id,
                                   [StringUtil isEmpty:self.posModel.name]?@"--":self.posModel.name,
                                   [StringUtil isEmpty:self.posModel.tel]?@"--":self.posModel.tel,
                                   ([self.posModel.act_status isEqualToString:@"0"]?@"未激活":@"已激活"),
                                   [StringUtil isEmpty:self.posModel.act_date]?@"--":self.posModel.act_date,
                                   [self.posModel.cash_back_status isEqualToString:@"1"]?@"已返现":@"未返现",
                                   self.posModel.num,self.posModel.performance,
                                   [StringUtil isEmpty:self.posModel.expire_day]?@"--":self.posModel.expire_day];
                NSString* rate = [NSString stringWithFormat:@"%@%%\n%@%%\n%@%%\n%@%%",
                                  self.posModel.credit_card_rate,
                                  self.posModel.cloud_flash_rate,
                                  self.posModel.weixin_rate,
                                  self.posModel.zhifubao_rate];
                NSString* fenrun = [NSString stringWithFormat:@"%@%%\n%@%%\n%@%%\n%@%%\n%@%%\n%@%%\n%@%%\n%@",
                                    self.posModel.card_settle_price,
                                    self.posModel.card_settle_price_vip,
                                    self.posModel.cloud_settle_price,
                                    self.posModel.weixin_settle_price,
                                    self.posModel.zhifubao_settle_price,
                                    self.posModel.single_profit_rate,
                                    self.posModel.cash_back_rate,
                                    self.posModel.mer_cap_fee];
                NSString* policy_name = self.posModel.policy_name;
                policy_name = [policy_name stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
                self.dataSource = @[ @[@{@"title":@"基本资料"},@{@"title":@"SN码:\n商户名称:\n商户号:\n客户名:\n联系电话:\n激活状态:\n激活时间:\n返现状态:\n交易笔数:\n交易金额:\n激活剩余天数:",@"desc":basic},@{@"title":@"政策",@"desc":policy_name?:@"--"}],
                                     
                                     @[@{@"title":@"费率参数"},@{@"title":@"刷卡费率:\n云闪付费率:\n微信费率:\n支付宝费率:",@"desc":rate},
                                     ],
                                     @[@{@"title":@"分润参数"},@{@"title":@"普通刷卡结算价:\nVIP刷卡结算价:\n云闪付结算价:\n微信结算价:\n支付宝结算价\n单笔分润比例:\n机器返现比例:\n储蓄卡封顶结算价:",@"desc":fenrun}]
                                     ];
                [self.tableView reloadData];
            }
        }];
    }else if([self.type isEqualToString:@"EPOS"]){
        [self getTraditionalPosDetail:@{@"sn":self.sn,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
            if (array) {
                self.posModel = array;
                
                NSString* basic = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@",
                                   self.posModel.sn,
                                   [StringUtil isEmpty:self.posModel.mer_name]?@"--":self.posModel.mer_name,
                                   [StringUtil isEmpty:self.posModel.mer_id]?@"--":self.posModel.mer_id,
                                   [StringUtil isEmpty:self.posModel.name]?@"--":self.posModel.name,
                                   [StringUtil isEmpty:self.posModel.tel]?@"--":self.posModel.tel,
                                   ([self.posModel.act_status isEqualToString:@"0"]?@"未激活":@"已激活"),
                                   [StringUtil isEmpty:self.posModel.act_date]?@"--":self.posModel.act_date,
                                   [self.posModel.cash_back_status isEqualToString:@"1"]?@"已返现":@"未返现",
                                   self.posModel.num,self.posModel.performance,
                                   [StringUtil isEmpty:self.posModel.expire_day]?@"--":self.posModel.expire_day];
                NSString* rate = [NSString stringWithFormat:@"%@%%\n%@%%\n%@%%\n%@%%",
                                  self.posModel.credit_card_rate,
                                  self.posModel.cloud_flash_rate,
                                  self.posModel.weixin_rate,
                                  self.posModel.zhifubao_rate];
                NSString* fenrun = [NSString stringWithFormat:@"%@%%\n%@%%\n%@%%\n%@%%\n%@%%\n%@%%\n%@%%\n%@",
                                    self.posModel.card_settle_price,
                                    self.posModel.card_settle_price_vip,
                                    self.posModel.cloud_settle_price,
                                    self.posModel.weixin_settle_price,
                                    self.posModel.zhifubao_settle_price,
                                    self.posModel.single_profit_rate,
                                    self.posModel.cash_back_rate,
                                    self.posModel.mer_cap_fee];
                NSString* policy_name = self.posModel.policy_name;
                policy_name = [policy_name stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
                self.dataSource = @[ @[@{@"title":@"基本资料"},@{@"title":@"SN码:\n商户名称:\n商户号:\n客户名:\n联系电话:\n激活状态:\n激活时间:\n返现状态:\n交易笔数:\n交易金额:\n激活剩余天数:",@"desc":basic},@{@"title":@"政策",@"desc":policy_name?:@"--"}],
                                     
                                     @[@{@"title":@"费率参数"},@{@"title":@"刷卡费率:\n云闪付费率:\n微信费率:\n支付宝费率:",@"desc":rate},
                                     ],
                                     @[@{@"title":@"分润参数"},@{@"title":@"普通刷卡结算价:\nVIP刷卡结算价:\n云闪付结算价:\n微信结算价:\n支付宝结算价\n单笔分润比例:\n机器返现比例:\n储蓄卡封顶结算价:",@"desc":fenrun}]
                                     ];
                [self.tableView reloadData];
            }
        }];
    }else{
        [self getMposDetail:@{@"sn":self.sn} completion:^(id array, NSString *error) {
            if (array) {
                self.posModel = array;
                NSString* policy_name = self.posModel.policy_name;
                policy_name = [policy_name stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
                NSString* basic = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@",
                                   self.posModel.sn,
                                   [StringUtil isEmpty:self.posModel.name]?@"--":self.posModel.name,
                                   [StringUtil isEmpty:self.posModel.tel]?@"--":self.posModel.tel,
                                   ([self.posModel.act_status isEqualToString:@"0"]?@"未激活":@"已激活"),
                                   [StringUtil isEmpty:self.posModel.act_date]?@"--":self.posModel.act_date,
                                   [self.posModel.cash_back_status isEqualToString:@"1"]?@"已返现":@"未返现",
                                   self.posModel.num,
                                   self.posModel.performance,
                                   [StringUtil isEmpty:self.posModel.expire_day]?@"--":self.posModel.expire_day];
                NSString* rate = [NSString stringWithFormat:@"%@%%\n%@%%\n%@\n%@",
                                  self.posModel.credit_card_rate,
                                  self.posModel.cloud_flash_rate,
                                  @"--",@"--"];
                NSString* fenrun = [NSString stringWithFormat:@"%@%%\n%@%%\n%@\n%@\n%@%%\n%@%%\n%@",
                                    self.posModel.card_settle_price,
                                    self.posModel.cloud_settle_price,
                                    @"--",
                                    @"--",
                                    self.posModel.single_profit_rate,
                                    self.posModel.cash_back_rate,
                                    [StringUtil isEmpty:self.posModel.mer_cap_fee]?@"--":self.posModel.mer_cap_fee];
                self.dataSource = @[ @[@{@"title":@"基本资料"},@{@"title":@"SN码:\n商户姓名:\n手机号码:\n激活状态:\n激活时间:\n返现状态:\n交易笔数:\n交易金额:\n激活剩余天数:",@"desc":basic},@{@"title":@"政策",@"desc":policy_name?:@"--"}],
                                         
                                         @[@{@"title":@"费率参数"},@{@"title":@"刷卡费率:\n云闪付费率:\n微信费率:\n支付宝费率:",@"desc":rate},
                                         ],
                                         @[@{@"title":@"分润参数"},@{@"title":@"普通刷卡结算价:\n云闪付结算价:\n微信结算价:\n支付宝结算价\n单笔分润比例:\n机器返现比例:\n储蓄卡封顶结算价:",@"desc":fenrun}]
                                         ];
                [self.tableView reloadData];
            }
        }];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray* dataArray = self.dataSource[section];
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 44;
    }else if(indexPath.section == 0){
        if (indexPath.row == 1) {

            if ([self.type isEqualToString:@"CTPOS"]||[self.type isEqualToString:@"EPOS"]) {
                return 240;
            }else{
                return 200;
            }
        }else{
           
            NSString* policy_name = self.posModel.policy_name;
            policy_name = [policy_name stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
            policy_name = policy_name?:@"--";
            NSMutableAttributedString* attrTitle = [[NSMutableAttributedString alloc]initWithString:policy_name];
            [attrTitle addFont:[UIFont font15] substring:policy_name];
               NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
               [paragraphStyle setLineSpacing:5];
               [paragraphStyle setAlignment:NSTextAlignmentLeft];
               [attrTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attrTitle.length)];
            CGSize attSize = [attrTitle boundingRectWithSize:CGSizeMake(SCREEN_WIDTH/2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
            return attSize.height+15;
        }
    }else if(indexPath.section == 1){
        return 90;
    }
    return 180;
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
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBar];
        if(cell == nil) {
            cell = [[MerchantListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifierBar];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
        }
        MerchantListCell* tmp = (MerchantListCell*)cell;
        NSArray* array = self.dataSource[indexPath.section];
        NSDictionary* dict = array[indexPath.row];
        [tmp reload:dict[@"title"] desc:dict[@"desc"]];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        [MXRouter openURL:@"lcwl://MerchantTradeDetailVC" parameters:@{@"sn":self.posModel.sn}];
        
    }
}


- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
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
