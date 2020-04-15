//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "PosInputInquiryunCheckDetailVC.h"
#import "MerchantListCell.h"
#import "SSSearchBar.h"
#import "RFHeader.h"
#import "NSObject+Home.h"
#import "PosInstallDetailModel.h"
#import "ZFMerchantManager.h"
#import "NSObject+Home.h"
static NSString* reuseIdentifierHeader = @"reuseIdentifierHeader";
static NSString* reuseIdentifierBar = @"reuseIdentifierBar";
@interface PosInputInquiryunCheckDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) PosInstallDetailModel *posModel;

@property (strong, nonatomic) UIButton *submitBtn;


@end

@implementation PosInputInquiryunCheckDetailVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavBarTitle:@"详情"];
    self.dataSource = @[];
    
    AdjustTableBehavior(self.tableView);
    self.view.backgroundColor = [UIColor whiteColor];
    UIView* bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    [bottomView addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(44));
        make.left.equalTo(bottomView).offset(15);
        make.right.equalTo(bottomView).offset(-15);
        make.bottom.equalTo(bottomView);
    }];
    self.tableView.tableFooterView = bottomView;
    
}

-(void)initData{
    self.dataSource = @[];
    [self getTraditionalPosInstallDetail:@{@"install_id":self.model.install_id} completion:^(id object, NSString *error) {
        if (object) {
            self.posModel = object;
            
            [self.tableView reloadData];
        }
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.posModel) {
        return 2;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 30;
    }
    if (indexPath.row == 2) {
        NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14 ]};
        CGRect infoRect =   [self.posModel.biz_msg boundingRectWithSize:CGSizeMake(190, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        return infoRect.size.height;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
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
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierHeader];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifierHeader];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor whiteColor];
            RFHeader *header = [[RFHeader alloc]init];
            header.tag = 101;
            [cell.contentView addSubview:header];
            cell.backgroundColor = [UIColor clearColor];
            [header mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
            }];
        }
        RFHeader *tmp = [cell.contentView viewWithTag:101];
        [tmp reloadColor:@"#1CCC9A" left:@"基本资料"right:@""];
        return cell;
    }else if(indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBar];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifierBar];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor whiteColor];
            cell.detailTextLabel.numberOfLines = 0;
            cell.detailTextLabel.numberOfLines = 0;
            cell.textLabel.font = [UIFont font14];
            cell.textLabel.textColor = [UIColor moPlaceHolder];
            cell.detailTextLabel.font = [UIFont font14];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"商户名称:";
            cell.detailTextLabel.text = self.posModel.merchant_name;
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"审核状态:";
            cell.detailTextLabel.text = [self.posModel.biz_code isEqualToString:@"00"]?@"审核成功":@"审核失败";
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"退回原因:";
            cell.detailTextLabel.text = self.posModel.biz_msg;
        }else if(indexPath.row == 3){
            cell.textLabel.text = @"商户编号:";
            cell.detailTextLabel.text = [StringUtil isEmpty:self.posModel.mer_code]?@"--":[NSString stringWithFormat:@"%@",self.posModel.mer_code];
        }else if(indexPath.row == 4){
            cell.textLabel.text = @"代理账号:";
            cell.detailTextLabel.text = [StringUtil isEmpty:self.posModel.agent_id]?@"--":[NSString stringWithFormat:@"%@",self.posModel.agent_id];
        }else if(indexPath.row == 5){
            cell.textLabel.text = @"到账标识:";
            cell.detailTextLabel.text = [StringUtil isEmpty:self.posModel.settle_flag]?@"--":[NSString stringWithFormat:@"%@到账",self.posModel.settle_flag];
        }else if(indexPath.row == 6){
            cell.textLabel.text = @"审核时间:";
            cell.detailTextLabel.text = self.posModel.cre_datetime;
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
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
        [_submitBtn setTitle:@"修改商户" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _submitBtn.backgroundColor = [UIColor darkGreen];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(void)submit:(id)sender{
    [ZFMerchantManager shareManager].delegate = self;
    [[ZFMerchantManager shareManager] changeInfoWithAccount:AppUserModel.app_id merchantName:self.model.merchant_name merchantCode:@"" viewController:self other:@"ios"];
}


///失败  返回错误信息
- (void)merchantManagerReturnError:(NSString *)msg{
    [NotifyHelper showMessageWithMakeText:msg];
}

///成功 返回商户信息、其他信息
- (void)merchantManagerReturnSuccess:(NSDictionary *)merchantInfo other:(NSString *)other{
    
}
@end
