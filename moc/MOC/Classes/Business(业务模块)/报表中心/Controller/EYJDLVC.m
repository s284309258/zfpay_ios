//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "EYJDLVC.h"
#import "YJTJView.h"
#import "NSObject+RF.h"
#import "PGDatePickManager.h"
#import "RFPosDetailModel.h"
#import "NSDate+String.h"
#import "NSDate+Category.h"
@interface EYJDLVC ()<UITableViewDelegate,UITableViewDataSource,PGDatePickerDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *headerData;

@property (strong, nonatomic) RFPosDetailModel *dayData;

@property (strong, nonatomic) RFPosDetailModel *monthData;

@property (strong, nonatomic) NSString *dayStr;

@property (strong, nonatomic) NSString *monthStr;

@end

@implementation EYJDLVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
  
}

-(void)initUI{
    [self setNavBarTitle:@"应用中心" color:[UIColor whiteColor]];
    [self.view addSubview:self.tableView];
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    self.monthStr = [NSDate dateString:[NSDate date] format:@"yyyy-MM"];
    self.dayStr = [NSDate dateString:[NSDate date] format:@"yyyy-MM-dd"];
    [self getDayAgencyTraditionalPosDetail];
    [self getMonthAgencyTraditionalPosDetail];
  
    self.headerData = @[@{@"color":@"#01C088",@"text":@"月业绩",@"desc":@"2019-08"},
                        @{@"color":@"#01C088",@"text":@"日业绩",@"desc":@"2019-08-06"}];
}

-(void)getDayAgencyTraditionalPosDetail{
    [self getDayAgencyTraditionalPosDetail:@{@"date":[self.dayStr stringByReplacingOccurrencesOfString:@"-" withString:@""],@"pos_type":@"epos"} completion:^(id object, NSString *error) {
        if (object) {
            self.dayData = object;
            [self.tableView reloadData];
        }
    }];
}

-(void)getMonthAgencyTraditionalPosDetail{
    [self getMonthAgencyTraditionalPosDetail:@{@"date":[self.monthStr stringByReplacingOccurrencesOfString:@"-" withString:@""],@"pos_type":@"epos"} completion:^(id object, NSString *error) {
        if (object) {
            self.monthData = object;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [YJTJView getHeight];
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

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        YJTJView* view = [[YJTJView alloc]init];
        view.tag = 101;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view];
        cell.backgroundColor = [UIColor clearColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    YJTJView* view = [cell.contentView viewWithTag:101];
    NSDictionary* dict = self.headerData[indexPath.section];
    NSString* date = @"";
    if (indexPath.section == 0) {
        date = self.monthStr;
        [view reload:self.monthData btnTitle:@"业绩走势分析(月)"];
    }else if(indexPath.section == 1){
        date = self.dayStr;
        [view reload:self.dayData btnTitle:@"业绩走势分析(日)"];
    }
    [view refreshHeader:dict[@"color"] text:dict[@"text"]  desc:date];
    view.chartBlock  = ^(id data) {
         if (indexPath.section == 0) {
             [MXRouter openURL:@"lcwl://PerformanceChartVC" parameters:@{@"type":@"EDL",@"subType":@"month",@"dateStr":[self.monthStr stringByReplacingOccurrencesOfString:@"-" withString:@""]}];
         }else{
             [MXRouter openURL:@"lcwl://PerformanceChartVC" parameters:@{@"type":@"EDL",@"subType":@"day",@"dateStr":[self.dayStr stringByReplacingOccurrencesOfString:@"-" withString:@""]}];
         }
    };
    view.dateBlock = ^(id data) {
        if (indexPath.section == 0) {
            PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
            datePickManager.style = PGDatePickManagerStyleAlertBottomButton;
            datePickManager.isShadeBackground = true;
            PGDatePicker *datePicker = datePickManager.datePicker;
            datePicker.isHiddenMiddleText = false;
            datePicker.delegate = self;
            datePicker.datePickerType = PGDatePickerTypeSegment;
            datePicker.datePickerMode = PGDatePickerModeYearAndMonth;
            [self presentViewController:datePickManager animated:false completion:nil];
        }else if(indexPath.section == 1){
            PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
            datePickManager.style = PGDatePickManagerStyleAlertBottomButton;
            datePickManager.isShadeBackground = true;
            PGDatePicker *datePicker = datePickManager.datePicker;
            datePicker.isHiddenMiddleText = false;
            datePicker.delegate = self;
            datePicker.datePickerType = PGDatePickerTypeSegment;
            datePicker.datePickerMode = PGDatePickerModeDate;
            [self presentViewController:datePickManager animated:false completion:nil];
        }
        
    };
    return cell;
}

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents{
    if (datePicker.datePickerMode == PGDatePickerModeDate) {
        self.dayStr = [NSDate componentsToString:dateComponents format:@"yyyy-MM-dd"];
        [self getDayAgencyTraditionalPosDetail];
    }else if(datePicker.datePickerMode == PGDatePickerModeYearAndMonth){
        self.monthStr = [NSDate componentsToString:dateComponents format:@"yyyy-MM"];
        [self getMonthAgencyTraditionalPosDetail];
    }
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
