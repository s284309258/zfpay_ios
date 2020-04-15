//
//  PersonalCenterVC.m
//  AdvertisingMaster
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RFHomeVC.h"
#import "RFTopView.h"
#import "RFHeader.h"
#import "RFCellView.h"
#import "NSObject+RF.h"
#import "RFPosDetailModel.h"
#import "PersonalCenterHelper.h"
#import "NewRFCellView.h"
static NSInteger padding = 15;
@interface RFHomeVC ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView    *tableView;

@property(nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic, strong) RFTopView *topView;

@property(nonatomic, strong) NSArray *headerData;

@property(nonatomic, strong) RFPosDetailModel* trapos;

@property(nonatomic, strong) RFPosDetailModel* mpos;

@property(nonatomic, strong) RFPosDetailModel* epos;

@property(nonatomic) BOOL isOpen;


@end

@implementation RFHomeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.topView reload:AppUserModel.real];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
- (void)updateUI {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavBarTitle:@"报表中心"];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        @strongify(self)
        [self.tableView.header endRefreshing];
        [self initData];
    }];
    
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    backView.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
    self.topView = [[RFTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    self.topView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:self.topView];
    self.tableView.tableHeaderView = backView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(@(-(TabbarHeight)));
    }];
    
}


-(void)initData{
    
    self.headerData = @[@{@"color":@"#5B79E6",@"left":@"传统POS",@"right":@"查看详情>"},
                        @{@"color":@"#01C088",@"left":@"MPOS",@"right":@"查看详情>"},
                        @{@"color":@"#FFA640",@"left":@"EPOS",@"right":@"查看详情>"}];
    [self getHomePageInfo:@{} completion:^(id array, NSString *error) {
        if (array) {
            NSArray* tmpArray = array;
            self.trapos = tmpArray[0];
            self.mpos = tmpArray[1];
            self.epos = tmpArray[2];
//            [self.topView reloadCTPos:self.trapos.pos_avg mPos:self.mpos.pos_avg];
             [self.tableView reloadData];
        }
    }];
    [PersonalCenterHelper getUserAuthStatus:@{} completion:^(BOOL success, id object, NSString *error) {
        if (success) {
             RealNameModel *tmp = object;
             AppUserModel.real = tmp;
            [self.topView reload:tmp];
            [self.tableView reloadData];
        }
   }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        _tableView.tableFooterView = footer;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        AdjustTableBehavior(_tableView);
    }
    
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.headerData.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 1;
    }else if(section == 2){
        return 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* identifier = [NSString stringWithFormat:@"%ld %ld",indexPath.section,indexPath.row];
    if (indexPath.section == 0) {
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
         if(cell == nil) {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
             NewRFCellView* view = [[NewRFCellView alloc]initWithFrame:CGRectZero];
             view.layer.cornerRadius = 5;
             view.backgroundColor = [UIColor colorWithHexString:@"#A157EE"];
             view.tag = 101;
             [cell.contentView addSubview:view];
             [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, padding, 0, padding));
             }];
             @weakify(self)
             view.open = ^{
                 @strongify(self)
                 self.isOpen = !self.isOpen;
                 [self.tableView reloadData];
             };
         }
        NewRFCellView* view = [cell.contentView viewWithTag:101];
        [view reload:AppUserModel.real];
        [view reloadCTPos:self.trapos.pos_avg mPos:self.mpos.pos_avg ePos:self.epos.pos_avg];
        
         return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        RFCellView* view = [[RFCellView alloc]initWithFrame:CGRectZero];
        view.tag = 101;
        [cell.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
           make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, padding, 0, padding));
        }];
    }
    RFCellView* view = [cell.contentView viewWithTag:101];
    if (indexPath.section == 1) {
        [view reloadBack:@"蓝卡" title:@"本月累计交易额(元)" desc:self.trapos.performance sub:@"本日新增商户" subDesc:self.trapos.act_num_day sub1:@"本月新增商户" subDesc:self.trapos.act_num sub2:@"累计商户" subDesc:self.trapos.pos_num];
    }else if(indexPath.section == 2){
        [view reloadBack:@"绿卡" title:@"本月累计交易额(元)" desc:self.mpos.performance sub:@"本日新增商户" subDesc:self.mpos.act_num_day sub1:@"本月新增商户" subDesc:self.mpos.act_num sub2:@"累计商户" subDesc:self.mpos.pos_num];
    }else if(indexPath.section == 3){
        [view reloadBack:@"黄卡" title:@"本月累计交易额(元)" desc:self.epos.performance sub:@"本日新增商户" subDesc:self.epos.act_num_day sub1:@"本月新增商户" subDesc:self.epos.act_num sub2:@"累计商户" subDesc:self.epos.pos_num];
    }
   
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.isOpen) {
            return 150;
        }
        return 100;
    }
    return 150;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [MXRouter openURL:@"lcwl://CTPosYJVC"];
    }else if(indexPath.section == 2){
        [MXRouter openURL:@"lcwl://MPosYJVC"];
    }else if(indexPath.section == 3){
        [MXRouter openURL:@"lcwl://EPosYJVC"];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [UIView new];
    }
    __block UIView* headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    RFHeader *header = [[RFHeader alloc]init];
    header.block = ^(id data) {
        if (section == 1) {
            [MXRouter openURL:@"lcwl://CTPosYJVC"];
        }else if(section == 2){
            [MXRouter openURL:@"lcwl://MPosYJVC"];
        }else if(section == 3){
            [MXRouter openURL:@"lcwl://EPosYJVC"];
        }
        
        
    };
    [headerView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headerView);
        make.left.equalTo(headerView).offset(padding);
        make.right.equalTo(headerView).offset(-padding);
    }];
    NSDictionary* dict = self.headerData[section-1];
    [header reloadColor:dict[@"color"] left:dict[@"left"] right:dict[@"right"]];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return [RFHeader getHeight];
}


@end
