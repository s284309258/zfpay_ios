//
//  CTStandardMerchantVC.m
//  XZF
//
//  Created by mac on 2019/12/20.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "CTStandardMerchantVC.h"
#import "StandardMerchantCell.h"
#import "NSObject+Home.h"
#import "PolicyRecordModel.h"
#import "RewardOverlayView.h"
static NSString* identifier = @"cell";
@interface CTStandardMerchantVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UIView *topView;

@end

@implementation CTStandardMerchantVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self initData];
}

-(void)setupUI{
    [self setNavBarTitle:Lang(@"交易达标商户") color:[UIColor moBlack]];
    self.dataSource = @[];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@(0));
        make.height.equalTo(@(35));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(35, 0, 0, 0));
    }];
}

-(void)initData{
    [self selectPolicy3Record:@{@"pos_type":self.pos_type} completion:^(id object, NSString *error) {
        if (object) {
            self.dataSource = object;
            [self.tableView reloadData];
        }
    }];
}

-(UIView*)topView{
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor colorWithHexString:@"#FFEBE0"];
        UILabel* tipLbl = [UILabel new];
        tipLbl.font = [UIFont systemFontOfSize:13];
        tipLbl.textAlignment = NSTextAlignmentCenter;
        tipLbl.text = @"*温馨提示：交易量达标奖励只可领取一次，不可重复领取";
        tipLbl.textColor = [UIColor moOrange];
        [_topView addSubview:tipLbl];
        [tipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(15));
            make.right.equalTo(@(-15));
            make.top.bottom.equalTo(@(0));
        }];
    }
    return _topView;
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[StandardMerchantCell class] forCellReuseIdentifier:identifier];
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];;
}


#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StandardMerchantCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    @weakify(self)
    cell.rewardView.click = ^(id data) {
        @strongify(self)
        PolicyRecordModel* model = self.dataSource[indexPath.section];
        PolicyModel* tmp = data;

        float quantity = [tmp.policy_quantity floatValue]/10000;
        
        [RewardOverlayView showInView:[UIApplication sharedApplication].keyWindow text:[NSString stringWithFormat:@"达标%.2f万,奖励%@元",quantity,tmp.policy_amount] confirm:^{
            [RewardOverlayView hiddenInView:[UIApplication sharedApplication].keyWindow];
            PolicyModel* tmpModel = data;
            [self chooseAward:@{@"mer_id":model.mer_id,@"mer_name":model.mer_name,@"id":tmpModel.id} completion:^(BOOL success, NSString *error) {
                if (success) {
                    [self initData];
                }
            }];
        } cancel:^{
            [RewardOverlayView hiddenInView:[UIApplication sharedApplication].keyWindow];
        }];
        return ;
        
    };
    PolicyRecordModel* model = self.dataSource[indexPath.section];
    [cell reload:model];
//    if (indexPath.section %2 == 0) {
//        [cell reload:@"深圳市金盛和" no:@"74837878423992" money:@"883437.00" date:@"135天" data:@[@"1",@"2",@"3",@"2",@"3",@"2",@"3"]];
//    }else{
//        [cell reload:@"深圳市金盛和实业有限公司" no:@"74837878423992" money:@"883437.00" date:@"135天"data:@[@"1",@"2",@"3",@"2"]];
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
