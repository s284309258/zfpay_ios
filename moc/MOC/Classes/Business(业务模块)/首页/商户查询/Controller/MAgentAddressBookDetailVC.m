//
//  CTAgentAddressBookDetailVC.m
//  XZF
//
//  Created by mac on 2019/8/23.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "MAgentAddressBookDetailVC.h"
#import "AgentAddressBookDetailView.h"
#import "YNPageScrollMenuView.h"
#import "YNPageConfigration.h"
#import "ImgTextTextView.h"
#import "NSObject+Home.h"
#import "ReferAgencyPosModel.h"
#import "QNManager.h"
#import "ReferAgencyNumModel.h"
#import "NSDate+String.h"
#import "PGDatePickManager.h"
@interface MAgentAddressBookDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) AgentAddressBookDetailView* addressBook;

@property (nonatomic,strong) YNPageScrollMenuView *menu;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) ReferAgencyNumModel *headerDict;

@property (strong, nonatomic) NSString *trade_status;

@property (strong, nonatomic) NSString *last_id;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (nonatomic , strong) NSString* dateStr;

@end

@implementation MAgentAddressBookDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
}

-(void)initUI{
    self.dateStr = [NSDate dateString:[NSDate date] format:@"yyyy-MM"];
    [self addressBook];
    [self menu];
    [self tableView];
    @weakify(self)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        @strongify(self)
        self.last_id = @"";
        [self getReferAgencyMposList:@{@"user_id":self.model.user_id,@"last_id":self.last_id,@"trade_status":self.trade_status} completion:^(id array, NSString *error) {
            [self.tableView.header endRefreshing];
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                ReferAgencyPosModel* model = self.dataSource.lastObject;
                self.last_id = model.mpos_id;
            }
            
        }];
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        @strongify(self)
        [self getReferAgencyMposList:@{@"user_id":self.model.user_id,@"last_id":self.last_id,@"trade_status":self.trade_status} completion:^(id array, NSString *error) {
            [self.tableView.footer endRefreshing];
            if (array) {
                [self.dataSource addObjectsFromArray:array];
                [self.tableView reloadData];
                ReferAgencyPosModel* model = self.dataSource.lastObject;
                self.last_id = model.mpos_id;
            }
            
        }];
    }];
    [self switchData:0];
    [self.addressBook reloadMonth:self.dateStr];
    [self requestMonthData];
    
}

-(void)requestMonthData{
    NSString* month_param = [self.dateStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [self getReferAgencyMPosTradeAmountAvg:@{@"cre_month":month_param,@"user_id":self.model.user_id} completion:^(id object, NSString *error) {
        if (object) {
            NSString* avg_performance = [object valueForKeyPath:@"avg_performance"];
            NSString* merchant_performance = [object valueForKeyPath:@"merchant_performance"];
            NSString* str = [NSString stringWithFormat:@"月交易额:%@ 月台均:%@",merchant_performance,avg_performance];
            [self.addressBook reloadTrade:str];
            
        }
    }];
}

-(void)initData{
    self.dataSource = @[];
    @weakify(self)
    [self getReferAgencyHeadMposInfo:@{@"user_id":self.model.user_id} completion:^(id object, NSString *error) {
        @strongify(self)
        if (object) {
            self.headerDict = object;
            
            NSString* name = [NSString stringWithFormat:@"%@\n%@",self.model.real_name,self.model.user_tel];
             NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:@""];
             {
                 NSString* str1 = [NSString stringWithFormat:@"MPOS共计%@台",self.headerDict.m_pos_num];
                 NSMutableAttributedString* attr1 = [[NSMutableAttributedString alloc]initWithString:str1];
                 [attr1 addFont:[UIFont font12] substring:str1];
                 [attr1 addColor:[UIColor moBlack] substring:str1];
                 [attr appendAttributedString:attr1];
             }
             {
                 NSString* str1 = [NSString stringWithFormat:@" 已激活%@",self.headerDict.m_act_num];
                  NSMutableAttributedString* attr1 = [[NSMutableAttributedString alloc]initWithString:str1];
                  [attr1 addColor:[UIColor lightGrayColor] substring:@"已激活"];
                  [attr1 addFont:[UIFont font11] substring:@"已激活"];
                  [attr1 addColor:[UIColor moGreen] substring:self.headerDict.m_act_num];
                  [attr1 addFont:[UIFont font11] substring:self.headerDict.m_act_num];
                  [attr appendAttributedString:attr1];
            }
             {
                  NSString* str1 = [NSString stringWithFormat:@" 未激活%@",self.headerDict.m_inact_num];
                   NSMutableAttributedString* attr1 = [[NSMutableAttributedString alloc]initWithString:str1];
                   [attr1 addColor:[UIColor lightGrayColor] substring:@"未激活"];
                   [attr1 addFont:[UIFont font11] substring:@"未激活"];
                   [attr1 addColor:[UIColor moRed] substring:self.headerDict.m_inact_num];
                   [attr1 addFont:[UIFont font11] substring:self.headerDict.m_inact_num];
                   [attr appendAttributedString:attr1];
             }
             [self.addressBook reload:self.model.head_photo name:name merchant:self.headerDict.pos_num money:self.headerDict.performance tipAttr:attr];
            
            
            
            NSString* pos_num = [NSString stringWithFormat:@"全部(%@)",self.headerDict.pos_num];
            NSString* trade_num = [NSString stringWithFormat:@"已交易(%@)",self.headerDict.trade_num];
            NSString* untrade_num = [NSString stringWithFormat:@"未交易(%d)",([self.headerDict.pos_num intValue]-[self.headerDict.trade_num intValue])];
            [self.menu updateTitles:@[pos_num,trade_num,untrade_num]];
        }
    }];
    
}

-(AgentAddressBookDetailView* )addressBook{
    if (!_addressBook) {
        _addressBook = [AgentAddressBookDetailView new];
        _addressBook.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_addressBook];
        _addressBook.telBlock = ^(id data) {
            if ([StringUtil isEmpty:self.model.user_tel]) {
                return ;
            }
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.user_tel]]];
        };
        [self.addressBook mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.equalTo(@(150));
        }];
        
        _addressBook.dateBlock = ^{
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
    }
    return _addressBook;
}

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents{
    self.dateStr = [NSString stringWithFormat:@"%ld-%ld",dateComponents.year,dateComponents.month];
    [self.addressBook reloadMonth:self.dateStr];
    [self requestMonthData];
}


-(YNPageScrollMenuView*)menu{
    if(!_menu){
        YNPageConfigration *configration = [YNPageConfigration defaultConfig];
        configration.pageStyle = YNPageStyleSuspensionTop;
        configration.headerViewCouldScale = YES;
        configration.showTabbar = NO;
        configration.showNavigation = YES;
        configration.scrollMenu = NO;
        configration.aligmentModeCenter = NO;
        configration.lineWidthEqualFontWidth = YES;
        configration.showBottomLine = YES;
        configration.bottomLineBgColor = [UIColor clearColor];
        configration.itemFont = [UIFont font14];
        configration.selectedItemFont = [UIFont font14];
        configration.lineColor = [UIColor moGreen];
        configration.converColor = [UIColor clearColor];
        configration.selectedItemColor = [UIColor moGreen];
        configration.normalItemColor = [UIColor moBlack];
        configration.bottomLineHeight = 0.5;
        configration.menuHeight = 38;
        
        configration.scrollViewBackgroundColor = [UIColor whiteColor];
        _menu = [YNPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38) titles: @[@"全部",@"已交易",@"未交易"]  configration:configration delegate:self currentIndex:0];
        [self.view addSubview:_menu];
        [self.menu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.addressBook.mas_bottom).offset(10);
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(38));
        }];
    }
    return _menu;
}

- (void)pagescrollMenuViewItemOnClick:(UIButton *)button index:(NSInteger)index{
    [self switchData:index];
}

-(void)switchData:(NSInteger)index{
    self.last_id = @"";
    if (index == 0) {
        self.trade_status = nil;
    }else if(index == 1){
        self.trade_status = @"1";
    }else if(index == 2){
        self.trade_status = @"0";
    }
    [self getReferAgencyMposList:@{@"user_id":self.model.user_id,@"last_id":self.last_id,@"trade_status":self.trade_status} completion:^(id array, NSString *error) {
        [self.tableView.header endRefreshing];
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
            ReferAgencyPosModel* model = self.dataSource.lastObject;
            self.last_id = model.mpos_id;
        }
        
    }];
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
            make.top.equalTo(self.menu.mas_bottom);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
        AdjustTableBehavior(self.tableView);
    }
    return _tableView;
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ImgTextTextView* view = [[ImgTextTextView alloc]init];
        view.desc.font = [UIFont systemFontOfSize:13];
        view.desc.textColor = [UIColor moPlaceHolder];
        view.tag = 101;
        [cell.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
        UILabel* lbl = [UILabel new];
               lbl.textColor = [UIColor moGreen];
               lbl.text = @"代";
               lbl.tag = 102;
               lbl.font = [UIFont font11];
               [cell.contentView addSubview:lbl];
               [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.right.equalTo(cell.contentView).offset(-15);
                   make.width.height.equalTo(@(20));
                   make.centerY.equalTo(cell.contentView);
               }];
    }
    ImgTextTextView* view = [cell.contentView viewWithTag:101];
    ReferAgencyPosModel* model = self.dataSource[indexPath.row];
    //    NSString*url = [QNManager shared].qnHost
    NSString* sn = [NSString stringWithFormat:@"SN码:%@",model.sn];
    NSString* name = ([StringUtil isEmpty:model.mer_name]?@"--":model.mer_name);
    NSString* desc = [NSString stringWithFormat:@"商户名字：%@\n交易额:￥%@",name,model.performance];
    [view reloadLeft:@"" top:sn bottom:desc];
    [view setImageSize:CGSizeMake(40, 40)];
    
         UIView* delegate = [cell.contentView viewWithTag:102];
    if ([model.state_status isEqualToString:@"0"]) {
        delegate.hidden = NO;
    }else{
        delegate.hidden = YES;
    }
    return cell;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReferAgencyPosModel* model = self.dataSource[indexPath.row];
    [MXRouter openURL:@"lcwl://MerchantDetailVC" parameters:@{@"type":@"MPOS",@"sn":model.sn}];
}
@end
