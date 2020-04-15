//
//  SettingVC.m
//  JiuJiuEcoregion
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "InfoSettingVC.h"
//#import "SetPhoneNumView.h"
//#import "InvitationCodeView.h"
//#import "VerityCodeView2.h"
//#import "InfoCellView.h"
//#import "PersonalCenterHelper.h"
//#import "NSObject+LoginHelper.h"
//#import "ImageUtil.h"
//#import "PhotoBrowser.h"
//#import "QNManager.h"
//#import "NSMutableAttributedString+Attributes.h"

static NSInteger padding = 15;
@interface InfoSettingVC ()<UITableViewDelegate, UITableViewDataSource>
//
//@property(nonatomic, strong) UIView *header;
//
//@property(nonatomic, strong) UITableView *tableView;
//
//@property(nonatomic, strong) NSMutableArray *data;
//
//@property(nonatomic, strong) UIButton* submitBtn;
//
//@property(nonatomic, strong) SetPhoneNumView* userView;
//
//@property(nonatomic, strong) SetPhoneNumView* nameView;
//
//@property(nonatomic, strong) SetPhoneNumView* idcardView;
//
//@property(nonatomic, strong) SetPhoneNumView* dateView;
//
//@property(nonatomic, strong) SetPhoneNumView* phoneView;
//
//@property(nonatomic, strong) SetPhoneNumView* idcardView1;
//
//@property(nonatomic, strong) SetPhoneNumView* walletView;
//
//@property (nonatomic, strong) InvitationCodeView* contacterView;
//
//@property (nonatomic, strong) VerityCodeView2* codeView;
//
//@property (nonatomic, strong) InfoCellView* aliPayView;
//
//@property (nonatomic, strong) InfoCellView* weixinPayView;
//
//@property (nonatomic, strong) UIView* footer;
//
//@property (nonatomic, strong) UIImageView* qrCodeImgView;
//
//@property (nonatomic, strong) NSString* qrCodeImgType;
//@property (nonatomic, strong) NSString* qrCodeImgUrl;
//
//@property (nonatomic, strong) NSString* weixinpayPath;
//@property (nonatomic, strong) NSString* alipayPath;

@end

@implementation InfoSettingVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    [self setNavBarTitle:Lang(@"个人信息")];
//    //self.edgesForExtendedLayout = UIRectEdgeAll;
//    self.isShowBackButton = YES;
//    
//    
//    [self.view addSubview:self.tableView];
////    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 94)];
////    [view addSubview:self.submitBtn];
////    self.submitBtn.frame = CGRectMake(padding, 50, SCREEN_WIDTH-2*padding,  44);
//    self.tableView.tableFooterView = self.footer;
//    [self layoutUI];
//    
//    self.tableView.backgroundColor = [UIColor clearColor];
//    
//    [self getData];
//}
//
//- (void)getData {
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
//    [dic setValue:AppUserModel.token forKey:@"token"];
//    [NotifyHelper showHUDAddedTo:self.view animated:YES];
//    [self getUserInfo:dic completion:^(id object, NSString *error) {
//        [NotifyHelper hideHUDForView:self.view animated:YES];
//        [self updateUI];
//    }];
//}
//
//- (void)updateUI {
//    
//    NSMutableArray *payArr = [NSMutableArray arrayWithCapacity:1];
//    NSString *qrcodeUrl = nil;
//    NSMutableAttributedString *attStr = [NSMutableAttributedString initWithTitles:@[Lang(@"修改收款码 >"),Lang(@"已上传收款码")] colors:@[[UIColor colorWithHexString:@"#527BFD"],[UIColor colorWithHexString:@"#B3B3B3"]] fonts:@[[UIFont systemFontOfSize:12],[UIFont systemFontOfSize:12]] placeHolder:@"    "];
//    if(![StringUtil isEmpty:self.weixinpayPath]) {
//        qrcodeUrl = self.weixinpayPath;
//        [payArr addObject:@{@"title":Lang(@"支付宝收款码"),@"placeholder":attStr}];
//    } else if(![StringUtil isEmpty:self.alipayPath]) {
//        qrcodeUrl = self.alipayPath;
//        [payArr addObject:@{@"title":Lang(@"微信收款码"),@"placeholder":attStr}];
//    } else {
//        attStr = [[NSMutableAttributedString alloc] initWithString:Lang(@"立即上传")];
//        [payArr addObject:@{@"title":Lang(@"支付宝收款码"),@"placeholder":attStr}];
//        [payArr addObject:@{@"title":Lang(@"微信收款码"),@"placeholder":attStr}];
//    }
//    
//    self.data = [@[@[
//                      @{@"title":Lang(@"用户名"),@"placeholder":AppUserModel.username},
//                      @{@"title":Lang(@"真实姓名"),@"placeholder":AppUserModel.realname},
//                      @{@"title":Lang(@"身份证"),@"placeholder":AppUserModel.idcard},
//                      @{@"title":Lang(@"注册时间"),@"placeholder":AppUserModel.createTime},
//                      @{@"title":Lang(@"手机号码"),@"placeholder":AppUserModel.mobile},
//                      @{@"title":Lang(@"身份证"),@"placeholder":AppUserModel.idcard},
//                      @{@"title":Lang(@"MOC钱包"),@"placeholder":[StringUtil integerToString:AppUserModel.saleLockWatNum] }
//                      ],
//                  @[
//                      @{@"title":Lang(@"紧急联系人"),@"placeholder":@"请输入紧急联系人电话"},
//                      @{@"title":Lang(@"验证码"),@"placeholder":@"请输入短信验证码"}
//                      ],
//                  ] mutableCopy];
//    
//    [self.data addObject:payArr];
//    
//    [self.qrCodeImgView sd_setImageWithURL:[NSURL URLWithString:qrcodeUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        self.qrCodeImgView.image = [ImageUtil imageForSreenWidth:image];
//        self.qrCodeImgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.qrCodeImgView.image.size.height);
//        self.footer.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.qrCodeImgView.height+44+30);
//        self.tableView.tableFooterView = self.footer;
//        [self.tableView reloadData];
//    }];
//    [self.tableView reloadData];
//}
//
//-(UIButton* )buttonWithTitle:(NSString *)title tag:(NSInteger)tag {
//    UIButton *bnt = [UIButton buttonWithType:UIButtonTypeCustom];
//    bnt.titleLabel.font = [UIFont systemFontOfSize:16];
//    bnt.tag = tag;
//    [bnt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    bnt.layer.masksToBounds = YES;
//    bnt.layer.cornerRadius = 3;
//    [bnt setTitle:title forState:UIControlStateNormal];
//    [bnt addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
//    [bnt setBackgroundColor:[UIColor moBlueColor]];
//    return bnt;
//}
//
//- (void)layoutUI {
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.view).offset(-10);
//    }];
//}
//
//-(void)goTo:(UIButton *)sender{
//    [self.view endEditing:YES];
//    if(sender.tag == 10001) {
//        [self fixInfo];
//    }
//}
//
//- (void)fixInfo {
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
//    [dic setValue:self.contacterView.tf.text forKey:@"contactMobile"];
//    if(![StringUtil isEmpty:self.qrCodeImgType]) {
//        [dic setValue:self.qrCodeImgUrl forKey:self.qrCodeImgType];
//    }
//    [dic setValue:self.codeView.tf.text forKey:@"code"];
//    [PersonalCenterHelper userInfoUpdate:self.view param:dic completion:^(BOOL success, id object, NSString *error) {
//        if(success) {
//            if(![StringUtil isEmpty:self.weixinpayPath]) {
//                AppUserModel.weixinpayPath = self.weixinpayPath;
//            } else if(![StringUtil isEmpty:self.alipayPath]) {
//                AppUserModel.alipayPath = self.alipayPath;
//            }
//        }
//    }];
//}
//
//#pragma mark - UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.data.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSArray* array = self.data[section];
//    return array.count;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor moBackground];
//    return view;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if(section != 0) {
//        return 10;
//    }
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString* identifier = [NSString stringWithFormat:@"%ld %ld",indexPath.section,indexPath.row];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if(cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        UIView* tmpView = [self getIndexPathView:indexPath];
//        [cell.contentView addSubview:tmpView];
//        [tmpView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
//        }];
//    }
//    [self getIndexPathView:indexPath];
//    return cell;
//}
//
//-(UIView*)getIndexPathView:(NSIndexPath *)indexPath{
//    UIView* tmpView = nil;
//    NSArray* array = self.data[indexPath.section];
//    NSDictionary* data = array[indexPath.row];
//    NSString* title = data[@"title"];
//    NSString* placeholder = data[@"placeholder"];
//    if (indexPath.section == 0) {
//        if(indexPath.row == 0){
//            [self.userView reload:title desc:placeholder];
//            tmpView = self.userView;
//        }else if(indexPath.row == 1){
//             [self.nameView reload:title desc:placeholder];
//            tmpView = self.nameView;
//        }else if(indexPath.row == 2){
//             [self.idcardView reload:title desc:placeholder];
//            tmpView = self.idcardView;
//        }else if(indexPath.row == 3){
//             [self.dateView reload:title desc:placeholder];
//            tmpView = self.dateView;
//        }else if(indexPath.row == 4){
//             [self.phoneView reload:title desc:placeholder];
//            tmpView = self.phoneView;
//        }else if(indexPath.row == 5){
//             [self.idcardView1 reload:title desc:placeholder];
//            tmpView = self.idcardView1;
//        }else if(indexPath.row == 6){
//             [self.walletView reload:title desc:placeholder];
//            tmpView = self.walletView;
//        }
//    }else if(indexPath.section == 1){
//        if (indexPath.row == 0) {
//            [self.contacterView reloadTitle:title placeHolder:placeholder];
//            self.contacterView.tf.text = AppUserModel.contactMobile;
//            tmpView = self.contacterView;
//        }else if(indexPath.row == 1){
//            [self.codeView reloadTitle:title placeHolder:placeholder];
//            self.codeView.horLine.hidden = YES;
//            tmpView = self.codeView;
//        }
//    }else if(indexPath.section == 2){
//        if (indexPath.row == 0) {
//            [self.aliPayView reloadTitle:title desc:placeholder];
//            tmpView = self.aliPayView;
//        }else if (indexPath.row == 1) {
//            self.weixinPayView.descLbl.textColor = [UIColor redColor];
//            [self.weixinPayView reloadTitle:title desc:placeholder];
//            tmpView = self.weixinPayView;
//        }
//    }
//   
//    return tmpView;
//}
//
//
//
//-(SetPhoneNumView* )userView{
//    if (!_userView) {
//        _userView = [[SetPhoneNumView alloc]initWithFrame:CGRectZero];
//        _userView.layer.borderColor = [UIColor clearColor].CGColor;
//        _userView.layer.borderWidth = 0;
////        @weakify(self)
////        _userView.getText = ^(id data) {
////            @strongify(self)
////
////        };
//    }
//    return _userView;
//}
//
//-(SetPhoneNumView* )nameView{
//    if (!_nameView) {
//        _nameView = [[SetPhoneNumView alloc]initWithFrame:CGRectZero];
//        _nameView.layer.borderColor = [UIColor clearColor].CGColor;
//        _nameView.layer.borderWidth = 0;
////        @weakify(self)
////        _nameView.getText = ^(id data) {
////            @strongify(self)
////
////        };
//    }
//    return _nameView;
//}
//
//-(SetPhoneNumView* )idcardView{
//    if (!_idcardView) {
//        _idcardView = [[SetPhoneNumView alloc]initWithFrame:CGRectZero];
//        _idcardView.layer.borderColor = [UIColor clearColor].CGColor;
//        _idcardView.layer.borderWidth = 0;
//        //        @weakify(self)
//        //        _nameView.getText = ^(id data) {
//        //            @strongify(self)
//        //
//        //        };
//    }
//    return _idcardView;
//}
//
//-(SetPhoneNumView* )dateView{
//    if (!_dateView) {
//        _dateView = [[SetPhoneNumView alloc]initWithFrame:CGRectZero];
//        _dateView.layer.borderColor = [UIColor clearColor].CGColor;
//        _dateView.layer.borderWidth = 0;
//        //        @weakify(self)
//        //        _nameView.getText = ^(id data) {
//        //            @strongify(self)
//        //
//        //        };
//    }
//    return _dateView;
//}
//
//
//-(SetPhoneNumView* )phoneView{
//    if (!_phoneView) {
//        _phoneView = [[SetPhoneNumView alloc]initWithFrame:CGRectZero];
//        _phoneView.layer.borderColor = [UIColor clearColor].CGColor;
//        _phoneView.layer.borderWidth = 0;
//        //        @weakify(self)
//        //        _nameView.getText = ^(id data) {
//        //            @strongify(self)
//        //
//        //        };
//    }
//    return _phoneView;
//}
//
//-(SetPhoneNumView* )idcardView1{
//    if (!_idcardView1) {
//        _idcardView1 = [[SetPhoneNumView alloc]initWithFrame:CGRectZero];
//        _idcardView1.layer.borderColor = [UIColor clearColor].CGColor;
//        _idcardView1.layer.borderWidth = 0;
//        //        @weakify(self)
//        //        _nameView.getText = ^(id data) {
//        //            @strongify(self)
//        //
//        //        };
//    }
//    return _idcardView1;
//}
//
//-(SetPhoneNumView* )walletView{
//    if (!_walletView) {
//        _walletView = [[SetPhoneNumView alloc]initWithFrame:CGRectZero];
//        _walletView.layer.borderColor = [UIColor clearColor].CGColor;
//        _walletView.layer.borderWidth = 0;
//        //        @weakify(self)
//        //        _nameView.getText = ^(id data) {
//        //            @strongify(self)
//        //
//        //        };
//    }
//    return _walletView;
//}
//
//-(InvitationCodeView*)contacterView{
//    if (!_contacterView) {
//        _contacterView = [[InvitationCodeView alloc]initWithFrame:CGRectZero];
//        [_contacterView isHiddenLine:NO];
//    }
//    return _contacterView;
//}
//
//-(VerityCodeView2* )codeView{
//    if (!_codeView) {
//        _codeView = [[VerityCodeView2 alloc]initWithFrame:CGRectZero];
//        
//    }
//    return _codeView;
//}
//
//-(InfoCellView* )aliPayView{
//    if (!_aliPayView) {
//        _aliPayView = [[InfoCellView alloc]initWithFrame:CGRectZero];
//        
//    }
//    return _aliPayView;
//}
//
//-(InfoCellView* )weixinPayView{
//    if (!_weixinPayView) {
//        _weixinPayView = [[InfoCellView alloc]initWithFrame:CGRectZero];
//        
//    }
//    return _weixinPayView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 50;
//}
//
//#pragma mark - UITableViewDelegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if(indexPath.section == 2) {
//        self.qrCodeImgType = indexPath.row == 0 ? @"weixinpayPath" : @"alipayPath";
//        
//        [[PhotoBrowser shared] showPhotoLibrary:self completion:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nullable assets, BOOL isOriginal) {
//            if([images isKindOfClass:[NSArray class]]) {
//                if([[images firstObject] isKindOfClass:[UIImage class]]) {
//                    UIImage *image = [images firstObject];
//                    [NotifyHelper showHUDAddedTo:self.view animated:YES];
//                    [[QNManager shared] uploadImage:image completion:^(id data) {
//                        [NotifyHelper hideHUDForView:self.view animated:YES];
//                        self.qrCodeImgUrl = data;
//                        if(data && [NSURL URLWithString:data]) {
//                            if(indexPath.row == 0) {
//                                self.weixinpayPath = data;
//                            } else if(indexPath.row == 1) {
//                                self.alipayPath = data;
//                            }
//                            [self updateUI];
//                        }
//                    }];
//                }
//            }
//        }];
//    }
//}
//
//- (UITableView *)tableView {
//    if (!_tableView) {
//        _tableView = [[UITableView alloc]initWithFrame:CGRectZero];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.tableFooterView = [[UIView alloc] init];
//        AdjustTableBehavior(_tableView);
//        _tableView.separatorColor = [UIColor clearColor];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
//    
//    return _tableView;
//}
//
//- (UIImageView *)qrCodeImgView {
//    if(!_qrCodeImgView) {
//        _qrCodeImgView = [[UIImageView alloc] init];
//    }
//    return _qrCodeImgView;
//}
//
//- (UIView *)footer {
//    if(!_footer) {
//        _footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44+30)];
//        
//        [_footer addSubview:self.qrCodeImgView];
//        
//        UIButton *bnt1 = [self buttonWithTitle:Lang(@"修改") tag:10001];
//        [_footer addSubview:bnt1];
//        
//        UIButton *bnt2 = [self buttonWithTitle:Lang(@"取消") tag:10002];
//        [bnt2 setBackgroundColor:[UIColor colorWithHexString:@"#BBBBBB"]];
//        [_footer addSubview:bnt2];
//        
//        [bnt1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@(15));
//            make.bottom.equalTo(@(0));
//            make.height.equalTo(@(44));
//            make.width.equalTo(@((SCREEN_WIDTH-45)/2.0));
//        }];
//        
//        [bnt2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(@(-15));
//            make.bottom.equalTo(@(0));
//            make.height.equalTo(@(44));
//            make.width.equalTo(@((SCREEN_WIDTH-45)/2.0));
//        }];
//        
//    }
//    return _footer;
//}
@end
