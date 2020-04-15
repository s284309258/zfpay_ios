//
//  SettingVC.m
//  MOC
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "SettingVC.h"
#import "DLPickerView.h"
#import "MXAlertViewHelper.h"
#import "PersonalCenterHelper.h"
#import "MineInfoCell.h"
#import "NSObject+LoginHelper.h"
#import "TextSwitchView.h"
#import "SettingHeader.h"
#import "NSObject+LoginHelper.h"
#import "PhotoBrowser.h"
#import "QNManager.h"
#define MineHeaderHeight 110

@interface SettingVC ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView  *tableView;

@property(nonatomic, strong) NSArray      *data;

@property (nonatomic, strong) UIButton    *loginoutBnt;

@property (strong, nonatomic) UILabel     *titleLbl;

@property (strong, nonatomic) UIButton    *scanBtn;

@property(nonatomic, strong) UIView       *footerView;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.isShowBackButton = YES;
    
    [self.view addSubview:self.tableView];
    [self layoutUI];
    
    self.tableView.backgroundColor = [UIColor moBackground];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateForLanguageChanged];
}

- (void)updateForLanguageChanged {
    [self setNavBarTitle:Lang(@"设置")];
    //此处放入对象
    self.data = @[
                  @[@{@"title":Lang(@"头像"),@"image":AppUserModel.head_photo,@"vc":@"",@"type":@"avatar"},
                  @{@"title":Lang(@"真实姓名"),@"desc":(![StringUtil isEmpty:AppUserModel.real.real_name])?AppUserModel.real.real_name:[PersonalCenterHelper getAuthStatus:AppUserModel.real.auth_status],@"arrow":@"1"},
                    @{@"title":Lang(@"手机号码"),@"desc":AppUserModel.user_tel,@"vc":@"lcwl://UpdatePhoneVC"}],
                  
                  @[@{@"title":Lang(@"修改登录密码"),@"vc":@"lcwl://LoginPwdSettingVC"},
                    @{@"title":Lang(@"修改交易密码"),@"vc":@"lcwl://BusinessPwdSettingVC"}],
                  
                  @[
//                      @{@"title":Lang(@"横幅通知"),@"type":@"switch"},
//                    @{@"title":Lang(@"提示音"),@"type":@"switch"},
                    @{@"title":Lang(@"当前版本"),@"desc":@"1.0.1",@"arrow":@"1"}]
                  
                      ];
    
    [self.tableView reloadData];
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
    return [[self.data safeObjectAtIndex:section] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor moBackground];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor moBackground];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* dataDict = self.data[indexPath.section][indexPath.row];
    NSString* type = dataDict[@"type"];
    if ([type isEqualToString:@"avatar"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"avatar"];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"avatar"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            SettingHeader* tmpView = [SettingHeader new];
            tmpView.tag = 101;
            [cell.contentView addSubview:tmpView];
            [tmpView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }
        SettingHeader* tmpView = [cell.contentView viewWithTag:101];
        [tmpView reload:dataDict[@"title"] image:dataDict[@"image"]];
        MXSeparatorLine* line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
        [cell.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(1));
            make.left.equalTo(cell.contentView).offset(15);
            make.right.equalTo(cell.contentView).offset(-15);
            make.bottom.equalTo(cell.contentView);
        }];
        return cell;
    }else if([type isEqualToString:@"switch"]){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switch"];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"switch"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            TextSwitchView* tmpView = [TextSwitchView new];
            tmpView.tag = 101;
            [cell.contentView addSubview:tmpView];
            [tmpView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }
        TextSwitchView* tmpView = [cell.contentView viewWithTag:101];
        [tmpView reload:dataDict[@"title"] state:@"1"];
        MXSeparatorLine* line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
        [cell.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(1));
            make.left.equalTo(cell.contentView).offset(15);
            make.right.equalTo(cell.contentView).offset(-15);
            make.bottom.equalTo(cell.contentView);
        }];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"other"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"other"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont font15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.detailTextLabel.textColor = cell.textLabel.textColor;
    }
    
    NSDictionary *dict = [[self.data safeObjectAtIndex:indexPath.section] safeObjectAtIndex:indexPath.row];
    cell.textLabel.text = dict[@"title"];
    
    cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    if([dict valueForKey:@"arrow"]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.detailTextLabel.text = [dict valueForKey:@"desc"];
    cell.detailTextLabel.textColor = [UIColor moPlaceHolder];
    MXSeparatorLine* line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [cell.contentView insertSubview:line atIndex:0];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.left.equalTo(cell.contentView).offset(15);
        make.right.equalTo(cell.contentView).offset(-15);
        make.bottom.equalTo(cell.contentView);
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setSeparatorInset:UIEdgeInsetsMake(0, 5, 0, 5)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 &&  indexPath.row == 0){
        return 75;
    }
    return 50;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = [[self.data safeObjectAtIndex:indexPath.section] safeObjectAtIndex:indexPath.row];
    NSString* type = dict[@"type"];
    if ([type isEqualToString:@"avatar"]) {
        
        [[PhotoBrowser shared] showSelectSinglePhotoLibrary:self completion:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nullable assets, BOOL isOriginal) {
            if([images isKindOfClass:[NSArray class]]) {
                if([[images firstObject] isKindOfClass:[UIImage class]]) {
                    UIImage *image = [images firstObject];
                    [NotifyHelper showHUDAddedTo:self.view animated:YES];
                    [[QNManager shared] uploadImage:image completion:^(id data) {
                        if(data && [NSURL URLWithString:data]) {
                            [PersonalCenterHelper modifyUserInfo:@{@"head_photo": data,@"token":AppUserModel.token} completion:^(BOOL success, id object, NSString *error) {
                                if (success) {
                                    AppUserModel.head_photo = data;
                                    [self updateForLanguageChanged];
                                }
                                [NotifyHelper hideHUDForView:self.view animated:YES];
                            }];
                        }
                    }];
                }
            }
        }];
        
        return;
    }
    NSString* str = [dict valueForKey:@"vc"];
    if (![StringUtil isEmpty:str]) {
        [MXRouter openURL:str];
    }
//    if (indexPath.section == 0) {
//        if (indexPath.row == 1 ) {
////            [MXRouter openURL:[dict valueForKey:@"vc"] parameters:@{@"placeholder":Lang(@"输入新的昵称"),@"text":AppUserModel.username ?: @""}];
//        }else if(indexPath.row == 2){
//            [MXRouter openURL:@"lcwl://UpdatePhoneVC"];
//        }
//    }else if(indexPath.section == 1){
//        if (indexPath.row == 0) {
//            [MXRouter openURL:@"lcwl://LoginPwdSettingVC"];
//        }else if(indexPath.row == 1){
//            [MXRouter openURL:@"lcwl://BusinessPwdSettingVC"];
//        }
//    }else if(indexPath.section == 2){
//
//    }
   
   
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        AdjustTableBehavior(_tableView);
        _tableView.separatorColor = [UIColor moBackground];
        _tableView.tableFooterView = self.footerView;
    }
    
    return _tableView;
}

-(void)scanClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)loginoutBnt {
    if(!_loginoutBnt) {
        _loginoutBnt=[UIButton buttonWithType:UIButtonTypeCustom];
        _loginoutBnt.frame = CGRectMake(-1, 0, SCREEN_WIDTH+2, 44);
        [_loginoutBnt setTitle:Lang(@"退出登录") forState:UIControlStateNormal];
        _loginoutBnt.titleLabel.font = [UIFont systemFontOfSize:17];
        _loginoutBnt.backgroundColor = [UIColor darkGreen];
        [_loginoutBnt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginoutBnt.layer.masksToBounds = YES;
        _loginoutBnt.layer.cornerRadius = 5;
        [_loginoutBnt addTarget:self action:@selector(loginoutClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginoutBnt;
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

- (void)loginoutClick {
    [self userLogOut:@{@"token":AppUserModel.token} completion:^(BOOL success, NSString *error) {
        if (success) {
            AppDelegate* app = MoApp;
            if ([app respondsToSelector:@selector(enterLoginPage)]) {
                [app performSelector:@selector(enterLoginPage) withObject:nil afterDelay:0];
                
            }
        }
    }];
}

@end
