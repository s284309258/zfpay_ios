//
//  SettingVC.m
//  JiuJiuEcoregion
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "PayPwdSettingVC.h"
#import "InvitationCodeView.h"
#import "ImgCaptchaView.h"
#import "TextCaptchaView.h"
#import "NSObject+LoginHelper.h"
#import "LoginRegModel.h"
static NSInteger padding = 15;
@interface PayPwdSettingVC ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UIView *header;

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray *data;

@property(nonatomic, strong) UIButton* submitBtn;

@property(nonatomic, strong) ImgCaptchaView* imageView;

@property(nonatomic, strong) TextCaptchaView* codeView;

@property(nonatomic, strong) InvitationCodeView* newPwd;

@property(nonatomic, strong) InvitationCodeView* newPwd1;

@property(nonatomic, strong) LoginRegModel* model;

@end

@implementation PayPwdSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];  
}

-(void)initUI{
    [self setNavBarTitle:Lang(@"修改支付密码")];
    self.isShowBackButton = YES;
    self.data = @[Lang(@"输入验证码"),Lang(@"图形验证码"),Lang(@"新支付密码"),Lang(@"再次确认密码")];
    self.model = [[LoginRegModel alloc]init];
    [self.view addSubview:self.tableView];
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 94)];
    [view addSubview:self.submitBtn];
    self.submitBtn.frame = CGRectMake(padding, 50, SCREEN_WIDTH-2*padding,  44);
    self.tableView.tableFooterView = view;
    [self layoutUI];
    self.tableView.backgroundColor = [UIColor moBackground];
}

-(UIButton* )submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 3;
        [_submitBtn setTitle:Lang(@"修改") forState:UIControlStateNormal];
        _submitBtn.clipsToBounds =NO;
        [_submitBtn addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setBackgroundColor:[UIColor moBlueColor]];
    }
    return _submitBtn;
}

- (void)layoutUI {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor moBackground];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section != 0) {
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
        UIView* tmpView = [self getIndexPathView:indexPath];
        [cell.contentView addSubview:tmpView];
        [tmpView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
    }
    return cell;
}

-(UIView*)getIndexPathView:(NSIndexPath *)indexPath{
    UIView* tmpView = nil;
    if(indexPath.section == 0){
        tmpView = self.codeView;
    }else if(indexPath.section == 1){
        tmpView = self.imageView;
    }else if(indexPath.section == 2){
        tmpView = self.newPwd;
    }else if(indexPath.section == 3){
        tmpView = self.newPwd1;
    }
    return tmpView;
}

-(InvitationCodeView* )newPwd{
    if (!_newPwd) {
        _newPwd = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
        _newPwd.tf.textColor = [UIColor moBlack];
        _newPwd.layer.borderColor = [UIColor clearColor].CGColor;
        _newPwd.layer.borderWidth = 0;
        [_newPwd isHiddenLine:YES];
        [_newPwd reloadPlaceHoder:Lang(@"新支付密码")];
       
        @weakify(self)
        _newPwd.getText = ^(id data) {
            @strongify(self)
            self.model.pay_password = data;
            
        };
    }
    return _newPwd;
}

-(InvitationCodeView* )newPwd1{
    if (!_newPwd1) {
        _newPwd1 = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
        _newPwd1.tf.textColor = [UIColor moBlack];
        _newPwd1.layer.borderColor = [UIColor clearColor].CGColor;
        _newPwd1.layer.borderWidth = 0;
        [_newPwd1 isHiddenLine:YES];
        [_newPwd1 reloadPlaceHoder:Lang(@"再次确认密码")];
        @weakify(self)
        _newPwd1.getText = ^(id data) {
            @strongify(self)
//            self.models.repay_password = data;
            
        };
    }
    return _newPwd1;
}

-(ImgCaptchaView* )imageView{
    if (!_imageView) {
        _imageView = [[ImgCaptchaView alloc]initWithFrame:CGRectZero];
        _imageView.tf.textColor = [UIColor moBlack];
        _imageView.layer.borderColor = [UIColor clearColor].CGColor;
        _imageView.layer.borderWidth = 0;
        [_imageView reloadplaceHolder:Lang(@"图形验证码")];
        NSString *url = [NSString stringWithFormat:@"%@/code/captcha.jpg",LcwlServerRoot];
        [_imageView reloadRightImgUrl:url];
        @weakify(self)
        _imageView.getText = ^(id data) {
            @strongify(self)
            self.model.picCode = data;
            
        };
        _imageView.picBlock = ^(id data) {
            @strongify(self)
            NSString *url = [NSString stringWithFormat:@"%@/code/captcha.jpg",LcwlServerRoot];
            [self.imageView reloadRightImgUrl:url];
        };
    }
    return _imageView;
}


-(TextCaptchaView* )codeView{
    if (!_codeView) {
        _codeView = [[TextCaptchaView alloc]initWithFrame:CGRectZero];
        _codeView.tf.textColor = [UIColor moBlack];
        _codeView.layer.borderColor = [UIColor clearColor].CGColor;
        _codeView.layer.borderWidth = 0;
        [_codeView reloadplaceHolder:Lang(@"输入验证码")];
        @weakify(self)
        _codeView.getText = ^(id data) {
            @strongify(self)
            self.model.captcha = data;
        };
        _codeView.sendCodeBlock = ^(id data) {
            
//            @strongify(self)
//            [self sendCode:@{@"busType":@"bus",@"captcha":self.model.picCode} completion:^(BOOL success, NSString *error) {
//                if (!success) {
//                    NSString *url = [NSString stringWithFormat:@"%@/code/captcha.jpg",LcwlServerRoot];
//                    [self.imageView reloadRightImgUrl:url];
//                }
//            }];
        };
    }
    return _codeView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        AdjustTableBehavior(_tableView);
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

-(void)goTo:(id)sender{
//    [self.view endEditing:YES];
//    [self safety_payPassword:@{@"newPayPassword":self.model.pay_password,@"confirmPayPassword":self.model.repay_password,@"code":self.model.captcha} completion:^(BOOL success, NSString *error) {
//        if (success) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }];
}


@end
