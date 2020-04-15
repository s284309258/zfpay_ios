//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "CreditCardRateSliderVC.h"
#import "UIViewController+IIViewDeckAdditions.h"
#import "IIViewDeckController.h"
#import "NSObject+Home.h"
#import "RefererAgencyModel.h"
#import "ApplyScanPaySliderView.h"
@interface CreditCardRateSliderVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSString* selectStr;

@property (nonatomic,copy )NSString* fontTitle;

@end

@implementation CreditCardRateSliderVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    IIViewDeckController* tmp = [self viewDeckController];
    self.fontTitle = tmp.title;
    if ([self.subType isEqualToString:@"credit_card_rate"]) {
        tmp.title = @"刷卡费率";
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    IIViewDeckController* tmp = [self viewDeckController];
    tmp.title = self.fontTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI{
    self.dataSource = @[];
    self.selectStr = @"";
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    if ([self.type isEqualToString:@"MPOS"]) {
        [self getCreditCardRateList:@{} completion:^(id array, NSString *error) {
                  if (array) {
                      self.dataSource = (NSArray*)array;
                      [self.tableView reloadData];
                  }
              }];
    }else{
        NSMutableDictionary*param = [NSMutableDictionary dictionaryWithCapacity:10];
        if ([self.type isEqualToString:@"EPOS"]) {
            [param setObject:@"epos" forKey:@"pos_type"];
        }
        [self getCreditCardRateList:param completion:^(id array, NSString *error) {
            if (array) {
                self.dataSource = (NSArray*)array;
                [self.tableView reloadData];
            }
        }];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}


#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ApplyScanPaySliderView* view = [[ApplyScanPaySliderView alloc]init];
        view.tag = 101;
        [cell.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
    }
    ApplyScanPaySliderView* tmp = [cell.contentView viewWithTag:101];
    NSString* str = self.dataSource[indexPath.row];
    
    BOOL isSelected = NO;
    if ([self.selectStr isEqualToString:str]) {
        isSelected = YES;
    }
    [tmp reloadTitle:str select:isSelected];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectStr = self.dataSource[indexPath.row];
    [self.tableView reloadData];
    if (self.block) {
        self.block(self.selectStr);
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
            make.edges.mas_equalTo(self.view);
        }];
    }
    return _tableView;
}

@end
