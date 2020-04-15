//
//  MerchantTradeDetailVC.m
//  XZF
//
//  Created by mac on 2020/3/14.
//  Copyright © 2020 AlphaGo. All rights reserved.
//

#import "MerchantTradeDetailVC.h"
#import "MerchantTradeDetailCell.h"
#import "NSObject+Home.h"
static NSString* reuseIdentifierBar = @"identifier";
@interface MerchantTradeDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation MerchantTradeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupData];
}

-(void)setupUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self setNavBarTitle:@"交易信息"];
    [self.view addSubview:self.tableView];
    
}

-(void)setupData{
    @weakify(self)
    [self getTraditionalPosTradeDetail:@{@"sn":self.sn} completion:^(id array, NSString *error) {
        @strongify(self)
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
        }
    }];
}
- (UITableView *)tableView {
    if (_tableView) return _tableView;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_tableView registerClass:[MerchantTradeDetailCell class] forCellReuseIdentifier:reuseIdentifierBar];
       
    return _tableView;
}


#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MerchantTradeDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBar forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PosTradeModel* model = self.dataSource[indexPath.row];
    [cell reload:model];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    MerchantTradeDetailCell* tmpView = [MerchantTradeDetailCell new];
//    tmpView.moneyLbl.textColor = [UIColor lightGrayColor];
//    tmpView.timeLbl.textColor = [UIColor lightGrayColor];
//    tmpView.profitLbl.textColor = [UIColor lightGrayColor];
//
//    tmpView.backgroundColor = [UIColor whiteColor];
//    PosTradeModel* model = [PosTradeModel new];
//    model.trans_time = @"交易时间";
//    model.trans_amount = @"交易金额(元)";
//    model.benefit_money = @"贡献利润";
//    [tmpView reload:model];
//    return tmpView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 60;
//}
@end
