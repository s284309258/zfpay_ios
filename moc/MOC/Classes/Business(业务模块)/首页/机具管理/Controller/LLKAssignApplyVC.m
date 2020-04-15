//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "LLKAssignApplyVC.h"
#import "TextTextImgView.h"
#import "RefererAgencyModel.h"
#import "PosAgentSliderVC.h"
#import "UIViewController+IIViewDeckAdditions.h"
#import "IIViewDeckController.h"
#import "NSObject+Home.h"
@interface LLKAssignApplyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UIButton *submitBtn;

@property (strong, nonatomic) RefererAgencyModel *agency;
@end

@implementation LLKAssignApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarTitle:@"流量卡分配" ];
    self.dataSource = [[NSMutableArray alloc]initWithArray: @[@[
                                                                  @{@"title":@"代理伙伴",@"desc":@"请选择要分配的代理伙伴"}
                                                                  ]
                                                              
                                                              
                                                              ]];
    [self.view addSubview:self.tableView];
    AdjustTableBehavior(self.tableView);
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

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        TextTextImgView* view = [[TextTextImgView alloc]init];
        view.desc.textAlignment = NSTextAlignmentLeft;
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
    NSDictionary* dict = self.dataSource[indexPath.section][indexPath.row];
    NSString* agent = self.agency.real_name;
    if (![StringUtil isEmpty:agent]) {
        [view reloadImg:@"选择" title:dict[@"title"] desc:agent];
    }else{
        [view reloadImg:@"选择" title:dict[@"title"] desc:dict[@"desc"]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        PosAgentSliderVC* slider = [[PosAgentSliderVC alloc]init];
        slider.fontTitle = @"流量卡分配";
        slider.block = ^(id data) {
            RefererAgencyModel* tmp = data;
            self.agency = tmp;
            [self.tableView reloadData];
        };
        [self.viewDeckController setRightViewController:slider];
        [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    [self allocationTrafficCard:@{@"card_list":[self getPosStr:self.dataArray],@"acce_user_id":self.agency.user_id} completion:^(BOOL success, NSString *error) {
        if (success) {
            if (self.block) {
                self.block(nil);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

-(NSString*)getPosStr:(NSArray*)array{
    NSArray *unionOfObjects = [array valueForKeyPath:@"@unionOfObjects.card_no"];
    return [unionOfObjects componentsJoinedByString:@","];
}

@end
