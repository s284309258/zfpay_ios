//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "ActivitiesOrderDetailVC.h"
#import "CTRewardCell.h"
#import "ActivitiesOrderView.h"
#import "RFHeader.h"
#import "NSObject+Home.h"
static NSString* reuseIdentifierBar = @"fenrun";
@interface ActivitiesOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (nonatomic) BOOL isOpen;

@property (strong, nonatomic) UIButton *submitBtn;

@property (strong, nonatomic) ActivitiesOrderView* header;

@property (strong, nonatomic) PosActivityApplyDetailModel* model;

@end

@implementation ActivitiesOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavBarTitle:@"活动订单详情"];
    self.dataSource = [[NSMutableArray alloc]initWithCapacity:10];
    [self tableView];
    
    self.header = [[ActivitiesOrderView alloc]init];
    self.header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    self.tableView.tableHeaderView = self.header;
    
    //    [self.tableView registerClass:[CTRewardCell class] forCellReuseIdentifier:reuseIdentifierBar];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    AdjustTableBehavior(self.tableView);
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(44));
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.bottom.equalTo(self.view).offset(-SafeAreaBottomHeight);
    }];
}

-(void)initData{
    if ([self.type isEqualToString:@"0"]) {
        [self getTraditionalPosActivityApplyDetail:@{@"apply_id":self.apply_id} completion:^(id object, NSString *error) {
            if (object) {
                self.model = object;
                if ([self.model.status isEqualToString:@"00"]) {
                    self.submitBtn.hidden = NO;
                }
                [self.header reload:self.model];
                self.dataSource = [self.model.sn_list componentsSeparatedByString:@","];
                [self.tableView reloadData];
            }
        }];
    }else if([self.type isEqualToString:@"1"]){
        [self getMposActivityApplyDetail:@{@"apply_id":self.apply_id} completion:^(id object, NSString *error) {
            if (object) {
                self.model = object;
                if ([self.model.status isEqualToString:@"00"]) {
                    self.submitBtn.hidden = NO;
                }
                [self.header reload:self.model];
                self.dataSource = [self.model.sn_list componentsSeparatedByString:@","];
                [self.tableView reloadData];
            }
        }];
    }else if ([self.type isEqualToString:@"2"]) {
        [self getTraditionalPosActivityApplyDetail:@{@"apply_id":self.apply_id,@"pos_type":@"epos"} completion:^(id object, NSString *error) {
            if (object) {
                self.model = object;
                if ([self.model.status isEqualToString:@"00"]) {
                    self.submitBtn.hidden = NO;
                }
                [self.header reload:self.model];
                self.dataSource = [self.model.sn_list componentsSeparatedByString:@","];
                [self.tableView reloadData];
            }
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.isOpen) {
        return 0;
    }
    int count = self.dataSource.count/2+(self.dataSource.count%2==0?0:1);
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    RFHeader* header = [RFHeader new];
    header.block = ^(id data) {
        self.isOpen = !self.isOpen;
        [self.tableView reloadData];
    };
    
    [header reloadColor:@"#1CCC9A" left:[NSString stringWithFormat:@"参与活动的SN码(%d)",self.dataSource.count] right:!self.isOpen?@"展开>":@"收起>"];
    [header.rightLbl setTitleColor:!self.isOpen?[UIColor moGreen]:[UIColor moPlaceHolder] forState:UIControlStateNormal];
    [backView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(15);
        make.right.equalTo(backView).offset(-15);
        make.top.bottom.equalTo(backView);
    }];
    return backView;
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBar];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifierBar];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor moPlaceHolder];
        cell.detailTextLabel.textColor = [UIColor moPlaceHolder];
        cell.textLabel.font = [UIFont font14];
        cell.detailTextLabel.font = [UIFont font14];
    }
    NSString* title = self.dataSource[indexPath.row*2];
    cell.textLabel.text = [NSString stringWithFormat:@"SN:%@",title];;
    NSInteger index = indexPath.row*2+1;
    if (index >= self.dataSource.count) {
        cell.detailTextLabel.text = @"";
    }else{
        NSString* desc = [NSString stringWithFormat:@"SN:%@",self.dataSource[indexPath.row*2+1]];
        cell.detailTextLabel.text = desc;
    }
    
    return cell;
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

-(UIButton*)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"取消活动" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _submitBtn.backgroundColor = [UIColor darkGreen];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        _submitBtn.hidden = YES;
        [_submitBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(void)cancel:(id)sender{
    if ([self.type isEqualToString:@"0"]) {
        [self cancelTraditionalPosActivityApply:@{@"apply_id":self.apply_id} completion:^(BOOL success, NSString *error) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else if ([self.type isEqualToString:@"1"]) {
        [self cancelMposActivityApply:@{@"apply_id":self.apply_id} completion:^(BOOL success, NSString *error) {
             [self.navigationController popViewControllerAnimated:YES];
        }];
    }else if ([self.type isEqualToString:@"2"]) {
        [self cancelTraditionalPosActivityApply:@{@"apply_id":self.apply_id,@"pos_type":@"epos"} completion:^(BOOL success, NSString *error) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

@end
