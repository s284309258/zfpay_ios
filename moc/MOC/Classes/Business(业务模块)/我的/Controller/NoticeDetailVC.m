//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "NoticeDetailVC.h"
#import "NoticeView.h"
#import "PersonalCenterHelper.h"
#import "MessageRecordDetailModel.h"
static NSString* reuseIdentifierBar = @"fenrun";
@interface NoticeDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation NoticeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    
}

-(void)initUI{
    [self setNavBarTitle:@"通知详情"];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[NoticeView class] forCellReuseIdentifier:reuseIdentifierBar];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    self.dataSource = @[];
    [PersonalCenterHelper getMessageRecordDetail:@{@"message_id":self.message_id} completion:^(BOOL success, id object, NSString *error) {
        if (success) {
            self.dataSource = object;
            [self.tableView reloadData];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoticeView* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBar forIndexPath:indexPath];
    if (!cell) {
        cell = [[NoticeView alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierBar];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MessageRecordDetailModel* model = self.dataSource[indexPath.row];
    [cell reload:model];
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


@end
