//
//  ModifyPhoneStep1VC.m
//  ScanPay
//
//  Created by mac on 2019/7/13.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "RealNameAuthVC.h"
#import "InvitationCodeView.h"
#import "ImgCaptchaView.h"
#import "TextCaptchaView.h"
#import "NSObject+LoginHelper.h"
#import "UploadBankPhotoView.h"
#import "YQPayKeyWordVC.h"
#import "RealNameForm.h"
#import "PersonalCenterHelper.h"
@interface RealNameAuthVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) InvitationCodeView* nameView;

@property (nonatomic, strong) InvitationCodeView* openBankView;

@property (nonatomic, strong) UploadBankPhotoView   *uploadView;

@property (nonatomic, strong) NSArray          *dataArray;

@property (nonatomic, strong) UITableView      *tableView;

@property (nonatomic, strong) UIView       *footerView;

@property (nonatomic, strong) UIButton *loginoutBnt;

@property (nonatomic, strong) RealNameForm *model;

@end

@implementation RealNameAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavBarTitle:@"实名认证"];
//    [self setNavBarRightBtnWithTitle:@"完成" andImageName:nil];
    self.dataArray = @[@[
                           @{@"title":Lang(@"真实姓名"),@"placeholder":Lang(@"请输入您的真实姓名"),@"desc":@""},
                           @{@"title":Lang(@"身份证号"),@"placeholder":Lang(@"请输入您的身份证号"),@"desc":@""}
                           ],
                       @[
                           @{@"title":Lang(@""),@"desc":@""}
                           ]
                       ];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = self.footerView;

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
}

-(void)initData{
    self.model = [[RealNameForm alloc]init];
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
    NSString* identifier = [NSString stringWithFormat:@"%ld_%ld_%ld",indexPath.section,indexPath.row,[NSDate timeIntervalSinceReferenceDate]];
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
    [self configIndexPath:indexPath];
    return cell;
}

-(void)configIndexPath:(NSIndexPath*)indexPath{
    NSArray* array = self.dataArray[indexPath.section];
    NSDictionary* dict = array[indexPath.row];
    NSString* title = dict[@"title"];
    NSString* placehoder = dict[@"placeholder"];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.nameView isHiddenLine:NO];
            [self.nameView reloadTitle:title placeHolder:placehoder];
            self.nameView.tf.text = dict[@"desc"];
            @weakify(self)
            self.nameView.getText = ^(id data) {
                @strongify(self)
                self.model.real_name = data;
            };
        }else  if (indexPath.row == 1) {
            [self.openBankView reloadTitle:title placeHolder:placehoder];
            self.openBankView.tf.text = dict[@"desc"];
            [self.openBankView isHiddenLine:NO];
            @weakify(self)
            self.openBankView.getText = ^(id data) {
                @strongify(self)
                self.model.id_card = data;
            };
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.uploadView configVC:self model:self.model];
        }
    }
}

-(UIView*)getViewFromIndexPath:(NSIndexPath *)indexPath{
    UIView* tmpView = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.nameView = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
            tmpView = self.nameView;
        }else  if (indexPath.row == 1) {
            self.openBankView = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
            tmpView = self.openBankView;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            self.uploadView = [[UploadBankPhotoView alloc]init];
            [self.uploadView.upPhoto setTitle:@"身份证正面照" forState:UIControlStateNormal];
            [self.uploadView.downPhoto setTitle:@"身份证反面照" forState:UIControlStateNormal];
            self.uploadView.title.text = @"上传证件照片和人像照";
            tmpView = self.uploadView;
        }
    }
    return tmpView;
}

-(void)navBarRightBtnAction:(id)sender{
    
}

-(UIView* )footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        [_footerView addSubview:self.loginoutBnt];
        @weakify(self)
        [self.loginoutBnt mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.footerView.mas_left).offset(15);
            make.right.equalTo(self.footerView.mas_right).offset(-15);
            make.top.equalTo(@(35));
            make.height.equalTo(@(50));
        }];
        
    }
    return _footerView;
}


- (UIButton *)loginoutBnt {
    if(!_loginoutBnt) {
        _loginoutBnt=[UIButton buttonWithType:UIButtonTypeCustom];
        _loginoutBnt.frame = CGRectMake(-1, 0, SCREEN_WIDTH+2, 44);
        [_loginoutBnt setTitle:Lang(@"提交审核") forState:UIControlStateNormal];
        _loginoutBnt.titleLabel.font = [UIFont systemFontOfSize:17];
        _loginoutBnt.backgroundColor = [UIColor darkGreen];
        [_loginoutBnt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginoutBnt.layer.masksToBounds = YES;
        _loginoutBnt.layer.cornerRadius = 5;
        [_loginoutBnt addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginoutBnt;
}

-(void)submit:(id)sender{
    if ([StringUtil isEmpty:self.model.leftImg] || [StringUtil isEmpty:self.model.centerImg] || [StringUtil isEmpty:self.model.rightImg]) {
        [NotifyHelper showMessageWithMakeText:@"请选择图片"];
        return;
    }
    if ([StringUtil isEmpty:self.model.id_card]) {
              [NotifyHelper showMessageWithMakeText:@"请输入身份证号"];
        return;
    }
    if ([StringUtil isEmpty:self.model.real_name]) {
        [NotifyHelper showMessageWithMakeText:@"请输入真实姓名"];
        return;
    }
    NSArray* photoArray = @[self.model.leftImg,self.model.centerImg,self.model.rightImg];
    [PersonalCenterHelper submitUserAuthInfo:@{@"id_card":self.model.id_card,@"card_photo":[photoArray componentsJoinedByString:@","],@"real_name":self.model.real_name} completion:^(BOOL success, NSString *error) {
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

@end
