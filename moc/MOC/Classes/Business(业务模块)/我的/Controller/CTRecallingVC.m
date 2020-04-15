//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "CTRecallingVC.h"
#import "RecallSelectView.h"
#import "RecallBottomView.h"
#import "NSObject+Home.h"
#import "ScanTraditionalPosModel.h"
@interface CTRecallingVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) RecallBottomView *bottom;

@property (strong, nonatomic) NSMutableArray *selectArray;

@end

@implementation CTRecallingVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
//    [self initData];
    
}

-(void)initUI{
    self.dataSource = [[NSMutableArray alloc]initWithCapacity:10];
    self.selectArray = [[NSMutableArray alloc]initWithCapacity:10];
    [self tableView];
    [self bottom];
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    [self getRecallTraditionalPosList:@{@"status":@"00"} completion:^(id array, NSString *error) {
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
        }
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        RecallSelectView* view = [[RecallSelectView alloc]init];
        view.tag = 101;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view];
        cell.backgroundColor = [UIColor clearColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    RecallSelectView* view = [cell.contentView viewWithTag:101];
    ScanTraditionalPosModel* model = self.dataSource[indexPath.row];
    BOOL isSelected = NO;
    if ([self.selectArray containsObject:model]) {
        isSelected = YES;
    }
    [view reload:isSelected?@"勾选":@"" title:[NSString stringWithFormat:@"SN码:%@",model.sn] desc:model.cre_datetime];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ScanTraditionalPosModel* model = self.dataSource[indexPath.row];
    BOOL bol  = [self.selectArray containsObject:model];
    //是否存在
    if (bol) {
        [self.selectArray removeObject:model];
    }else{
        [self.selectArray addObject:model];
    }
    [self.tableView reloadData];
//    if (self.block) {
//        self.block(self.selectArray);
//    }
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
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 55, 0));
        }];
    }
    return _tableView;
}

-(RecallBottomView*)bottom{
    if (!_bottom) {
        _bottom = [[RecallBottomView alloc]init];
        @weakify(self)
        _bottom.allBlock = ^(id data) {
            @strongify(self)
            if (self.bottom.btn.selected) {
                [self.selectArray removeAllObjects];
                [self.selectArray addObjectsFromArray:self.dataSource];
                [self.tableView reloadData];
            }else{
                [self.selectArray removeAllObjects];
                [self.tableView reloadData];
            }
            [self.bottom updateAllNum:self.selectArray.count];
        };
        _bottom.agreeBlock = ^(id data) {
            @strongify(self)
            [self dealRecallTraditionalPos:@{@"status":@"09",@"ids_list":[self getPosStr:self.selectArray]} completion:^(BOOL success, NSString *error) {
                if (success) {
                    [self initData];
                }
            }];
        };
        _bottom.disagreeBlock = ^(id data) {
            @strongify(self)
            [self dealRecallTraditionalPos:@{@"status":@"08",@"ids_list":[self getPosStr:self.selectArray]} completion:^(BOOL success, NSString *error) {
                if (success) {
                    [self initData];
                }
            }];
        };
        [self.view addSubview:_bottom];
        [_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
            make.height.equalTo(@(55));
        }];
    }
    return _bottom;
}

-(NSString*)getPosStr:(NSArray*)array{
    NSArray *unionOfObjects = [array valueForKeyPath:@"@unionOfObjects.recall_id"];
    return [unionOfObjects componentsJoinedByString:@","];
}
@end
