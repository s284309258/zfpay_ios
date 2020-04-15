//
//  CashOutVC.m
//  XZF
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "CashOutVC.h"
#import "CashOutHeader.h"
#import "CashOutTailer.h"
#import "YQPayKeyWordVC.h"
#import "HWBaseViewController.h"
#import <HWPanModal/HWPanModal.h>
#import "PersonalCenterHelper.h"
#import "CashInfoModel.h"
#import "UserCardModel.h"
#import "ProfitHelper.h"
@interface CashOutVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView    *tableView;

@property (nonatomic , strong) NSMutableArray *dataSource;

@property (nonatomic , strong) CashOutHeader* header;

@property (nonatomic , strong) CashOutTailer* tailer;

@property (nonatomic , strong) CashInfoModel* model;

@property (nonatomic , strong) UserCardModel* cardModel;

@end

@implementation CashOutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShowBackButton = YES;
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavBarTitle:@"提现"];
    [self setNavBarRightBtnWithTitle:@"提现记录" andImageName:nil];
    [self.view addSubview:self.tableView];
}

-(void)navBarRightBtnAction:(id)sender{
    [MXRouter openURL:@"lcwl://CashOutRecordVC" parameters:@{@"navTitle":@"提现记录"}];
}

-(void)initData{
    [ProfitHelper getUserValidCardList:@{} completion:^(id array, NSString *error) {
        if (array) {
            self.dataSource = array;
            
            [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UserCardModel* tmp = (UserCardModel*)obj;
                if ([tmp.is_default isEqualToString:@"1"]) {
                    self.cardModel = tmp;
                     [self.tableView reloadData];
                }
                if (self.cardModel == nil) {
                    self.cardModel = self.dataSource.firstObject;
                    [self.tableView reloadData];
                }
            }];
            [self.tableView reloadData];
        }
    }];
    [ProfitHelper getCashInfo:@{} completion:^(BOOL success, id object, NSString *error) {
        if (success) {
            self.model = object;
             [self.tableView reloadData];
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
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _tableView;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }
    return 520;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSString* identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            self.header = [[CashOutHeader alloc]init];
            self.header.tag = 101;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:self.header];
            cell.backgroundColor = [UIColor clearColor];
            [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [self.header reload:self.cardModel];
        return cell;
    }else if(indexPath.section == 1){
        NSString* identifier = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            self.tailer = [[CashOutTailer alloc]init];
            self.tailer.tag = 101;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:self.tailer];
            cell.backgroundColor = [UIColor clearColor];
            [self.tailer mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.tailer.block = ^(id data) {
                if ([StringUtil isEmpty:self.tailer.numTf.text]) {
                    [NotifyHelper showMessageWithMakeText:@"请输入提现金额"];
                    return ;
                }
                NSString *str = [self.cardModel.account substringFromIndex:self.cardModel.account.length-4];
                NSString* bank = [NSString stringWithFormat:@"%@(尾号%@)",self.cardModel.bank_name,str];
                [[YQPayKeyWordVC alloc] showInViewController:self type:QuotaPayType dataDict:@{@"title":self.tailer.numTf.text,@"tip":@"提现金额",@"left":@"提现到",@"right":bank}  block:^(NSString * text) {
                    [ProfitHelper applyCash:@{@"cash_money":self.tailer.numTf.text,@"card_id":self.cardModel.card_id,@"pay_password":text} completion:^(BOOL success, NSString *error) {
                        if (success) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    }];
                }];
            };
        }
        
        [self.tailer reload:self.model];
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HWBaseViewController *vc = [[HWBaseViewController alloc]init];
        vc.type = BankOverlayType;
        vc.block = ^(id data) {
            if (data) {
                self.cardModel = data;
                [self.tableView reloadData];
            }
            [vc dismissViewControllerAnimated:YES completion:^{
                
            }];
        };
        [self presentPanModal:vc];
    }
}
@end
