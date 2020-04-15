//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "AssignUpdateVC.h"
#import "TextTextImgView.h"
#import "AllocationPosDetailModel.h"
#import "NSObject+Home.h"
#import "CardSettleSliderVC.h"
#import "IIViewDeckController.h"
#import "UIViewController+IIViewDeckAdditions.h"
#import "RFHeader.h"
#import "TextSwitchView.h"
static NSString* selectIdentifier = @"select";
static NSString* openIdentifier = @"open";

@interface AssignUpdateVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UIButton *submitBtn;

@property (strong, nonatomic) AllocationPosDetailModel *posDetailModel;
        
@property (strong, nonatomic) RFHeader *section2;

@property (nonatomic) BOOL isSelect;

@property (strong, nonatomic) NSArray* snsArray;

@end

@implementation AssignUpdateVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarTitle:@"分配修改" ];
    self.snsArray = @[];
    self.dataSource = [NSMutableArray arrayWithCapacity:10];
    if (self.type == MAssigType) {
        
        [self selectPosSettlePriceBySN:@{@"sn":self.batchModel.max_sn,@"user_id":self.batchModel.user_id,@"pos_type":@"MPOS",@"batch_no":self.batchModel.batch_no} completion:^(id object, NSString *error) {
            if (object) {
                self.posDetailModel = object;
                [self reloadData];
            }
        }];
    }else if(self.type == EAssignType){
        [self selectPosSettlePriceBySN:@{@"sn":self.batchModel.max_sn,@"user_id":self.batchModel.user_id,@"pos_type":@"TraditionalPOS",@"batch_no":self.batchModel.batch_no} completion:^(id object, NSString *error) {
            if (object) {
                self.posDetailModel = object;
                [self reloadData];
                [self.tableView reloadData];
            }
        }];
    }else if(self.type == CTAssignType){
        [self selectPosSettlePriceBySN:@{@"sn":self.batchModel.max_sn,@"user_id":self.batchModel.user_id,@"pos_type":@"TraditionalPOS",@"batch_no":self.batchModel.batch_no} completion:^(id object, NSString *error) {
            if (object) {
                self.posDetailModel = object;
                [self reloadData];
                [self.tableView reloadData];
            }
        }];
    }
   
    [self.view addSubview:self.tableView];
    AdjustTableBehavior(self.tableView);
}

-(void)reloadData{
    if (self.type == MAssigType) {
        if ([StringUtil isEmpty:self.posDetailModel.is_reward] || [self.posDetailModel.is_reward isEqualToString:@"0"]) {
            
            self.dataSource = @[
                       @[
                           [self real_name_dict:self.posDetailModel],
                           [self sn_dict:self.batchModel],
                           [self card_settle_price_dict:self.posDetailModel],
                           [self cloud_settle_price_dict:self.posDetailModel]
                           
                       ],
                       @[
                           [self single_profit_rate_dict:self.posDetailModel],
                           [self cash_back_rate_dict:self.posDetailModel],
                       ]
                       ];
        }else{
            self.dataSource = @[
                       @[
                           [self real_name_dict:self.posDetailModel],
                           [self sn_dict:self.batchModel],
                           [self card_settle_price_dict:self.posDetailModel],
                           [self cloud_settle_price_dict:self.posDetailModel],
                           [self is_reward_dict:self.posDetailModel]
                           
                       ],
                       @[
                           [self single_profit_rate_dict:self.posDetailModel],
                           [self cash_back_rate_dict:self.posDetailModel],
                       ]
                       ];
        }
       
    }else{
        if ([StringUtil isEmpty:self.posDetailModel.is_reward] || [self.posDetailModel.is_reward isEqualToString:@"0"]) {
            self.dataSource = @[
                @[
                     [self real_name_dict:self.posDetailModel],
                     [self sn_dict:self.batchModel],
                     [self card_settle_price_dict:self.posDetailModel],
                     [self card_settle_price_vip_dict:self.posDetailModel],
                     [self cloud_settle_price_dict:self.posDetailModel],
                     [self weixin_settle_price_dict:self.posDetailModel],
                     [self zhifubao_settle_price_dict:self.posDetailModel]
                 ],
                @[
                     [self single_profit_rate_dict:self.posDetailModel],
                     [self cash_back_rate_dict:self.posDetailModel],
                     [self mer_cap_fee_list_dict:self.posDetailModel],
                     [self policy_name_dict:self.posDetailModel]
                 ]
            ];
        }else{
        self.dataSource = @[
            @[
                 [self real_name_dict:self.posDetailModel],
                 [self sn_dict:self.batchModel],
                 [self card_settle_price_dict:self.posDetailModel],
                 [self card_settle_price_vip_dict:self.posDetailModel],
                 [self cloud_settle_price_dict:self.posDetailModel],
                 [self weixin_settle_price_dict:self.posDetailModel],
                 [self zhifubao_settle_price_dict:self.posDetailModel],
                 [self is_reward_dict:self.posDetailModel]
             ],
            @[
                 [self single_profit_rate_dict:self.posDetailModel],
                 [self cash_back_rate_dict:self.posDetailModel],
                 [self mer_cap_fee_list_dict:self.posDetailModel],
                 [self policy_name_dict:self.posDetailModel]
             ]
        ];
        }
        
    }

    self.snsArray = [self.posDetailModel.sns componentsSeparatedByString:@","];
    NSString* numStr = [NSString stringWithFormat:@"分配的SN码(%ld)",self.snsArray.count];
    [self.section2 reloadColor:@"#399481" left:numStr rightImg:@"" rightText:!self.isSelect?@"展开>":@"收起>"];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataSource.count >0) {
        return self.dataSource.count+1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        if (self.isSelect) {
            return self.snsArray.count/2+(self.snsArray.count%2==0?0:1);
        }else{
            return 0;
        }
    }
    NSArray* data = self.dataSource[section];
    return data.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 2) {
//        return 25;
//    }
//
//    if (self.type == CTAssignType && indexPath.section == 1 && indexPath.row == 3) {
//        return 88;
//    }
//    return 55;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 30;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        UIView* tmpView = [UIView new];
        [tmpView addSubview:self.section2];
        [self.section2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(15));
            make.right.equalTo(@(-15));
            make.top.bottom.equalTo(@(0));
        }];
        return tmpView;
    }
    return [[UIView alloc]init];
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"section2"];
       if(cell == nil) {
           cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"section2"];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
       }
        cell.textLabel.text = self.snsArray[indexPath.row*2];
        cell.textLabel.textColor = [UIColor grayColor];
        if ((self.snsArray.count-1) < (indexPath.row*2+1)) {
            cell.detailTextLabel.text = @"";
        }else{
             cell.detailTextLabel.text = self.snsArray[indexPath.row*2+1];
        }
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont font12];
        cell.detailTextLabel.font = [UIFont font12];
        return cell;
    }
    NSDictionary* dict = self.dataSource[indexPath.section][indexPath.row];
    NSString* type = dict[@"type"];
    if ([type isEqualToString:@"switch"]) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:selectIdentifier];
        TextSwitchView* view = [cell.contentView viewWithTag:101];
        if (!view) {
            view = [[TextSwitchView alloc]init];
            view.btn.enabled = NO;
            [view setLeftPadding:0];
            view.tag = 101;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:view];
            cell.backgroundColor = [UIColor clearColor];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        BOOL isOpen = [self.posDetailModel.is_reward isEqualToString:@"1"];
        [view.btn setOn:isOpen];
        return cell;
    }
    
    NSString* identifier = [NSString stringWithFormat:@"%ld_%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        TextTextImgView* view = [[TextTextImgView alloc]init];
//        view.desc.numberOfLines = 4;
        view.tag = 101;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view];
        cell.backgroundColor = [UIColor clearColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    TextTextImgView* view = [cell.contentView viewWithTag:101];
    dict = self.dataSource[indexPath.section][indexPath.row];
    if (indexPath.section == 0 &&( indexPath.row == 0||indexPath.row == 1)) {
        view.desc.textColor = [UIColor moBlack];
    }
    [view reloadImg:dict[@"image"] title:dict[@"title"] desc:dict[@"desc"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* dict = self.dataSource[indexPath.section][indexPath.row];
    dispatch_block_t block = dict[@"block"];
    !block?:block();
}
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:selectIdentifier];
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
        _tableView.estimatedRowHeight = 60;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

-(UIButton*)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setBackgroundColor:[UIColor darkGreen]];
        [_submitBtn setTitle:@"确定修改" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(void)submit:(id)sender{
    if (self.type == 0) {
        [self editAllocationMPosBatch:@{
                                            @"batch_no":self.batchModel.batch_no,
//                                            @"allocation_id":self.posDetailModel.allocation_id,
                                          @"cloud_settle_price":self.posDetailModel.cloud_settle_price,
                                          @"cash_back_rate":self.posDetailModel.cash_back_rate,
                                          @"card_settle_price":self.posDetailModel.card_settle_price,
                                          @"single_profit_rate":self.posDetailModel.single_profit_rate
                                          } completion:^(BOOL success, NSString *error) {
                                              if (success) {
                                                  [self.navigationController popViewControllerAnimated:YES];
                                              }
               }];
    }else if(self.type == 1){
        [self editAllocationTraditionalPosBatch:@{
                                                  @"batch_no":self.batchModel.batch_no,
//                                                   @"allocation_id":self.posDetailModel.allocation_id,
                                                   @"zhifubao_settle_price":self.posDetailModel.zhifubao_settle_price,
                                                   @"weixin_settle_price":self.posDetailModel.weixin_settle_price,
                                                   @"cloud_settle_price":self.posDetailModel.cloud_settle_price,
                                                   @"cash_back_rate":self.posDetailModel.cash_back_rate,
                                                   @"card_settle_price":self.posDetailModel.card_settle_price,
                                                   @"card_settle_price_vip":self.posDetailModel.card_settle_price_vip,
                                                   @"single_profit_rate":self.posDetailModel.single_profit_rate,
                                                   @"mer_cap_fee":self.posDetailModel.mer_cap_fee,
                                                   } completion:^(BOOL success, NSString *error) {
                  if (success) {
                      [self.navigationController popViewControllerAnimated:YES];
                  }
              }];
    }else{
        [self editAllocationTraditionalPosBatch:@{
                                                  @"batch_no":self.batchModel.batch_no,
//                                                   @"allocation_id":self.posDetailModel.allocation_id,
                                                   @"zhifubao_settle_price":self.posDetailModel.zhifubao_settle_price,
                                                   @"weixin_settle_price":self.posDetailModel.weixin_settle_price,
                                                   @"cloud_settle_price":self.posDetailModel.cloud_settle_price,
                                                   @"cash_back_rate":self.posDetailModel.cash_back_rate,
                                                   @"card_settle_price":self.posDetailModel.card_settle_price,
                                                   @"card_settle_price_vip":self.posDetailModel.card_settle_price_vip,
                                                   @"single_profit_rate":self.posDetailModel.single_profit_rate,
                                                   @"mer_cap_fee":self.posDetailModel.mer_cap_fee,
                                                   } completion:^(BOOL success, NSString *error) {
                  if (success) {
                      [self.navigationController popViewControllerAnimated:YES];
                  }
              }];
    }
}


-(NSDictionary*)real_name_dict:(AllocationPosDetailModel*)model{
    return @{@"title":@"代理伙伴",@"desc":model.real_name};
}

-(NSDictionary*)sn_dict:(AllocationPosBatchModel*)model{
    return @{@"title":@"POS机SN码",@"desc":[NSString stringWithFormat:@"%@-%@",model.min_sn,model.max_sn]};
}

-(NSDictionary*)card_settle_price_dict:(AllocationPosDetailModel*)model{
    return @{@"title":@"普通刷卡结算价",@"desc":[NSString stringWithFormat:@"%@%%",model.card_settle_price],@"image":@"选择",
             @"block":^(){
                 CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
                 slider.type = (self.type==0?@"MPOS":@"");
                 slider.subType = @"card_settle_price";
                 slider.sn = self.batchModel.max_sn;
                 slider.block = ^(id data) {
                    self.posDetailModel.card_settle_price = data;
                    [self reloadData];
                 };
                 [self.viewDeckController setRightViewController:slider];
                 [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
             }};
}

-(NSDictionary*)card_settle_price_vip_dict:(AllocationPosDetailModel*)model{
    return @{@"title":@"VIP刷卡结算价",@"desc":[NSString stringWithFormat:@"%@%%",model.card_settle_price_vip],@"image":@"选择",
             @"block":^(){
               CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
               slider.type = (self.type==0?@"MPOS":@"");
               slider.subType = @"card_settle_price_vip";
               slider.sn = self.batchModel.max_sn;
               slider.block = ^(id data) {
                    self.posDetailModel.card_settle_price_vip = data;
                    [self reloadData];
               };
               [self.viewDeckController setRightViewController:slider];
               [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
               }};
}

-(NSDictionary*)cloud_settle_price_dict:(AllocationPosDetailModel*)model{
    return @{@"title":@"云闪付结算价",@"desc":[NSString stringWithFormat:@"%@%%",model.cloud_settle_price],@"image":@"选择",
             @"block":^(){
                 CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
                 slider.type = (self.type==0?@"MPOS":@"");
                 slider.subType = @"cloud_settle_price";
                 slider.sn = self.batchModel.max_sn;
                 slider.block = ^(id data) {
                     self.posDetailModel.cloud_settle_price = data;
                      [self reloadData];
                 };
                 [self.viewDeckController setRightViewController:slider];
                 [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
             }
    };
}

-(NSDictionary*)single_profit_rate_dict:(AllocationPosDetailModel*)model{
    return @{@"title":@"单笔分润",@"desc":[NSString stringWithFormat:@"%@%%",model.single_profit_rate],@"image":@"选择",
            @"block":^(){
            CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
            slider.type = (self.type==0?@"MPOS":@"");
            slider.subType = @"single_profit_rate";
            slider.sn = self.batchModel.max_sn;
            slider.block = ^(id data) {
                self.posDetailModel.single_profit_rate = data;
                [self reloadData];
            };
            [self.viewDeckController setRightViewController:slider];
            [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
            }
      };
}

-(NSDictionary*)cash_back_rate_dict:(AllocationPosDetailModel*)model{
    return @{@"title":@"机器返现",@"desc":[NSString stringWithFormat:@"%@%%",model.cash_back_rate],@"image":@"选择",
             @"block":^(){
            CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
            slider.type = (self.type==0?@"MPOS":@"");
            slider.subType = @"cash_back_rate";
            slider.sn = self.batchModel.max_sn;
            slider.block = ^(id data) {
                 self.posDetailModel.cash_back_rate = data;
                 [self reloadData];
            };
            [self.viewDeckController setRightViewController:slider];
            [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
            }};
}

-(NSDictionary*)mer_cap_fee_list_dict:(AllocationPosDetailModel*)model{
    return @{@"title":@"储蓄卡封顶结算价",@"desc":[NSString stringWithFormat:@"%@%%",model.mer_cap_fee],@"image":@"选择",
             @"block":^(){
            CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
            slider.type = @"CTPOS";
            slider.subType = @"mer_cap_fee_list";
            slider.sn = self.batchModel.max_sn;
            slider.block = ^(id data) {
                 self.posDetailModel.mer_cap_fee = data;
                 [self reloadData];
            };
            [self.viewDeckController setRightViewController:slider];
            [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
            }};
}


-(NSDictionary*)policy_name_dict:(AllocationPosDetailModel*)model{
    return  @{@"title":@"代理政策",@"desc":model.policy_name?:@"-"};
}
   
-(NSDictionary*)weixin_settle_price_dict:(AllocationPosDetailModel*)model{
    return @{@"title":@"微信结算价",@"desc":[NSString stringWithFormat:@"%@%%",model.weixin_settle_price],@"image":@"选择",
             @"block":^(){
                 CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
                 slider.type = (self.type==0?@"MPOS":@"");
                 slider.subType = @"weixin_settle_price";
                 slider.sn = self.batchModel.max_sn;
                 slider.block = ^(id data) {
                     self.posDetailModel.weixin_settle_price = data;
                      [self reloadData];
                 };
                 [self.viewDeckController setRightViewController:slider];
                 [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
             }
    };
}

-(NSDictionary*)zhifubao_settle_price_dict:(AllocationPosDetailModel*)model{
    return @{@"title":@"支付宝结算价",@"desc":[NSString stringWithFormat:@"%@%%",model.zhifubao_settle_price],@"image":@"选择",
             @"block":^(){
                 CardSettleSliderVC* slider = [[CardSettleSliderVC alloc]init];
                 slider.type = (self.type==0?@"MPOS":@"");
                 slider.subType = @"zhifubao_settle_price";
                 slider.sn = self.batchModel.max_sn;
                 slider.block = ^(id data) {
                     self.posDetailModel.zhifubao_settle_price = data;
                      [self reloadData];
                 };
                 [self.viewDeckController setRightViewController:slider];
                 [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
             }
    };
}
-(RFHeader*)section2{
    if (!_section2) {
        _section2 =  ({
            RFHeader* header = [RFHeader new];
            header.backgroundColor = [UIColor whiteColor];
            [header reloadColor:@"#399481" left:@"分配的SN码(0)" rightImg:@"" rightText:@"展开>"];
            header;
        });
        [_section2.rightLbl addTarget:self action:@selector(open:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _section2;
}

-(void)open:(id)sender{
    self.isSelect = !self.isSelect;
    
    NSString* numStr = [NSString stringWithFormat:@"分配的SN码(%ld)",self.snsArray.count];
    [self.section2 reloadColor:@"#399481" left:numStr rightImg:@"" rightText:!self.isSelect?@"展开>":@"收起>"];
    [self.tableView reloadData];
}


-(NSDictionary*)is_reward_dict:(AllocationPosDetailModel*)model{
    return @{@"title":@"交易量达标返现领取",@"desc":model.is_reward,@"type":@"switch"};
}


@end

