//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "PerformanceChartVC.h"
#import "SCBarCell.h"
#import "ChartOptionView.h"
#import "NSObject+RF.h"
#import "RFPosDetailModel.h"
static NSString *reuseIdentifierBar = @"SCBarCell";
@interface PerformanceChartVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *headerData;

@property (strong, nonatomic)  SCBarCell *cell;

@property (strong, nonatomic)  NSMutableArray *dataSource;

@property (strong, nonatomic)  NSMutableArray *tradeArray;

@property (strong, nonatomic)  NSMutableArray *agencyArray;

@property (strong, nonatomic)  NSMutableArray *merchantArray;

@property (strong, nonatomic)  NSMutableArray *dateArray;

@property (strong, nonatomic)  NSMutableArray *valueArray;
@end

@implementation PerformanceChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    
}

-(void)initUI{
    if ([self.subType isEqualToString:@"day"]) {
         [self setNavBarTitle:@"业绩走势(日)"];
    }else{
         [self setNavBarTitle:@"业绩走势(月)"];
    }
   
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SCBarCell class] forCellReuseIdentifier:reuseIdentifierBar];
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    self.dataSource = @[];
    self.tradeArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.agencyArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.merchantArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.dateArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.valueArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    if ([self.type isEqualToString:@"CTDL"]) {
        if ([self.subType isEqualToString:@"day"]) {
            [self getDayAgencyTraditionalPosList:@{@"date":self.dateStr} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self filter:self.dataSource];
                }
            }];
        }else{
            [self getMonthAgencyTraditionalPosList:@{@"date":self.dateStr} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self filter:self.dataSource];
                }
            }];
            
        }
    }else if ([self.type isEqualToString:@"CTWD"]) {
        if ([self.subType isEqualToString:@"day"]) {
            [self getDayMerchantTraditionalPosList:@{@"date":self.dateStr} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self filter:self.dataSource];
                }
            }];
        }else{
            [self getMonthMerchantTraditionalPosList:@{@"date":self.dateStr} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self filter:self.dataSource];
                }
            }];
            
        }
    }else if ([self.type isEqualToString:@"MDL"]) {
        if ([self.subType isEqualToString:@"day"]) {
            [self getDayAgencyMposList:@{@"date":self.dateStr} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self filter:self.dataSource];
                }
            }];
        }else{
            [self getMonthAgencyMposList:@{@"date":self.dateStr} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self filter:self.dataSource];
                }
            }];
            
        }
    }else if ([self.type isEqualToString:@"MWD"]) {
        if ([self.subType isEqualToString:@"day"]) {
            [self getDayMerchantMposList:@{@"date":self.dateStr} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self filter:self.dataSource];
                }
            }];
        }else{
            [self getMonthMerchantMposList:@{@"date":self.dateStr} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self filter:self.dataSource];
                }
            }];
            
        }
    }else if ([self.type isEqualToString:@"EDL"]) {
        if ([self.subType isEqualToString:@"day"]) {
            [self getDayAgencyTraditionalPosList:@{@"date":self.dateStr,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self filter:self.dataSource];
                }
            }];
        }else{
            [self getMonthAgencyTraditionalPosList:@{@"date":self.dateStr,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self filter:self.dataSource];
                }
            }];
            
        }
    }else if ([self.type isEqualToString:@"EWD"]) {
        if ([self.subType isEqualToString:@"day"]) {
            [self getDayMerchantTraditionalPosList:@{@"date":self.dateStr,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self filter:self.dataSource];
                }
            }];
        }else{
            [self getMonthMerchantTraditionalPosList:@{@"date":self.dateStr,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
                if (array) {
                    self.dataSource = array;
                    [self filter:self.dataSource];
                }
            }];
            
        }
    }
}

-(void)filter:(NSArray*)array{
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RFPosDetailModel* model = obj;
        float performance = [model.performance floatValue];
        float user_num = [model.user_num floatValue];
        float act_num = [model.act_num floatValue];
        [self.tradeArray addObject:@[@(performance)]];
        [self.agencyArray addObject:@[@(user_num)]];
        [self.merchantArray addObject:@[@(act_num)]];
        if ([StringUtil isEmpty:model.date]) {
            [self.dateArray addObject:@""];
        }else{
            [self.dateArray addObject:model.date];
        }
    }];
    self.valueArray = self.tradeArray;
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 110;
    }
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
         return [[UIView alloc]init];
    }
    return nil;
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if(cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                ChartOptionView* view = [[ChartOptionView alloc]init];
                [cell.contentView addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(cell.contentView);
                }];
                view.block = ^(id data) {
                    int index = [data intValue];
                    if (index == 0) {
                        self.valueArray = self.tradeArray;
                    }else if(index == 1){
                        self.valueArray = self.agencyArray;
                    }else if(index == 2){
                        self.valueArray = self.merchantArray;
                    }
                    [self.cell configValueArr:self.valueArray showInfoText:self.dateArray];
                };
            }
            return cell;
        }
            break;
            
        case 1:
        {
            self.cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBar forIndexPath:indexPath];
            if (!self.cell) {
                self.cell = [[SCBarCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierBar];
            }
            if (self.valueArray.count != 0) {
                [self.cell configValueArr:self.valueArray showInfoText:self.dateArray];
            }
            self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return self.cell;
        }
            break;
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
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 0, 0));
        }];
    }
    return _tableView;
}


@end
