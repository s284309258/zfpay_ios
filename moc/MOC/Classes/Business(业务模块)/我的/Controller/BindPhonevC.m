//
//  SettingVC.m
//  JiuJiuEcoregion
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BindPhonevC.h"
#import "DLPickerView.h"
#import "MXAlertViewHelper.h"
#import "InvitationCodeView.h"
#import "ImgCaptchaView.h"
#import "TextCaptchaView.h"
#import "CipherView.h"
#import "InvitationCodeView.h"
#import "LoginRegModel.h"
#import "InvitationCodeView.h"
#import "NSObject+LoginHelper.h"
#import "NSString+NumFormat.h"
#import "PersonalCenterHelper.h"

static NSInteger padding = 15;
@interface BindPhonevC ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UIView *header;

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray *data;

@property(nonatomic, strong) UIButton* submitBtn;

@property(nonatomic, strong) LoginRegModel* model;

@property(nonatomic, strong) InvitationCodeView* phoneView;

@property(nonatomic, strong) InvitationCodeView* emailView;

@property(nonatomic, strong) ImgCaptchaView* imgVerifyView;

@property(nonatomic, strong) TextCaptchaView* verifyView;

@property(nonatomic, strong) CipherView* pwdView;

@property(nonatomic, strong) CipherView* rePwdView;

@end

@implementation BindPhonevC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavBarTitle:Lang(@"绑定新手机号码")];
    //self.edgesForExtendedLayout = UIRectEdgeAll;
    self.isShowBackButton = YES;
    
    self.model = [[LoginRegModel alloc]init];
    self.data = @[
                  @{@"title":Lang(@"新手机号码"),@"placeholder":Lang(@"请输入手机号码")},
                  @{@"title":Lang(@"图形验证码"),@"placeholder":Lang(@"请输入验证码")},
                  @{@"title":Lang(@"短信验证码"),@"placeholder":Lang(@"请输入验证码")}
                  ];
    [self.view addSubview:self.tableView];
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 94)];
    [view addSubview:self.submitBtn];
    self.submitBtn.frame = CGRectMake(15, 50, SCREEN_WIDTH-30,  44);
    self.tableView.tableFooterView = view;
    [self layoutUI];
    
    self.tableView.backgroundColor = [UIColor moBackground];
    
    [self getImgCode];
    
}

-(UIButton* )submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        [_submitBtn setTitle:Lang(@"下一步") forState:UIControlStateNormal];
        _submitBtn.clipsToBounds =NO;
        [_submitBtn addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setBackgroundColor:[UIColor darkGreen]];
    }
    return _submitBtn;
}

- (void)layoutUI {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(@(-(TabbarHeight)));
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor moBackground];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 1) {
        return 10;
    }
    return 0;
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
    
    return cell;
}

-(UIView*)getViewFromIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dict =self.data[indexPath.row];
    NSString* title = dict[@"title"];
    NSString* placehoder = dict[@"placeholder"];
    UIView* tmpView = nil;
    if (indexPath.row == 0) {
        tmpView = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
        self.phoneView = (InvitationCodeView*)tmpView;
        [self.phoneView reloadTitle:title placeHolder:placehoder];
        self.phoneView.getText = ^(id data) {
            self.model.phoneNo = data;
        };
    }else if(indexPath.row == 1){
        tmpView = [[ImgCaptchaView alloc]initWithFrame:CGRectZero];
        self.imgVerifyView = (ImgCaptchaView*)tmpView;
        [self.imgVerifyView showDownLine:YES];
        @weakify(self)
        self.imgVerifyView.getText = ^(id data) {
            @strongify(self)
            self.model.picCode = data;
        };
        self.imgVerifyView.picBlock = ^(id data) {
            @strongify(self)
            [self getImgCode];
        };
    }else if(indexPath.row == 2){
        tmpView = [[TextCaptchaView alloc]initWithFrame:CGRectZero];
        self.verifyView = (TextCaptchaView*)tmpView;
        [self.verifyView reloadTitle:@"短信验证码" placeHolder:@"请输入验证码"];
        [self.verifyView isHiddenLine:NO];
        @weakify(self)
        self.verifyView.getText = ^(id data) {
            @strongify(self)
            self.model.captcha = data;
        };
        self.verifyView.sendCodeBlock = ^(id data) {
            @strongify(self)
            [self sendSmsCode];
        };
    }else if (indexPath.row == 3) {
        tmpView = [[CipherView alloc]initWithFrame:CGRectZero];
        self.pwdView = (CipherView*)tmpView;
        self.pwdView.tf.keyboardType = UIKeyboardTypeNumberPad;
        [self.pwdView reloadTitle:title placeHolder:placehoder];
        @weakify(self)
        self.pwdView.getText = ^(id data) {
            @strongify(self)
            self.model.password = data;
        };
    }else if(indexPath.row == 4){
        @weakify(self)
        tmpView = [[CipherView alloc]initWithFrame:CGRectZero];
        self.rePwdView = (CipherView*)tmpView;
        self.pwdView.tf.keyboardType = UIKeyboardTypeNumberPad;
        [self.rePwdView reloadTitle:title placeHolder:placehoder];
        self.rePwdView.getText = ^(id data) {
            @strongify(self)
            self.model.rePassword = data;
        };
        [self.rePwdView  reloadTitle:title placeHolder:placehoder];
    }
    return tmpView;
}



- (void)sendSmsCode {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
    [param setValue:AppUserModel.token forKey:@"token"];
    [param setValue:@"FrontModifyTelSecond" forKey:@"bus_type"];
    [param setValue:self.model.img_id forKey:@"img_id"];
    [param setValue:self.model.picCode forKey:@"img_code"];
    [self sendSmsCodeToken:param completion:^(BOOL success, NSString *error) {
        if (!success) {
            [self getImgCode];
        }else{
            [self.verifyView startCountDowView];
        }
    }];
}

- (void)getImgCode {
    [self createImgCode:@{@"interface_type":@"createImgCode"} completion:^(id object, NSString *error) {
        NSDictionary* tempDic = (NSDictionary*)object;
        NSString * img_id = [tempDic valueForKeyPath:@"img_id"];
        NSString * img_io = [tempDic valueForKeyPath:@"img_io"];
        self.model.img_id = img_id;
        self.model.img_io = img_io;
        [self.imgVerifyView reloadRightImg:self.model.ioImage];
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray* array = self.data[indexPath.section];
    NSDictionary* dict = array[indexPath.row];
    NSString* vcString = dict[@"vc"];
    if (![StringUtil isEmpty:vcString]) {
        [MXRouter openURL:vcString];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        AdjustTableBehavior(_tableView);
        _tableView.separatorColor = [UIColor moBackground];
        
    }
    
    return _tableView;
}

-(void)goTo:(id)sender{
    [self.view endEditing:YES];
    [PersonalCenterHelper modifyTelSecond:@{@"sys_user_account":self.model.phoneNo,@"sms_code":self.model.captcha,@"token":AppUserModel.token,@"valid_flag":self.valid_flag} completion:^(id object, NSString *error) {
        if (object) {
            UIViewController* vc = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:vc animated:YES];
            AppUserModel.user_tel = self.model.phoneNo;
            [AppUserModel saveModelToCache];
        }
    }];
}


@end
