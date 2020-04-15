//
//  ModifyPhoneStep1VC.m
//  ScanPay
//
//  Created by mac on 2019/7/13.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BindBankVC.h"
#import "InvitationCodeView.h"
#import "ImgCaptchaView.h"
#import "TextCaptchaView.h"
//#import "MineHelper.h"
#import "NSObject+LoginHelper.h"
//#import "BindAccountModel.h"
#import "UploadBankPhotoView.h"
#import "TextSwitchView.h"
#import "YQPayKeyWordVC.h"
#import "UITextField+PopOver.h"
#import "RealNameModel.h"
#import "RealNameForm.h"
#import "PersonalCenterHelper.h"
#import "ProfitHelper.h"
@interface BindBankVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) InvitationCodeView* nameView;

@property (nonatomic, strong) InvitationCodeView* openBankView;

@property (nonatomic, strong) InvitationCodeView* bankNameView;

@property (nonatomic, strong) InvitationCodeView* bankCardView;

@property (nonatomic, strong) UploadBankPhotoView   *uploadView;

@property (nonatomic, strong) TextSwitchView   *switchView;

@property (nonatomic, strong) NSArray          *dataArray;

@property (nonatomic, strong) UITableView      *tableView;

@property (nonatomic, strong) RealNameForm      *form;



@end

@implementation BindBankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
}

-(void)initUI{
    if (!self.model) {
        self.model = [[AddBankModel alloc]init];
        self.model.is_default = @"0";
    }
    self.form = [[RealNameForm alloc]init];
    
    [self setNavBarTitle:@"添加结算卡"];
    [self setNavBarRightBtnWithTitle:@"完成" andImageName:nil];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self updateUI];
    NSLog(@"刷新啦");
}

-(void)initData{
    
}

-(void)updateUI{
    RealNameModel* tmp = AppUserModel.real;
    self.dataArray = @[@[
                           @{@"title":Lang(@"持卡人姓名"),@"placeholder":Lang(@"请输入持卡人姓名"),@"desc":tmp.real_name},
                           @{@"title":Lang(@"开户行"),@"placeholder":Lang(@"请输入开户行"),@"desc":self.model.bank_name},
                           @{@"title":Lang(@"银行代码"),@"placeholder":Lang(@"请输入银行代码"),@"desc":self.model.bank_code},
                           @{@"title":Lang(@"银行卡号"),@"placeholder":Lang(@"请输入银行卡号"),@"desc":self.model.account}
                           ],
                       @[
                           @{@"title":Lang(@""),@"desc":@""}
                           ],
                       @[
                           @{@"title":Lang(@"设为默认"),@"placeholder":@"",@"desc":self.model.is_default}
                           ]
                       ];
    [self.tableView reloadData];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        AdjustTableBehavior(_tableView);
        _tableView.separatorColor = [UIColor moBackground];
    }
    
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray* array = self.dataArray[section];
    return array.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor moBackground];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 160;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* identifier = [NSString stringWithFormat:@"%ld %ld",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView* tmpView = [self getViewFromIndexPath:indexPath];
        [cell.contentView addSubview:tmpView];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];
        [tmpView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
    }
    [self reloadData:indexPath];
    return cell;
}

-(UIView*)getViewFromIndexPath:(NSIndexPath *)indexPath{
    UIView* tmpView = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            tmpView = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
            self.nameView = (InvitationCodeView*)tmpView;
            [self.nameView isHiddenLine:NO];
            self.nameView.tf.enabled = NO;
        }else  if (indexPath.row == 1) {
            tmpView = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
            self.openBankView = (InvitationCodeView*)tmpView;
            self.openBankView.regex = @".*";
             [self.openBankView isHiddenLine:NO];
            @weakify(self)
            self.openBankView.getText = ^(id data) {
                 @strongify(self)
                self.model.bank_name = data;
            };
            
            [self.openBankView.tf popOverSource:@[] index:^(BankModel* index) {
                self.model.bank_code = index.bank_code;
                self.model.bank_name = index.bank_name;
                [self updateUI];
            }];
        } if (indexPath.row == 2) {
            tmpView = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
            self.bankNameView = (InvitationCodeView*)tmpView;
            [self.bankNameView isHiddenLine:NO];
            self.bankNameView.tf.enabled = NO;
        } if (indexPath.row == 3) {
            tmpView = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
            self.bankCardView = (InvitationCodeView*)tmpView;
            [self.bankCardView isHiddenLine:NO];
            @weakify(self)
            self.bankCardView.getText = ^(id data) {
                @strongify(self)
                self.model.account = data;
            };
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            tmpView = [[UploadBankPhotoView alloc]init];
            self.uploadView = (UploadBankPhotoView*)tmpView;
            self.uploadView.handPhoto.hidden = YES;
            [self.uploadView configVC:self model:self.form];
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            tmpView = [[TextSwitchView alloc]init];
            self.switchView = (TextSwitchView*)tmpView;
            @weakify(self)
            self.switchView.block = ^(id data) {
                @strongify(self)
                BOOL bol = [data boolValue];
                self.model.is_default = bol?@"1":@"0";
            };
        }
    }
    return tmpView;
}


-(void)reloadData:(NSIndexPath *)indexPath{
    NSArray* array = self.dataArray[indexPath.section];
    NSDictionary* dict = array[indexPath.row];
    NSString* title = dict[@"title"];
    NSString* placehoder = dict[@"placeholder"];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.nameView reloadTitle:title placeHolder:placehoder];
            self.nameView.tf.text = dict[@"desc"];
        }else  if (indexPath.row == 1) {
            [self.openBankView reloadTitle:title placeHolder:placehoder];
            self.openBankView.tf.text = dict[@"desc"];
            self.openBankView.regex = @".*";
        } if (indexPath.row == 2) {
            [self.bankNameView reloadTitle:title placeHolder:placehoder];
            self.bankNameView.tf.text = dict[@"desc"];
        } if (indexPath.row == 3) {
            [self.bankCardView reloadTitle:title placeHolder:placehoder];
            self.bankCardView.tf.text = dict[@"desc"];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            self.uploadView.handPhoto.hidden = YES;
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [self.switchView reload:title state:dict[@"desc"]];
        }
    }
}


-(void)navBarRightBtnAction:(id)sender{
    
    if ([StringUtil isEmpty:self.model.bank_code]) {
        [NotifyHelper showMessageWithMakeText:@"请输入银行代码"];
        return;
    }
    if ([StringUtil isEmpty:self.model.bank_name]) {
        [NotifyHelper showMessageWithMakeText:@"请输入开户行"];
        return;
    }
    if ([StringUtil isEmpty:self.model.account]) {
        [NotifyHelper showMessageWithMakeText:@"请输入银行卡号"];
        return;
    }
    if ([StringUtil isEmpty:self.form.leftImg] || [StringUtil isEmpty:self.form.centerImg]){
        [NotifyHelper showMessageWithMakeText:@"请上传银行卡正反面"];
        return;
    }
    [[YQPayKeyWordVC alloc] showInViewController:self type:NormalPayType dataDict:@{}  block:^(NSString * text) {
        [ProfitHelper updateUserCard:@{@"user_card_oper":@"user_card_add",
                                               @"bank_code":self.model.bank_code,
                                               @"bank_name":self.model.bank_name,
                                               @"card_photo":[NSString stringWithFormat:@"%@,%@",self.form.leftImg,self.form.centerImg],
                                               @"is_default":self.model.is_default,
                                               @"account":self.model.account,
                                               @"pay_password":text
                                               } completion:^(BOOL success, NSString *error) {
                                                   if (success) {
                                                       [self.navigationController popViewControllerAnimated:YES];
                                                   }
        }];
    }];
}
@end
