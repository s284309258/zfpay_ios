//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "MachineReturnVC.h"
#import "SearchRegionView.h"
#import "RFHeader.h"
#import "MachineManageCell.h"
#import "TradeHBItemView.h"
#import "NSObject+Home.h"
#import "PosAllocationModel.h"
@interface MachineReturnVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSArray *headerData;

@property (strong, nonatomic) UIButton *bottomBtn;

@property (strong, nonatomic) NSArray *typeArray;

@property (strong, nonatomic) NSString *typeValue;

@property (strong, nonatomic) NSString *start_number;

@property (strong, nonatomic) NSString *end_number;

@property (strong, nonatomic) NSMutableArray* selectArray;

@property  (nonatomic) BOOL isSelect;

@property (strong, nonatomic) UIView *tableHeaderView;

@property (strong, nonatomic) RFHeader *section2;

@end

@implementation MachineReturnVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
   
}

-(void)setupUI{
    self.selectArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.headerData = @[@{@"color":@"#01C088",@"left":@"选择类型",@"right":@""},
                   @{@"color":@"#01C088",@"left":@"搜索范围",@"right":@""},
                   @{@"color":@"#01C088",@"left":@"搜索结果",@"right":@"全选"}];
    self.typeArray = @[@"MPOS",@"传统POS",@"EPOS",@"流量卡"];
    self.typeValue = self.typeArray[0];
    self.dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableHeaderView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomBtn];
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
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(44));
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
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
    [cell LLKLayout];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource.count <= indexPath.row) {
        return;
    }
    PosAllocationModel* model = self.dataSource[indexPath.row];
    BOOL bol  = [self.selectArray containsObject:model];
    //是否存在
    if (bol) {
        [self.selectArray removeObject:model];
    }else{
        [self.selectArray addObject:model];
    }
    [self.tableView reloadData];
    NSDictionary* dict =  self.headerData[2];
    [self.section2 reloadColor:dict[@"color"] left:dict[@"left"] rightImg:self.isSelect?@"勾选":@"None" rightText:[NSString stringWithFormat:@"全选(%ld)",self.selectArray.count]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

-(UIButton*)bottomBtn{
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setTitle:@"确认召回" forState:UIControlStateNormal];
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
    [NotifyHelper showHUDAddedTo:self.view makeText:@"" animated:YES];
    if (index == 0) {
        [self recallMpos:@{@"sn_list":[self getPosStr:self.selectArray]} completion:^(BOOL success, NSString *error) {
            [NotifyHelper hideAllHUDsForView:self.view animated:YES];
            if (success) {
                [self requestAllocationList];
            }
        }];
    }else if(index == 1){
        [self recallTraditionalPos:@{@"sn_list":[self getPosStr:self.selectArray]} completion:^(BOOL success, NSString *error) {
            [NotifyHelper hideAllHUDsForView:self.view animated:YES];
            if (success) {
                 [self requestAllocationList];
            }
        }];
    }else if(index == 3){
        [self recallTrafficCard:@{@"card_list":[self getCardNoStr:self.selectArray]} completion:^(BOOL success, NSString *error) {
            [NotifyHelper hideAllHUDsForView:self.view animated:YES];
            if (success) {
                 [self requestAllocationList];
            }
        }];
    }else if(index == 2){
        [self recallTraditionalPos:@{@"sn_list":[self getPosStr:self.selectArray],@"pos_type":@"epos"} completion:^(BOOL success, NSString *error) {
            [NotifyHelper hideAllHUDsForView:self.view animated:YES];
            if (success) {
                 [self requestAllocationList];
            }
        }];
    }
}

-(void)requestAllocationList{
    NSInteger index = [self.typeArray indexOfObject:self.typeValue];
    if (index == 0) {
        [self getMposRecallList:@{@"start_number":self.start_number,@"end_number":self.end_number} completion:^(id array, NSString *error) {
            if (array) {
                [self.selectArray removeAllObjects];
                self.dataSource = array;
                [self.tableView reloadData];
                NSDictionary* dict =  self.headerData[2];
                [ self.section2 reloadColor:dict[@"color"] left:dict[@"left"] rightImg:self.isSelect?@"勾选":@"None" rightText:[NSString stringWithFormat:@"全选(%ld)",self.selectArray.count]];
            }
        }];
       
    }else if(index == 1){
        [self getTraditionalPosRecallList:@{@"start_number":self.start_number,@"end_number":self.end_number} completion:^(id array, NSString *error) {
            if (array) {
                [self.selectArray removeAllObjects];
                self.dataSource = array;
                [self.tableView reloadData];
                NSDictionary* dict =  self.headerData[2];
                [self.section2 reloadColor:dict[@"color"] left:dict[@"left"] rightImg:self.isSelect?@"勾选":@"None" rightText:[NSString stringWithFormat:@"全选(%ld)",self.selectArray.count]];
            }
        }];
    }else if(index == 3){
        [self getTrafficCardRecallList:@{@"start_number":self.start_number,@"end_number":self.end_number} completion:^(id array, NSString *error) {
            if (array) {
                [self.selectArray removeAllObjects];
                self.dataSource = array;
                [self.tableView reloadData];
                NSDictionary* dict =  self.headerData[2];
                [self.section2 reloadColor:dict[@"color"] left:dict[@"left"] rightImg:self.isSelect?@"勾选":@"None" rightText:[NSString stringWithFormat:@"全选(%ld)",self.selectArray.count]];
            }
        }];
        
    }else if(index == 2){
        [self getTraditionalPosRecallList:@{@"start_number":self.start_number,@"end_number":self.end_number,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
            if (array) {
                [self.selectArray removeAllObjects];
                self.dataSource = array;
                [self.tableView reloadData];
                NSDictionary* dict =  self.headerData[2];
                [self.section2 reloadColor:dict[@"color"] left:dict[@"left"] rightImg:self.isSelect?@"勾选":@"None" rightText:[NSString stringWithFormat:@"全选(%ld)",self.selectArray.count]];
            }
        }];
    }
}

-(NSString*)getPosStr:(NSArray*)array{
    NSArray *unionOfObjects = [array valueForKeyPath:@"@unionOfObjects.sn"];
    return [unionOfObjects componentsJoinedByString:@","];
}

-(NSString*)getCardNoStr:(NSArray*)array{
    NSArray *unionOfObjects = [array valueForKeyPath:@"@unionOfObjects.card_no"];
    return [unionOfObjects componentsJoinedByString:@","];
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
