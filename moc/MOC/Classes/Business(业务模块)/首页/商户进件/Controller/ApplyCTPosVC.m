//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "ApplyCTPosVC.h"
#import "ImgTextTextView.h"
#import "ApplyScanPayVC.h"
#import "IIViewDeckController.h"
#import "ScanTraditionalPosModel.h"
#import "MerchantRegistVC.h"
@interface ApplyCTPosVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong , nonatomic) IIViewDeckController *viewDeckController;



@end

@implementation ApplyCTPosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarTitle:@"传统POS"];

    self.dataSource = [[NSMutableArray alloc]initWithArray: @[
                                                                  @{@"image":@"新增商户",@"text":@"新增商户",@"vc":@"xzsh"},
                                                                  @{@"image":@"商户进件查询",@"text":@"商户进件查询",@"vc":@"lcwl://PosInputInquiryVC"},
                                                                  @{@"image":@"扫码支付",@"text":@"申请扫码支付",@"vc":@"lcwl://ApplyScanPayVC"}
                       ]];
    [self.view addSubview:self.tableView];
    AdjustTableBehavior(self.tableView);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary* dict = self.dataSource[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:dict[@"image"]];
    cell.textLabel.text = dict[@"text"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* dict = self.dataSource[indexPath.row];
    NSString* vcString = dict[@"vc"];
    if (![StringUtil isEmpty:vcString]) {
        if ([vcString isEqualToString:@"lcwl://ApplyScanPayVC"]) {
            ApplyScanPayVC* vc = [[ApplyScanPayVC alloc]init];
            self.viewDeckController = [[IIViewDeckController alloc] initWithCenterViewController:vc rightViewController:nil];
            self.viewDeckController.title = @"申请扫码支付";
            UIButton    * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
            [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
            [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
            leftBtn.enabled = NO;
            [leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
            self.viewDeckController.navigationItem.leftBarButtonItem = leftBarItem ;
            
            UIButton    * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
            [rightBtn setTitle:@"申请记录" forState:UIControlStateNormal];
            rightBtn.titleLabel.font = [UIFont font15];
            [rightBtn setTitleColor:[UIColor moBlack] forState:UIControlStateNormal];
            [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
            rightBtn.enabled = NO;
            [rightBtn addTarget:self action:@selector(record:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
            self.viewDeckController.navigationItem.rightBarButtonItem = rightBarItem ;
            
            //添加完成btn
            [self.navigationController pushViewController:self.viewDeckController animated:YES];
            return;
        }else if([vcString isEqualToString:@"xzsh"]){
            MerchantRegistVC* vc = [[MerchantRegistVC alloc]init];
            self.viewDeckController = [[IIViewDeckController alloc] initWithCenterViewController:vc rightViewController:nil];
            self.viewDeckController.title = @"申请扫码支付";
            UIButton    * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
            [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
            [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
            leftBtn.enabled = NO;
            [leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
            self.viewDeckController.navigationItem.leftBarButtonItem = leftBarItem ;
            
            //添加完成btn
            [self.navigationController pushViewController:self.viewDeckController animated:YES];
            
            
            return;
            
            
        }
        /*
         4.2 修改商户  传入账号、商户名、当前控制器 other为成功时传回字段
         - (void)changeInfoWithAccount:(NSString *)account merchantName:(NSString *)merName viewController:(UIViewController *)vc other:(NSString *)other;
         */
        
        
        [MXRouter openURL:vcString];
    }
}


///失败  返回错误信息
- (void)merchantManagerReturnError:(NSString *)msg{
    
}

///成功 返回商户信息、其他信息
- (void)merchantManagerReturnSuccess:(NSDictionary *)merchantInfo other:(NSString *)other{
    
}


-(void)record:(id)sender{
    [MXRouter openURL:@"lcwl://ApplyScanPayRecordVC"];
}
-(void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 0, 0));
        }];
    }
    return _tableView;
}


@end
