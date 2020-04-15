//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "MachineAssignVC.h"
#import "SearchRegionView.h"
#import "RFHeader.h"
#import "MachineManageCell.h"
#import "TradeHBItemView.h"
#import "NSObject+Home.h"
#import "PosAllocationModel.h"
#import "MAssignApplyVC.h"
#import "CTAssignApplyVC.h"
#import "IIViewDeckController.h"
#import "LLKAssignApplyVC.h"
@interface MachineAssignVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSArray *headerData;

@property (strong, nonatomic) UIButton *bottomBtn;

@property (strong, nonatomic) NSArray *typeArray;

@property (strong, nonatomic) NSString *typeValue;

@property (strong, nonatomic) NSString *start_number;

@property (strong, nonatomic) NSString *end_number;

@property (strong, nonatomic) NSMutableArray* selectArray;

@property (strong , nonatomic) IIViewDeckController *viewDeckController;

@property  (nonatomic) BOOL isSelect;

@property (strong, nonatomic) UIView *tableHeaderView;

@property (strong, nonatomic) RFHeader *section2;

@end

@implementation MachineAssignVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self initData];
}

-(void)setupUI{
    [self setNavBarTitle:@"应用中心" color:[UIColor whiteColor]];
    self.selectArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.headerData = @[@{@"color":@"#01C088",@"left":@"选择类型",@"right":@""},
                        @{@"color":@"#01C088",@"left":@"搜索范围",@"right":@""},
                        @{@"color":@"#01C088",@"left":@"搜索结果",@"right":@"全选"}];
    self.typeArray = @[@"MPOS",@"传统POS",@"EPOS",@"流量卡"];
    self.typeValue = self.typeArray[0];
    self.dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableHeaderView];
    [self.view addSubview:self.tableView];
    [_tableHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(10));
        make.left.right.equalTo(self.view);
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(@(-44));
        make.top.equalTo(self.tableHeaderView.mas_bottom);
    }];
    AdjustTableBehavior(self.tableView);

    [self.view addSubview:self.bottomBtn];
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(44));
    }];
}

-(void)initData{
    [self requestAllocationList];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;return self.headerData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self.typeArray indexOfObject:self.typeValue];
    if (index == 3) {
        return 65;
    }
    PosAllocationModel* model = self.dataSource[indexPath.row];
    NSString* vipPrice = [StringUtil isEmpty:model.card_settle_price_vip]?@"--":model.card_settle_price_vip;
    
    NSString* text = [NSString stringWithFormat:@"刷卡结算价:%@%%\n云闪付结算价:%@%%\n激活剩余天数:%@\nVIP结算价:%@\n政策:%@",model.card_settle_price,model.cloud_settle_price,[StringUtil isEmpty:model.expire_day]?@"0":model.expire_day,vipPrice,model.policy_name?:@"--"];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
    CGSize size = [text boundingRectWithSize:CGSizeMake((SCREEN_WIDTH-(45+15+10+20+15)),MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return size.height+60;
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self.typeArray indexOfObject:self.typeValue];
    NSString* identifier = [NSString stringWithFormat:@"%ld_%ld",index,indexPath.section];
    MachineManageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[MachineManageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    PosAllocationModel* model = self.dataSource[indexPath.row];
    BOOL isSelected = NO;
    if ([self.selectArray containsObject:model]) {
        isSelected = YES;
    }
    [cell reload:model select:isSelected type:index];
    if (index == 3) {
        [cell LLKLayout];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.dataSource.count) {
        return;
    }
    PosAllocationModel* model = self.dataSource[indexPath.row];
    BOOL bol  = [self.selectArray containsObject:model];
    //是否存在
    if (bol) {
        [self.selectArray removeObject:model];
    }else{
        if (self.selectArray.count >0) {
            PosAllocationModel* tmp = self.selectArray[0];
            if (
                ![tmp.card_settle_price isEqualToString:model.card_settle_price]||
                ![tmp.cloud_settle_price isEqualToString:model.cloud_settle_price]||
                ![tmp.cash_back_rate isEqualToString:model.cash_back_rate]||
                ![tmp.single_profit_rate isEqualToString:model.single_profit_rate]) {
                [NotifyHelper showMessageWithMakeText:@"请选择刷卡结算价统一的机具"];
                return;
            }
        }
        [self.selectArray addObject:model];
    }
    [self.tableView reloadData];
    NSDictionary* dict =  self.headerData[2];
   [ self.section2 reloadColor:dict[@"color"] left:dict[@"left"] rightImg:self.isSelect?@"勾选":@"None" rightText:[NSString stringWithFormat:@"全选(%ld)",self.selectArray.count]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(UIButton*)bottomBtn{
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_bottomBtn setBackgroundColor:[UIColor darkGreen]];
        _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_bottomBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
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
    }
    return _tableView;
}

-(void)next:(id)sender{
    NSInteger index = [self.typeArray indexOfObject:self.typeValue];
    if (self.selectArray.count == 0) {
        if (index == 3) {
            [NotifyHelper showMessageWithMakeText:@"请选择流量卡"];
        }else{
            [NotifyHelper showMessageWithMakeText:@"请选择POS机"];
        }
        return;
    }
    if (index == 0) {
        MAssignApplyVC* vc = [[MAssignApplyVC alloc]init];
        vc.block = ^(id data) {
            [self requestAllocationList];
        };
        vc.dataArray = self.selectArray;
        self.viewDeckController = [[IIViewDeckController alloc] initWithCenterViewController:vc rightViewController:nil];
        self.viewDeckController.title = @"MPOS分配";
        UIButton    * customBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        [customBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [customBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
        customBtn.enabled = NO;
        [customBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:customBtn];
        self.viewDeckController.navigationItem.leftBarButtonItem = barItem ;
        //添加完成btn
        [self.navigationController pushViewController:self.viewDeckController animated:YES];

    }else if(index == 1){
        CTAssignApplyVC* vc = [[CTAssignApplyVC alloc]init];
        vc.type = @"CTPOS";
        vc.block = ^(id data) {
            [self requestAllocationList];
        };
        vc.dataArray = self.selectArray;
        self.viewDeckController = [[IIViewDeckController alloc] initWithCenterViewController:vc rightViewController:nil];
        self.viewDeckController.title = @"传统POS分配";
        UIButton    * customBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        [customBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [customBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
        customBtn.enabled = NO;
        [customBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:customBtn];
        self.viewDeckController.navigationItem.leftBarButtonItem = barItem ;
        //添加完成btn
        [self.navigationController pushViewController:self.viewDeckController animated:YES];
        
    }else if(index == 3){
        LLKAssignApplyVC* vc = [[LLKAssignApplyVC alloc]init];
        vc.block = ^(id data) {
            [self requestAllocationList];
        };
        vc.dataArray = self.selectArray;
        self.viewDeckController = [[IIViewDeckController alloc] initWithCenterViewController:vc rightViewController:nil];
        self.viewDeckController.title = @"流量卡分配";
        UIButton    * customBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        [customBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [customBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
        customBtn.enabled = NO;
        [customBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:customBtn];
        self.viewDeckController.navigationItem.leftBarButtonItem = barItem ;
        //添加完成btn
        [self.navigationController pushViewController:self.viewDeckController animated:YES];
    }else if(index == 2){
        CTAssignApplyVC* vc = [[CTAssignApplyVC alloc]init];
        vc.type = @"EPOS";
        vc.block = ^(id data) {
            [self requestAllocationList];
        };
        vc.dataArray = self.selectArray;
        self.viewDeckController = [[IIViewDeckController alloc] initWithCenterViewController:vc rightViewController:nil];
        self.viewDeckController.title = @"EPOS分配";
        UIButton    * customBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        [customBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [customBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
        customBtn.enabled = NO;
        [customBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:customBtn];
        self.viewDeckController.navigationItem.leftBarButtonItem = barItem ;
        //添加完成btn
        [self.navigationController pushViewController:self.viewDeckController animated:YES];
        
    }
}

-(void)requestAllocationList{
    NSInteger index = [self.typeArray indexOfObject:self.typeValue];
    if (index == 0) {
        [self getMposAllocationList:@{@"start_number":self.start_number,@"end_number":self.end_number} completion:^(id array, NSString *error) {
            if (array) {
                [self.selectArray removeAllObjects];
                self.dataSource = array;
                [self.tableView reloadData];

                NSDictionary* dict =  self.headerData[2];
                [ self.section2 reloadColor:dict[@"color"] left:dict[@"left"] rightImg:self.isSelect?@"勾选":@"None" rightText:[NSString stringWithFormat:@"全选(%ld)",self.selectArray.count]];
            }
        }];
    }else if(index == 1){
        [self getTraditionalPosAllocationList:@{@"start_number":self.start_number,@"end_number":self.end_number} completion:^(id array, NSString *error) {
            if (array) {
                [self.selectArray removeAllObjects];
                self.dataSource = array;
                [self.tableView reloadData];

                NSDictionary* dict =  self.headerData[2];
                [ self.section2 reloadColor:dict[@"color"] left:dict[@"left"] rightImg:self.isSelect?@"勾选":@"None" rightText:[NSString stringWithFormat:@"全选(%ld)",self.selectArray.count]];
            }
        }];
        
    }else if(index == 3){
        [self getTrafficCardAllocationList:@{@"start_number":self.start_number,@"end_number":self.end_number} completion:^(id array, NSString *error) {
            if (array) {
                [self.selectArray removeAllObjects];
                self.dataSource = array;
                [self.tableView reloadData];

                NSDictionary* dict =  self.headerData[2];
                [ self.section2 reloadColor:dict[@"color"] left:dict[@"left"] rightImg:self.isSelect?@"勾选":@"None" rightText:[NSString stringWithFormat:@"全选(%ld)",self.selectArray.count]];
            }
        }];
        
    }else if(index == 2){
        [self getTraditionalPosAllocationList:@{@"start_number":self.start_number,@"end_number":self.end_number,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
            if (array) {
                [self.selectArray removeAllObjects];
                self.dataSource = array;
                [self.tableView reloadData];

                NSDictionary* dict =  self.headerData[2];
                [ self.section2 reloadColor:dict[@"color"] left:dict[@"left"] rightImg:self.isSelect?@"勾选":@"None" rightText:[NSString stringWithFormat:@"全选(%ld)",self.selectArray.count]];
            }
        }];
        
    }
}

-(UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
        RFHeader *section0 = ({
            RFHeader* header = [RFHeader new];
            header.backgroundColor = [UIColor whiteColor];
            NSDictionary* dict =  self.headerData[0];
            [header reloadColor:dict[@"color"] left:dict[@"left"] right:@""];
            header;
        });
        [_tableHeaderView addSubview:section0];
        TradeHBItemView* typeView = [[TradeHBItemView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,80) column:3];
       [typeView configData:self.typeArray];
      
       [_tableHeaderView addSubview:typeView];
        RFHeader *section1 = ({
            RFHeader* header = [RFHeader new];
            header.backgroundColor = [UIColor whiteColor];
            NSDictionary* dict =  self.headerData[1];
            [header reloadColor:dict[@"color"] left:dict[@"left"] right:@""];
            header;
        });
        [_tableHeaderView addSubview:section1];
        SearchRegionView* regionView = [[SearchRegionView alloc]init];
        regionView.block = ^(id data) {
            NSArray* tmp = data;
            self.start_number = tmp[0];
            self.end_number = tmp[1];
            self.isSelect = NO;
            [self requestAllocationList];
        };
        [_tableHeaderView addSubview:regionView];
        regionView.backgroundColor = [UIColor clearColor];
        self.section2 = ({
            RFHeader* header = [RFHeader new];
            header.backgroundColor = [UIColor whiteColor];
            NSDictionary* dict =  self.headerData[2];
            [header reloadColor:dict[@"color"] left:dict[@"left"] rightImg:self.isSelect?@"勾选":@"None" rightText:@"全选(0)"];
            header;
        });
        @weakify(self)
        [_tableHeaderView addSubview: self.section2];
         self.section2.block = ^(id data) {
            @strongify(self)
            self.isSelect = !self.isSelect;
            [self.selectArray removeAllObjects];
            if (self.isSelect) {
                [self.selectArray addObjectsFromArray:self.dataSource];
            }

             [self.tableView reloadData];
            NSDictionary* dict =  self.headerData[2];
            [ self.section2 reloadColor:dict[@"color"] left:dict[@"left"] rightImg:self.isSelect?@"勾选":@"None" rightText:[NSString stringWithFormat:@"全选(%ld)",self.selectArray.count]];
        };
        typeView.selectedBlock = ^(id data) {
            self.typeValue = data;
            //清空原始数据
            [self.selectArray removeAllObjects];
            [self.dataSource removeAllObjects];
            
            [self.tableView reloadData];
            NSDictionary* dict =  self.headerData[2];
            [self.section2 reloadColor:dict[@"color"] left:dict[@"left"] rightImg:self.isSelect?@"勾选":@"None" rightText:[NSString stringWithFormat:@"全选(%ld)",self.selectArray.count]];
        };
        
        [section0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tableHeaderView);
            make.left.equalTo(@(15));
            make.right.equalTo(@(-15));
            make.height.equalTo(@(30));
        }];
       
        [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(section0.mas_bottom);
            make.left.equalTo(@(15));
            make.right.equalTo(@(-15));
            make.height.equalTo(@(80));
        }];
      
        [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(typeView.mas_bottom);
            make.left.equalTo(@(15));
            make.right.equalTo(@(-15));
            make.height.equalTo(@(30));
        }];
      
        [regionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(section1.mas_bottom);
            make.left.equalTo(@(15));
            make.right.equalTo(@(-15));
            make.height.equalTo(@(40));
        }];
       
        [self.section2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(regionView.mas_bottom);
            make.left.equalTo(@(15));
            make.right.equalTo(@(-15));
            make.height.equalTo(@(30));
            make.bottom.equalTo(_tableHeaderView);
        }];
    }
    return _tableHeaderView;
}

@end
