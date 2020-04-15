//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "NoticeVC2.h"
#import "ImgTextTextView.h"
#import "PersonalCenterHelper.h"
#import "NoticeModel.h"
@interface NoticeVC2 ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (nonatomic) NSInteger *pageNum;

@end

@implementation NoticeVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI{
    self.pageNum = 1;
    [self setNavBarTitle:@"公告"];
    self.dataSource = @[];
    [self.view addSubview:self.tableView];
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    [PersonalCenterHelper getNoticeList:@{@"pageNum":[StringUtil integerToString:self.pageNum]} completion:^(id array, NSString *error) {
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
            
            NoticeModel* lastObject = self.dataSource.lastObject;
        }
    }];
    @weakify(self)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        @strongify(self)
        self.pageNum = 1;
        [PersonalCenterHelper getNoticeList:@{@"pageNum":[StringUtil integerToString:self.pageNum]} completion:^(id array, NSString *error) {
            [self.tableView.header endRefreshing];
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
            }
        }];
    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        @strongify(self)
        self.pageNum++;
        [PersonalCenterHelper getNoticeList:@{@"pageNum":[StringUtil integerToString:self.pageNum]} completion:^(id array, NSString *error) {
            [self.tableView.footer endRefreshing];
            if (array) {
                [self.dataSource addObjectsFromArray:array];
                [self.tableView reloadData];
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
        ImgTextTextView* view = [[ImgTextTextView alloc]init];
        view.desc.textColor = [UIColor moPlaceHolder];
        view.desc.font = [UIFont systemFontOfSize:13];
        view.tag = 101;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        MXSeparatorLine*line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
        [view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(1));
            make.left.right.equalTo(view);
            make.bottom.equalTo(view);
        }];
        [cell.contentView addSubview:view];
        
        cell.backgroundColor = [UIColor clearColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    ImgTextTextView* view = [cell.contentView viewWithTag:101];
    NoticeModel* model = self.dataSource[indexPath.row];
    [view reloadLeft:@"通知" top:model.notice_title bottom:model.cre_date];
    [view setImageSize:CGSizeMake(40, 40)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NoticeModel* model = self.dataSource[indexPath.row];
    [MXRouter openURL:@"lcwl://NoticeInfoVC" parameters:@{@"notice_id":model.notice_id}];
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
