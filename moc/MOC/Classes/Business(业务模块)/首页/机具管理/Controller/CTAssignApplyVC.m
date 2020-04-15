//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "CTAssignApplyVC.h"
#import "TextTextImgView.h"
#import "PosAgentSliderVC.h"
#import "RefererAgencyModel.h"
#import "UIViewController+IIViewDeckAdditions.h"
#import "IIViewDeckController.h"
#import "CardSettleSliderVC.h"
#import "NSObject+Home.h"
#import "PosAllocationModel.h"
#import "TextSwitchView.h"

static NSString* selectIdentifier = @"select";
static NSString* openIdentifier = @"open";

@interface CTAssignApplyVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UIButton *submitBtn;

@property (strong, nonatomic) RefererAgencyModel *agency;

@property (strong, nonatomic) NSString *card_settle_price;

@property (strong, nonatomic) NSString *cash_back_rate;

@property (strong, nonatomic) NSString *cloud_settle_price;

@property (strong, nonatomic) NSString *single_profit_rate;

@property (strong, nonatomic) NSString *weixin_settle_price;

@property (strong, nonatomic) NSString *zhifubao_settle_price;
//商户封顶费
@property (strong, nonatomic) NSString *mer_cap_fee_price;

@property (strong, nonatomic) NSString *card_settle_price_vip;

@property (strong, nonatomic) NSString *fontTitle;


@property (nonatomic) BOOL isOpen;

@end

@implementation CTAssignApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self.type isEqualToString:@"CTPOS"]) {
        self.fontTitle = @"传统POS分配";
    }else if([self.type isEqualToString:@"EPOS"]) {
        self.fontTitle = @"EPOS分配";
    }
    self.isOpen = YES;
    self.dataSource = [[NSMutableArray alloc]initWithArray: @[@[
                                                                  @{@"title":@"代理伙伴",@"desc":@"请选择要分配的代理伙伴"},
                                                                  @{@"title":@"普通刷卡结算价",@"desc":@"请选择普通刷卡结算价"}, @{@"title":@"VIP刷卡结算价",@"desc":@"请选择VIP刷卡结算价"},
                                                                  @{@"title":@"云闪付结算价",@"desc":@"请选择云闪付结算价"},
                                                                  @{@"title":@"微信结算价",@"desc":@"请选择微信结算价"},
                                                                  @{@"title":@"支付宝结算价",@"desc":@"请选择支付宝结算价"},
                                                                  @{@"title":@"交易量达标返现领取",@"desc":@""}
                                                                  ],
                                                              @[
                                                                  @{@"title":@"单笔分润",@"desc":@"请选择单笔分润比例"},
                                                                  @{@"title":@"机器返现",@"desc":@"请选择机器返现比例"},
                                                                  @{@"title":@"储蓄卡封顶结算价",@"desc":@"请选择储蓄卡封顶结算价"}
                                                                  ]
                                                              
                                                              
                                                              ]];
    [self.view addSubview:self.tableView];
    AdjustTableBehavior(self.tableView);
    [self setupData];
}

-(void)setupData{
    NSMutableDictionary* param = [NSMutableDictionary new];
    PosAllocationModel* model = self.dataArray[0];
    [param setObject:model.sn forKey:@"sn"];
    if ([self.type isEqualToString:@"EPOS"]) {
        [param setObject:@"epos" forKey:@"pos_type"];
    }
    [self getTraditionalPosSysParamRateList:param completion:^(id array, NSString *error) {
    if ([StringUtil isEmpty:error] || [error isEqualToString:@"0"]) {
        self.dataSource = [[NSMutableArray alloc]initWithArray: @[@[
                                            @{@"title":@"代理伙伴",@"desc":@"请选择要分配的代理伙伴"},
                                            @{@"title":@"普通刷卡结算价",@"desc":@"请选择普通刷卡结算价"}, @{@"title":@"VIP刷卡结算价",@"desc":@"请选择VIP刷卡结算价"},
                                            @{@"title":@"云闪付结算价",@"desc":@"请选择云闪付结算价"},
                                            @{@"title":@"微信结算价",@"desc":@"请选择微信结算价"},
                                            @{@"title":@"支付宝结算价",@"desc":@"请选择支付宝结算价"}
                                            ],
                                        @[
                                            @{@"title":@"单笔分润",@"desc":@"请选择单笔分润比例"},
                                            @{@"title":@"机器返现",@"desc":@"请选择机器返现比例"},
                                            @{@"title":@"储蓄卡封顶结算价",@"desc":@"请选择储蓄卡封顶结算价"}
                                            ]
                                        ]];
        if ([error isEqualToString:@"0"]) {
            self.isOpen = NO;
        }else{
            self.isOpen = YES;
        }

        [self.tableView reloadData];
    }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray* data = self.dataSource[section];
    return data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}
//TextSwitchView
#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 && indexPath.row == 6){
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:openIdentifier];
        TextSwitchView* view = [cell.contentView viewWithTag:101];
        if (!view) {
            view = [[TextSwitchView alloc]init];
            [view setLeftPadding:0];
            view.tag = 101;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:view];
            cell.backgroundColor = [UIColor clearColor];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            view.block = ^(id data) {
                BOOL open = [data boolValue];
                self.isOpen = open;
                [self.tableView reloadData];
            };
        }
        [view.btn setOn:self.isOpen];
        return cell;
    }
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:selectIdentifier];
    TextTextImgView* view = [cell.contentView viewWithTag:101];
    if (!view) {
        view = [[TextTextImgView alloc]init];
        view.desc.textAlignment = NSTextAlignmentRight;
        view.tag = 101;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view];
        cell.backgroundColor = [UIColor clearColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary* dict = self.dataSource[indexPath.section][indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSString* agent = self.agency.real_name;
        if (![StringUtil isEmpty:agent]) {
            agent = [NSString stringWithFormat:@"%@",agent];
            [view reloadImg:@"选择" title:dict[@"title"] desc:agent];
        }else{
            [view reloadImg:@"选择" title:dict[@"title"] desc:dict[@"desc"]];
        }
    }else if(indexPath.section == 0 && indexPath.row == 1){
        NSString* agent = self.card_settle_price;
        if (![StringUtil isEmpty:agent]) {
            agent = [NSString stringWithFormat:@"%@%%",agent];
            [view reloadImg:@"选择" title:dict[@"title"] desc:agent];
        }else{
            [view reloadImg:@"选择" title:dict[@"title"] desc:dict[@"desc"]];
        }
        
    }else if(indexPath.section == 0 && indexPath.row == 2){
        NSString* agent = self.card_settle_price_vip;
        if (![StringUtil isEmpty:agent]) {
            agent = [NSString stringWithFormat:@"%@%%",agent];
            [view reloadImg:@"选择" title:dict[@"title"] desc:agent];
        }else{
            [view reloadImg:@"选择" title:dict[@"title"] desc:dict[@"desc"]];
        }
        
    }else if(indexPath.section == 0 && indexPath.row == 3){
        NSString* agent = self.cloud_settle_price;
        if (![StringUtil isEmpty:agent]) {
            agent = [NSString stringWithFormat:@"%@%%",agent];
            [view reloadImg:@"选择" title:dict[@"title"] desc:agent];
        }else{
            [view reloadImg:@"选择" title:dict[@"title"] desc:dict[@"desc"]];
        }
        
    }else if(indexPath.section == 0 && indexPath.row == 4){
        NSString* agent = self.weixin_settle_price;
        if (![StringUtil isEmpty:agent]) {
            agent = [NSString stringWithFormat:@"%@%%",agent];
            [view reloadImg:@"选择" title:dict[@"title"] desc:agent];
        }else{
            [view reloadImg:@"选择" title:dict[@"title"] desc:dict[@"desc"]];
        }
        
    }else if(indexPath.section == 0 && indexPath.row == 5){
        NSString* agent = self.zhifubao_settle_price;
        if (![StringUtil isEmpty:agent]) {
            agent = [NSString stringWithFormat:@"%@%%",agent];
            [view reloadImg:@"选择" title:dict[@"title"] desc:agent];
        }else{
            [view reloadImg:@"选择" title:dict[@"title"] desc:dict[@"desc"]];
        }
        
    }else if(indexPath.section == 1 && indexPath.row == 0){
        NSString* agent = self.single_profit_rate;
        if (![StringUtil isEmpty:agent]) {
            agent = [NSString stringWithFormat:@"%@%%",agent];
            [view reloadImg:@"选择" title:dict[@"title"] desc:agent];
        }else{
            [view reloadImg:@"选择" title:dict[@"title"] desc:dict[@"desc"]];
        }
        
    }else if(indexPath.section == 1 && indexPath.row == 1){
        NSString* agent = self.cash_back_rate;
        if (![StringUtil isEmpty:agent]) {
            agent = [NSString stringWithFormat:@"%@%%",agent];
            [view reloadImg:@"选择" title:dict[@"title"] desc:agent];
        }else{
            [view reloadImg:@"选择" title:dict[@"title"] desc:dict[@"desc"]];
        }
        
    }else if(indexPath.section == 1 && indexPath.row == 2){
        NSString* agent = self.mer_cap_fee_price;
        if (![StringUtil isEmpty:agent]) {
            [view reloadImg:@"选择" title:dict[@"title"] desc:agent];
        }else{
            [view reloadImg:@"选择" title:dict[@"title"] desc:dict[@"desc"]];
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PosAllocationModel* model = self.dataArray[0];
    NSString* snId = model.sn;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            PosAgentSliderVC* slider = [[PosAgentSliderVC alloc]init];
            slider.fontTitle = self.fontTitle;
            slider.block = ^(id data) {
                RefererAgencyModel* tmp = data;
                self.agency = tmp;
                [self.tableView reloadData];
            };
            [self.viewDeckController setRightViewController:slider];
            [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
            
        }else if(indexPath.row == 1){
            CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
            slider.type = self.type;
            slider.subType = @"card_settle_price";
            slider.sn = snId;
            slider.block = ^(id data) {
                self.card_settle_price = data;
                [self.tableView reloadData];
            };
            [self.viewDeckController setRightViewController:slider];
            [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
            
        }else if(indexPath.row == 2){
            CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
            slider.type = self.type;
            slider.subType = @"card_settle_price_vip";
            slider.sn = snId;
            slider.block = ^(id data) {
                self.card_settle_price_vip = data;
                [self.tableView reloadData];
            };
            [self.viewDeckController setRightViewController:slider];
            [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
            
        }else if(indexPath.row == 3){
            CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
            slider.type = self.type;
            slider.subType = @"cloud_settle_price";
            slider.sn = snId;
            slider.block = ^(id data) {
                self.cloud_settle_price = data;
                [self.tableView reloadData];
            };
            [self.viewDeckController setRightViewController:slider];
            [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
        }else if(indexPath.row == 4){
            CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
            slider.type = self.type;
            slider.subType = @"weixin_settle_price";
            slider.sn = snId;
            slider.block = ^(id data) {
                self.weixin_settle_price = data;
                [self.tableView reloadData];
            };
            [self.viewDeckController setRightViewController:slider];
            [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
        }else if(indexPath.row == 5){
            CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
            slider.type = self.type;
            slider.subType = @"zhifubao_settle_price";
            slider.sn = snId;
            slider.block = ^(id data) {
                self.zhifubao_settle_price = data;
                [self.tableView reloadData];
            };
            [self.viewDeckController setRightViewController:slider];
            [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
            slider.type = self.type;
            slider.subType = @"single_profit_rate";
            slider.sn = snId;
            slider.block = ^(id data) {
                self.single_profit_rate = data;
                [self.tableView reloadData];
            };
            [self.viewDeckController setRightViewController:slider];
            [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
        }else if(indexPath.row == 1){
            CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
            slider.type = self.type;
            slider.subType = @"cash_back_rate";
            slider.sn = snId;
            slider.block = ^(id data) {
                self.cash_back_rate = data;
                [self.tableView reloadData];
            };
            [self.viewDeckController setRightViewController:slider];
            [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
        }else if(indexPath.row == 2){
            CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
            slider.type = self.type;
            slider.subType = @"mer_cap_fee_list";
            slider.sn = snId;
            slider.block = ^(id data) {
                self.mer_cap_fee_price = data;
                [self.tableView reloadData];
            };
            [self.viewDeckController setRightViewController:slider];
            [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
        }
    }
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:selectIdentifier];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:openIdentifier];
        [self.view addSubview:_tableView];
        UIView* footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        [footer addSubview:self.submitBtn];
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(SCREEN_WIDTH-30));
            make.height.equalTo(@(44));
            make.centerX.equalTo(footer);
            make.centerY.equalTo(footer);
        }];
        _tableView.tableFooterView = footer;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 0, 0));
        }];
    }
    return _tableView;
}

-(UIButton*)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setBackgroundColor:[UIColor darkGreen]];
        [_submitBtn setTitle:@"确定分配" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        [_submitBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(void)next:(id)sender{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"mer_cap_fee":self.mer_cap_fee_price,@"acce_user_id":self.agency.user_id,@"card_settle_price":self.card_settle_price,@"card_settle_price_vip":self.card_settle_price_vip,@"cash_back_rate":self.cash_back_rate,@"cloud_settle_price":self.cloud_settle_price,@"single_profit_rate":self.single_profit_rate,@"weixin_settle_price":self.weixin_settle_price,@"zhifubao_settle_price":self.zhifubao_settle_price,@"sn_list":[self getPosStr:self.dataArray],@"is_reward":self.isOpen?@"1":@"0"}];
    if ([self.type isEqualToString:@"EPOS"]) {
        [param setObject:@"epos" forKey:@"pos_type"];
    }else {
        [param setObject:@"TraditionalPOS" forKey:@"pos_type"];
    }
    [self allocationTraditionalPos:param completion:^(BOOL success, NSString *error) {
        if (success) {
            if (self.block) {
                self.block(nil);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

-(NSString*)getPosStr:(NSArray*)array{
    NSArray *unionOfObjects = [array valueForKeyPath:@"@unionOfObjects.sn"];
    return [unionOfObjects componentsJoinedByString:@","];
}
@end
