//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "NoticeVC.h"
#import "TextTextTextView.h"
#import "PersonalCenterHelper.h"
#import "MessageRecordModel.h"
@interface NoticeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSString *last_id;

@end

@implementation NoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI{
    // Do any additional setup after loading the view.
    [self setNavBarTitle:@"公告" color:[UIColor whiteColor]];
    self.dataSource = @[];
    [self.view addSubview:self.tableView];
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    [PersonalCenterHelper getMessageRecordList:@{@"last_id":self.last_id} completion:^(id array, NSString *error) {
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
            
            MessageRecordModel* lastObject = self.dataSource.lastObject;
            self.last_id = lastObject.message_id;
        }
    }];
    @weakify(self)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        @strongify(self)
        self.last_id = @"";
        [PersonalCenterHelper getMessageRecordList:@{@"last_id":self.last_id} completion:^(id array, NSString *error) {
            [self.tableView.header endRefreshing];
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                MessageRecordModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.message_id;
            }
        }];
    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        @strongify(self)
        [PersonalCenterHelper getMessageRecordList:@{@"last_id":self.last_id} completion:^(id array, NSString *error) {
            [self.tableView.footer endRefreshing];
            if (array) {
                [self.dataSource addObjectsFromArray:array];
                [self.tableView reloadData];
                MessageRecordModel* lastObject = self.dataSource.lastObject;
                self.last_id = lastObject.message_id;
            }
        }];
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
        TextTextTextView* view = [[TextTextTextView alloc]init];
        view.tip.textColor = [UIColor moGreen];
        view.tag = 101;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view];
        cell.backgroundColor = [UIColor clearColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    TextTextTextView* view = [cell.contentView viewWithTag:101];
    MessageRecordModel* model = self.dataSource[indexPath.row];
    [view reloadTop:@"您有一笔收益到账" bottom:model.cre_datetime right:[NSString stringWithFormat:@"%@元",model.money]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageRecordModel* model = self.dataSource[indexPath.row];
    [MXRouter openURL:@"lcwl://NoticeDetailVC" parameters:@{@"message_id":model.message_id}];
    
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
