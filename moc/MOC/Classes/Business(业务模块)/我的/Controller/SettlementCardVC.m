//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "SettlementCardVC.h"
#import "BankCardView.h"
#import "NoBankCardView.h"
#import "PersonalCenterHelper.h"
#import "UserCardModel.h"
#import "YQPayKeyWordVC.h"
#import "MXAlertViewHelper.h"
#import "ProfitHelper.h"
@interface SettlementCardVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NoBankCardView *noView;

@end

@implementation SettlementCardVC

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
    [self setNavBarTitle:@"结算卡中心"];
    [self setNavBarRightBtnWithTitle:@"添加" andImageName:nil];
    self.dataSource = [[NSMutableArray alloc]initWithCapacity:10];
    [self tableView];
    AdjustTableBehavior(self.tableView);
}

-(void)initData{
    [ProfitHelper getUserCardList:@{} completion:^(id array, NSString *error) {
        if (array) {
            self.dataSource = array;
            if (self.dataSource.count == 0) {
                _tableView.hidden = YES;
                self.noView.hidden = NO;
                return ;
            }else{
                 _tableView.hidden = NO;
                self.noView.hidden = YES;
                
            }
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
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
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
        BankCardView* view = [[BankCardView alloc]init];
        view.tag = 101;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view];
        cell.backgroundColor = [UIColor clearColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(15, 15, 0, 15));
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    BankCardView* tmp = [cell.contentView viewWithTag:101];
    UserCardModel* model = self.dataSource[indexPath.row];
    tmp.deleteBlock = ^(id data) {
        [[YQPayKeyWordVC alloc] showInViewController:self type:NormalPayType dataDict:@{}  block:^(NSString * text) {
            [ProfitHelper updateUserCard:@{@"user_card_oper":@"user_card_del",
                                                   @"card_id":model.card_id,
                                                   @"pay_password":text
                                                   } completion:^(BOOL success, NSString *error) {
                                                       if (success) {
                                                           [self initData];
                                                       }
                                                   }];
        }];
    };
    [tmp reload:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self)
    [MXAlertViewHelper showAlertViewWithMessage:Lang(@"确定设置为默认银行卡?") title:Lang(@"提示") okTitle:Lang(@"确定") cancelTitle:Lang(@"取消") completion:^(BOOL cancelled, NSInteger buttonIndex) {
        @strongify(self);
        if (buttonIndex == 1) {
            UserCardModel* model = self.dataSource[indexPath.row];
            [ProfitHelper updateUserCard:@{@"user_card_oper":@"user_card_set",
                                                   @"card_id":model.card_id,
                                                   @"is_default":@"1"
                                                   } completion:^(BOOL success, NSString *error) {
                                                       if (success) {
                                                           [self initData];
                                                       }
                                                   }];
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
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _tableView;
}

-(NoBankCardView *)noView{
    if (!_noView) {
        _noView = [[NoBankCardView alloc]init];
        _noView.addBlock = ^(id data) {
//            if (!AppUserModel.real) {
                [PersonalCenterHelper getUserAuthStatus:@{} completion:^(BOOL success, id object, NSString *error) {
                    if (success) {
                        RealNameModel *tmp = object;
                        AppUserModel.real = tmp;
                        if ([tmp.auth_status isEqualToString:@"09"]) {
                            [MXRouter openURL:@"lcwl://BindBankVC"];
                        }else{
                            [NotifyHelper showMessageWithMakeText:@"请实名认证"];
                        }
                    }
                }];
//            }else{
//                RealNameModel *tmp = AppUserModel.real;
//                if ([tmp.auth_status isEqualToString:@"09"]) {
//                    [MXRouter openURL:@"lcwl://BindBankVC"];
//                }else{
//                    [NotifyHelper showMessageWithMakeText:@"请实名认证"];
//                }
//            }
        };
        [self.view addSubview:_noView];
        [_noView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(350));
            make.top.equalTo(self.view);
        }];
    }
    return _noView;
}

-(void)navBarRightBtnAction:(id)sender{
    if (!AppUserModel.real) {
        [PersonalCenterHelper getUserAuthStatus:@{} completion:^(BOOL success, id object, NSString *error) {
            if (success) {
                RealNameModel *tmp = object;
                AppUserModel.real = tmp;
                if ([tmp.auth_status isEqualToString:@"09"]) {
                    [MXRouter openURL:@"lcwl://BindBankVC"];
                }else{
                    [NotifyHelper showMessageWithMakeText:@"请实名认证"];
                }
            }
        }];
    }else{
        RealNameModel *tmp = AppUserModel.real;
        if ([tmp.auth_status isEqualToString:@"09"]) {
            [MXRouter openURL:@"lcwl://BindBankVC"];
        }else{
            [NotifyHelper showMessageWithMakeText:@"请实名认证"];
        }
    }
}
@end
