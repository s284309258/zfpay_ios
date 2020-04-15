//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "MineInfoCell.h"
#import "RFHeader.h"
#import "PersonalCenterHelper.h"
#import "RealNameModel.h"
#import <WebKit/WebKit.h>
#import "UIActionSheet+MKBlockAdditions.h"
#import "JSBadgeView.h"
#import "NSObject+Home.h"
@interface PersonalCenterVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSMutableArray *headerData;

@property (strong, nonatomic) MineInfoCell *header;

@property (strong, nonatomic) NSArray *telArray;

@end

@implementation PersonalCenterVC
- (void)viewWillAppear:(BOOL)animated {
     [super viewWillAppear:animated];
   
     [PersonalCenterHelper getUserAuthStatus:@{} completion:^(BOOL success, id object, NSString *error) {
          if (success) {
               RealNameModel *tmp = object;
               AppUserModel.real = tmp;
                 [self.header reload];
          }
     }];
     [self.tableView reloadData];
}

- (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view.
     [self setNavBarTitle:@"个人中心"];
     [self initUI];
     [self layout];
    
}

-(void)initUI{
     self.telArray = @[@"4007006889",@"4007700070"];
     self.headerData = @[@{@"color":@"#01C088",@"left":@"常用功能",@"right":@""}];
     self.dataSource = [[NSMutableArray alloc]initWithArray: @[
                                                                    @{@"image":@"结算卡中心",@"text":Lang(@"结算卡中心"),@"vc":@"lcwl://SettlementCardVC"},
                                                                    @{@"image":@"召回意见",@"text":Lang(@"召回意见"),@"vc":@"lcwl://RecallVC"},
                                                                    @{@"image":@"提现记录",@"text":Lang(@"提现记录"),@"vc":@"lcwl://CashOutRecordVC"},
     //                                                               @{@"image":@"实名认证",@"text":Lang(@"实名认证"),@"vc":@"lcwl://RealNameAuthVC"},
                                                                     @{@"image":@"实名认证",@"text":Lang(@"实名认证"),@"vc":@"lcwl://RealNameStatusVC"},
                                                                    @{@"image":@"消息",@"text":Lang(@"消息中心"),@"vc":@"lcwl://MessageCenterVC"},
                                                                    @{@"image":@"客服",@"text":Lang(@"客服中心"),@"vc":@"openQQ"}
                                                                    ]
                             
                             ];
               
   
     
     AdjustTableBehavior(self.tableView);
     [self setNavBarRightBtnWithTitle:nil andImageName:@"设置中心"];
     self.header = [MineInfoCell new];
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
     [self.header addGestureRecognizer:tap];
     self.header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
     self.tableView.tableHeaderView = self.header;
}
-(void)tapHandler:(id)sender{
     
     [MXRouter openURL:@"lcwl://SettingVC"];
}

-(void)layout{
     
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
     return [[UIView alloc]init];
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineVCCELL"];
     if(cell == nil) {
          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MineVCCELL"];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
          UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 65)];
          [cell.contentView insertSubview:bgView atIndex:0];
          cell.textLabel.font = [UIFont systemFontOfSize:15];
          
          UIButton *bnt = [[UIButton alloc] initWithFrame:CGRectZero];
          [cell.contentView addSubview:bnt];
          bnt.titleLabel.font = [UIFont systemFontOfSize:15];
          [bnt setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
          [bnt mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.bottom.equalTo(@(0));
               make.left.equalTo(@(15));
               make.right.equalTo(@(-15));
          }];
          bnt.tag = 999;
          bnt.userInteractionEnabled = NO;
          
          UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"更换"]];
          [bnt addSubview:arrow];
          [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
               make.right.equalTo(@(0));
               make.centerY.equalTo(bnt);
          }];
          
          JSBadgeView* badgeView = [[JSBadgeView alloc] initWithParentView:bnt alignment:JSBadgeViewAlignmentCenterLeft];
          badgeView.badgePositionAdjustment =  CGPointMake(SCREEN_WIDTH-60, 0);
          badgeView.isCircle = YES;
          badgeView.hidden = NO;
          badgeView.badgeText = @" ";
          badgeView.tag = 101;
          
          MXSeparatorLine* line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
          [cell.contentView addSubview:line];
          [line mas_makeConstraints:^(MASConstraintMaker *make) {
               make.height.equalTo(@(1));
               make.left.right.equalTo(cell.contentView);
               make.bottom.equalTo(cell.contentView);
          }];
     }
     UIButton *bnt = [cell.contentView viewWithTag:999];
     NSDictionary* dict = self.dataSource[indexPath.row];
     [bnt setImage:[UIImage imageNamed:dict[@"image"]] forState:UIControlStateNormal];
     [bnt setTitle:[NSString stringWithFormat:@"  %@",dict[@"text"]] forState:UIControlStateNormal];
     [bnt setTitleColor:[UIColor moBlack] forState:UIControlStateNormal];
      JSBadgeView *badge = [bnt viewWithTag:101];
     if([@"lcwl://RecallVC" isEqualToString:dict[@"vc"]]){
          NSString* recallFlag = [[NSUserDefaults standardUserDefaults]objectForKey:@"recallFlag"];
          badge.hidden = ![@"0" isEqualToString:recallFlag];
     }else if([@"lcwl://SettlementCardVC" isEqualToString:dict[@"vc"]]){
          NSString* cardFlag = [[NSUserDefaults standardUserDefaults]objectForKey:@"cardFlag"];
          badge.hidden = ![@"0" isEqualToString:cardFlag];
     }else{
          badge.hidden = YES;
     }
     return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     NSDictionary* dict =  self.dataSource[indexPath.row];
     if ([[dict valueForKey:@"vc"] isEqualToString:@"lcwl://RealNameStatusVC"]) {
//          if (!AppUserModel.real) {
               [PersonalCenterHelper getUserAuthStatus:@{} completion:^(BOOL success, id object, NSString *error) {
                    if (success) {
                         RealNameModel *tmp = object;
                         AppUserModel.real = tmp;
                         if ([tmp.auth_status isEqualToString:@"00"]) {
                              [MXRouter openURL:@"lcwl://RealNameAuthVC" parameters:nil];
                         }else{
                              [MXRouter openURL:[dict valueForKey:@"vc"] parameters:@{@"status":tmp}];
                         }
                    }
               }];
               return;
//          }else{
//               RealNameModel *tmp = AppUserModel.real;
//               if ([tmp.auth_status isEqualToString:@"00"]) {
//                    [MXRouter openURL:@"lcwl://RealNameAuthVC" parameters:nil];
//               }else{
//                    [MXRouter openURL:[dict valueForKey:@"vc"] parameters:@{@"status":tmp}];
//               }
//          }
//          return;
     }else if([[dict valueForKey:@"vc"] isEqualToString:@"openQQ"]){
          
          [UIActionSheet actionSheetWithTitle:@"" message:@"" buttons:@[[NSString stringWithFormat:@"传统POS客服电话:%@",self.telArray[0]], [NSString stringWithFormat:@"MPOS客服电话:%@",self.telArray[1]]] showInView:self.view onDismiss:^(NSInteger buttonIndex) {
               NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.telArray[buttonIndex]];
               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
          } onCancel:^{
               
          }];
          return;
     }else if([@"lcwl://RecallVC" isEqualToString:dict[@"vc"]]){
           [self updateNewsReadFlag:@{@"news_type":@"recallFlag",@"read_flag":@"1"} completion:^(BOOL success, NSString *error) {
              if (success) {
                  [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"recallFlag"];
                  [[NSUserDefaults standardUserDefaults]synchronize];
                   [self.tableView reloadData];
              }
          }];

     }else if([@"lcwl://SettlementCardVC" isEqualToString:dict[@"vc"]]){
           [self updateNewsReadFlag:@{@"news_type":@"cardFlag",@"read_flag":@"1"} completion:^(BOOL success, NSString *error) {
              if (success) {
                  [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"cardFlag"];
                  [[NSUserDefaults standardUserDefaults]synchronize];
                   [self.tableView reloadData];
              }
          }];

     }
     
     [MXRouter openURL:[dict valueForKey:@"vc"] parameters:nil];

     
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     __block UIView* headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
     RFHeader *header = [[RFHeader alloc]init];
     header.backgroundColor = [UIColor whiteColor];
     [headerView addSubview:header];
     [header mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.bottom.equalTo(headerView);
          make.left.equalTo(headerView).offset(15);
          make.right.equalTo(headerView).offset(-15);
     }];
     NSDictionary* dict =  self.headerData[section];
     [header reloadColor:dict[@"color"] left:dict[@"left"] right:dict[@"right"]];
     return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
     return 44;
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
               make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 0, 0));
          }];
     }
     return _tableView;
}

-(void)next:(id)sender{
     [MXRouter openURL:@"lcwl://AdjustRateVC"];
}

- (void)navBarRightBtnAction:(id)sender{
     [MXRouter openURL:@"lcwl://SettingVC"];
}
@end
