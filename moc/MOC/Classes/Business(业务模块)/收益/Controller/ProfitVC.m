//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "ProfitVC.h"
#import "ProfitTopView.h"
#import "OTPageView.h"
#import "ProfitView.h"
#import "ProfitFormView.h"
#import "NSObject+Profit.h"
#import "UserPurseInfoModel.h"
#import "ProfitHeaderInfo.h"
#import "PosBenefitDetailModel.h"
#import "PGDatePickManager.h"
#import "NSDate+String.h"
#import "NSDate+Category.h"
static NSString* reuseIdentifierHeader = @"header";
static NSString* reuseIdentifierNormal = @"normal";
@interface ProfitVC ()<UITableViewDelegate,UITableViewDataSource,OTPageScrollViewDataSource,OTPageScrollViewDelegate>

@property (strong, nonatomic) UITableView    *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) OTPageView     *pageView;

@property (strong, nonatomic) ProfitHeaderInfo   *headerModel;

@property (strong, nonatomic) PosBenefitDetailModel   *mPosModel;

@property (strong, nonatomic) PosBenefitDetailModel   *tranditionPosModel;

@property (strong, nonatomic) PosBenefitDetailModel   *ePosModel;

@property (strong, nonatomic) ProfitTopView* header;

@property (strong, nonatomic) NSString* dateStr;

@end

@implementation ProfitVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)updateUI{
    NSInteger index = [self getIndexScrollView];
    [self.dataSource removeAllObjects];
    if (index == 0) {
        [self.dataSource addObject: @{@"title":@"收益类型",@"text":@"金额(元)"}];
        [self.dataSource addObject:  @{@"title":@"分润",@"text":self.mPosModel.share_benefit,@"btn":@"明细>",@"vc":@"lcwl://FenRunDetailVC"}];
        [self.dataSource addObject: @{@"title":@"激活返现",@"text":self.mPosModel.return_benefit,@"btn":@"明细>",@"vc":@"lcwl://FenRunDetailVC2",@"type":@"jhfx"}];
        [self.dataSource addObject:@{@"title":@"活动奖励",@"text":self.mPosModel.activity_benefit,@"btn":@"明细>",@"vc":@"lcwl://FenRunDetailVC2",@"type":@"hdjl"}];
        if ([AppUserModel.algebra isEqualToString:@"1"]) {
            [self.dataSource addObject:@{@"title":@"考核未达标扣除",@"text":self.mPosModel.deduct_money,@"btn":@"明细>",@"vc":@"lcwl://FenRunDetailVC2",@"type":@"khwdbkc"}];
        }
    }else if(index == 1){
        [self.dataSource addObject: @{@"title":@"收益类型",@"text":@"金额(元)"}];
        [self.dataSource addObject:  @{@"title":@"分润",@"text":self.tranditionPosModel.share_benefit,@"btn":@"明细>",@"vc":@"lcwl://FenRunDetailVC"}];
        [self.dataSource addObject: @{@"title":@"激活返现",@"text":self.tranditionPosModel.return_benefit,@"btn":@"明细>",@"vc":@"lcwl://FenRunDetailVC2",@"type":@"jhfx"}];
        [self.dataSource addObject:@{@"title":@"活动奖励",@"text":self.tranditionPosModel.activity_benefit,@"btn":@"明细>",@"vc":@"lcwl://FenRunDetailVC2",@"type":@"hdjl"}];
        if ([AppUserModel.algebra isEqualToString:@"1"]) {
            [self.dataSource addObject:@{@"title":@"考核未达标扣除",@"text":self.tranditionPosModel.deduct_money,@"btn":@"明细>",@"vc":@"lcwl://FenRunDetailVC2",@"type":@"khwdbkc"}];
        }
    }else if(index == 2){
        [self.dataSource addObject: @{@"title":@"收益类型",@"text":@"金额(元)"}];
        [self.dataSource addObject:  @{@"title":@"分润",@"text":self.ePosModel.share_benefit,@"btn":@"明细>",@"vc":@"lcwl://FenRunDetailVC"}];
        [self.dataSource addObject: @{@"title":@"激活返现",@"text":self.ePosModel.return_benefit,@"btn":@"明细>",@"vc":@"lcwl://FenRunDetailVC2",@"type":@"jhfx"}];
        [self.dataSource addObject:@{@"title":@"活动奖励",@"text":self.ePosModel.activity_benefit,@"btn":@"明细>",@"vc":@"lcwl://FenRunDetailVC2",@"type":@"hdjl"}];
        if ([AppUserModel.algebra isEqualToString:@"1"]) {
            [self.dataSource addObject:@{@"title":@"考核未达标扣除",@"text":self.ePosModel.deduct_money,@"btn":@"明细>",@"vc":@"lcwl://FenRunDetailVC2",@"type":@"khwdbkc"}];
        }
    }
    [self.tableView reloadData];
}

-(void)initUI{
    [self setNavBarTitle:@"收益中心"];
    self.dateStr = [NSDate dateString:[NSDate date] format:@"yyyy-MM"];
    self.dataSource = [[NSMutableArray alloc]initWithCapacity:10];
    [self tableView];
    @weakify(self)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        @strongify(self)
        [self initData];
        [self.tableView.header endRefreshing];
    }];
    self.header = [[ProfitTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    [self.header az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"#1AAE8F"],[UIColor colorWithHexString:@"#1CCC9A"]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    self.tableView.tableHeaderView = self.header;
    self.header.block = ^(id data) {
        [MXRouter openURL:@"lcwl://CashOutVC"];
    };
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    [self getHeaderInformation:@{} completion:^(id object, NSString *error) {
        if (object) {
            self.headerModel = object;
            [self.header reloadToday_benefit:self.headerModel.today_benefit withdraw_money:self.headerModel.withdraw_money total_benefit:self.headerModel.total_benefit settle_money:self.headerModel.settle_money];
        }
    }];
    [self getBenefitCentreMposDetail];
    [self getBenefitCentreTraditionalPosDetail];
    [self getBenefitCentreEPosDetail];
}

-(void)getBenefitCentreMposDetail{
    [self getBenefitCentreMposDetail:@{@"date":[self.dateStr stringByReplacingOccurrencesOfString:@"-" withString:@""]} completion:^(id object, NSString *error) {
        if (object) {
            self.mPosModel = object;
            self.mPosModel.type = @"MPOS";
            [self updateUI];
        }
    }];
}

-(void)getBenefitCentreTraditionalPosDetail{
    [self getBenefitCentreTraditionalPosDetail:@{@"date":[self.dateStr stringByReplacingOccurrencesOfString:@"-" withString:@""]} completion:^(id object, NSString *error) {
        if (object) {
            self.tranditionPosModel = object;
            self.tranditionPosModel.type = @"CTPOS";
            [self updateUI];
        }
    }];
}


-(void)getBenefitCentreEPosDetail{
    [self getBenefitCentreEPosDetail:@{@"date":[self.dateStr stringByReplacingOccurrencesOfString:@"-" withString:@""]} completion:^(id object, NSString *error) {
        if (object) {
            self.ePosModel = object;
            self.ePosModel.type = @"EPOS";
            [self updateUI];
        }
    }];
}


- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index{
    
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 160;
    }
    return 44;
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
    return [[UIView alloc]init];
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierHeader];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifierHeader];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.pageView =  [[OTPageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 160)];
            self.pageView.pageScrollView.frame = CGRectMake(15, 5, ( [[UIScreen mainScreen] bounds].size.width-45), 150);
            self.pageView.pageScrollView.dataSource = self;
            self.pageView.pageScrollView.delegate = self;
            self.pageView.pageScrollView.padding =15;
            self.pageView.pageScrollView.leftRightOffset = 0;
            
            [cell.contentView addSubview:self.pageView];
        }
        [self.pageView.pageScrollView reloadData];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierNormal];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifierNormal];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ProfitFormView* tmp = [[ProfitFormView alloc]initWithFrame:CGRectZero];
        tmp.tag = 101;
        [cell.contentView addSubview:tmp];
        [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    ProfitFormView* tmp = [cell.contentView viewWithTag:101];
    if (indexPath.row == 0) {
        tmp.typeLbl.textColor = [UIColor moPlaceHolder];
        tmp.moneyLbl.textColor = [UIColor moPlaceHolder];
        tmp.line.hidden = NO;
    }else{
        tmp.typeLbl.textColor = [UIColor moBlack];
        tmp.moneyLbl.textColor = [UIColor moBlack];
        tmp.line.hidden = YES;
    }
    NSDictionary* dict =  self.dataSource[indexPath.row];
    [tmp reloadData:dict[@"title"] money:dict[@"text"] btnTitle:dict[@"btn"]];
    return cell;
   
}

- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView{
    return 3;
}

- (UIView*)pageScrollView:(OTPageScrollView*)pageScrollView viewForRowAtIndex:(int)index{
    ProfitView* view = [[ProfitView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    if (index == 0) {
        [view reload:self.mPosModel dateString:self.dateStr];
    }else if(index == 1){
        [view reload:self.tranditionPosModel dateString:self.dateStr];
    }else if(index == 2){
        [view reload:self.ePosModel dateString:self.dateStr];
    }
    @weakify(self)
    view.block = ^(id data) {
        @strongify(self)
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
        datePickManager.style = PGDatePickManagerStyleAlertBottomButton;
        datePickManager.isShadeBackground = true;
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.isHiddenMiddleText = false;
        datePicker.delegate = self;
        datePicker.datePickerType = PGDatePickerTypeSegment;
        datePicker.datePickerMode = PGDatePickerModeYearAndMonth;
        [self presentViewController:datePickManager animated:false completion:nil];
    };
    return view;
}

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents{

    
    self.dateStr = [NSDate componentsToString:dateComponents format:@"yyyy-MM"];
    [self getBenefitCentreMposDetail];
    [self getBenefitCentreTraditionalPosDetail];
    [self getBenefitCentreEPosDetail];
    
}

-(NSInteger)getIndexScrollView{
    NSInteger index = self.pageView.pageScrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width-60);
    return index;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateUI];
//    if (scrollView == self.pageView.pageScrollView) {
//        NSIndexSet *reloadSet = [NSIndexSet indexSetWithIndex:1];
//        [self.tableView reloadSections:reloadSet withRowAnimation:UITableViewRowAnimationNone];
//    }
//    NSLog(@"%s",__FUNCTION__);
}

- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView
{
    int width = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake((width-45), 150);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        NSDictionary* dict =  self.dataSource[indexPath.row];
        NSString* vcString = dict[@"vc"];
        if (![StringUtil isEmpty:vcString]) {
            NSString* param = [NSString stringWithFormat:@"%@明细",dict[@"title"]];
             NSInteger index = [self getIndexScrollView];
            NSString* type = @"MPOS";
            if (index == 1) {
                type = @"CTPOS";
            }else if(index == 2){
                type = @"EPOS";
            }
            NSString* date = [self.dateStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
            [MXRouter openURL:vcString parameters:@{@"navTitle":param,@"date":date,@"type":type,@"subType":dict[@"type"]}];
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
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _tableView;
}


@end
