//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "ApplyScanPayVC.h"
#import "InvitationCodeView.h"
#import "RFHeader.h"
#import "MachineManageCell.h"
#import "TradeHBItemView.h"
#import "TextTextImgView.h"
#import "ScanPayPhotoView.h"
#import "IIViewDeckController.h"
#import "UIViewController+IIViewDeckAdditions.h"
#import "PhotoBrowser.h"
#import "QNManager.h"
#import "NSObject+Home.h"
#import "ScanTraditionalPosModel.h"

#import "ApplyScanPaySliderVC.h"
static NSString* reuseIdentifier = @"photo";
@interface ApplyScanPayVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *headerData;

@property (strong, nonatomic) UIButton *bottomBtn2;

@property (strong, nonatomic) NSMutableArray *typeArray;

@property (strong, nonatomic) NSString* value;

@property (strong, nonatomic) NSMutableArray* pos;

@property (nonatomic, strong) NSMutableArray* valueArray;

@end

@implementation ApplyScanPayVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarTitle:@"申请扫码支付"];
    [self setNavBarRightBtnWithTitle:@"申请记录" andImageName:nil];
    self.headerData = @[@{@"color":@"#01C088",@"left":@"申请类型",@"right":@""},
                        @{@"color":@"#01C088",@"left":@"POS机SN码",@"right":@""},
                        @{@"color":@"#01C088",@"left":@"上传照片",@"right":@""}];
    self.typeArray = @[@"微信、支付宝"];
    self.valueArray = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    self.pos  = [[NSMutableArray alloc]initWithCapacity:10];
    self.value = self.typeArray[0];
    AdjustTableBehavior(self.tableView);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 300;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
            if(cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell0"];
                TradeHBItemView* view = [[TradeHBItemView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,40) column:3];
                [view configData:self.typeArray];
                view.selectedBlock = ^(id data) {
//                    self.value = data;
//                    if ([self.typeArray indexOfObject:self.value] == 1) {
//                        self.headerData = @[@{@"color":@"#01C088",@"left":@"选择类型",@"right":@""},
//                                            @{@"color":@"#01C088",@"left":@"SN码",@"right":@""},
//                                            @{@"color":@"#01C088",@"left":@"商户号(可不填)",@"right":@""}];
//                    }else{
//                        self.headerData = @[@{@"color":@"#01C088",@"left":@"选择类型",@"right":@""},
//                                            @{@"color":@"#01C088",@"left":@"SN码",@"right":@""}];
//                    }
//                    [self.tableView reloadData];
                };
                view.tag = 101;
                cell.contentView.backgroundColor = [UIColor whiteColor];
                [cell.contentView addSubview:view];
                cell.backgroundColor = [UIColor clearColor];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
                }];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return cell;
        }
        case 1:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if(cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
                TextTextImgView* view = [[TextTextImgView alloc]init];
                [view isHiddenLine:NO];
                [view reloadImg:@"更多" title:@"请选择需要申请的SN码" desc:@""];
                view.title.textColor = [UIColor moPlaceHolder];
                view.tag = 101;
                cell.contentView.backgroundColor = [UIColor whiteColor];
                [cell.contentView addSubview:view];
                cell.backgroundColor = [UIColor clearColor];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
                }];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            TextTextImgView* view = [cell.contentView viewWithTag:101];
            
            [view reloadImg:@"更多" title:self.pos==nil?@"请选择需要申请的SN码":[self getPosStr:self.pos] desc:@""];
            view.title.adjustsFontSizeToFitWidth = NO;
            return cell;
        }
        case 2:{
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
            if (!cell) {
                cell = [[ScanPayPhotoView alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            ScanPayPhotoView* tmp = (ScanPayPhotoView*)cell;
            [tmp configData:@[@"营业执照",@"店铺内景",@"店铺门头",@"收银台"] value:self.valueArray];
            tmp.block = ^(id data) {
                __block NSIndexPath* path = data;
                [[PhotoBrowser shared] showPhotoLibrary:self completion:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nullable assets, BOOL isOriginal) {
                    if([images isKindOfClass:[NSArray class]]) {
                        if([[images firstObject] isKindOfClass:[UIImage class]]) {
                            UIImage *image = [images firstObject];
                            [[QNManager shared] uploadImage:image completion:^(id data) {
                                if(data && [NSURL URLWithString:data]) {
                                    [self.valueArray replaceObjectAtIndex:path.row withObject:data];
                                    [self.tableView reloadData];
                                }
                            }];
                        }
                    }
                }];
            };
            return cell;
        }
        default:
            break;
    }
    return  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"other"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        IIViewDeckController* tmp = [self viewDeckController];
        ApplyScanPaySliderVC* slider = [[ApplyScanPaySliderVC alloc]init];
        slider.block = ^(id data) {
            [self reloadPN:data];
        };
        [self.viewDeckController setRightViewController:slider];
        [tmp openSide:IIViewDeckSideRight animated:YES];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    __block UIView* headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    headerView.backgroundColor= [UIColor whiteColor];
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

-(UIButton*)bottomBtn2{
    if (!_bottomBtn2) {
        _bottomBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn2 setTitle:@"提交申请" forState:UIControlStateNormal];
        [_bottomBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomBtn2 setBackgroundColor:[UIColor darkGreen]];
        _bottomBtn2.layer.masksToBounds = YES;
        _bottomBtn2.layer.cornerRadius = 5;
        _bottomBtn2.titleLabel.font = [UIFont systemFontOfSize:16];
        [_bottomBtn2 addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
        _bottomBtn2.tag = 102;
    }
    return _bottomBtn2;
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [self.tableView registerClass:[ScanPayPhotoView class] forCellReuseIdentifier:reuseIdentifier];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(10, 0, 0, 0));
        }];
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        view.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = view;
        [view addSubview:self.bottomBtn2];
        [self.bottomBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(44));
            make.bottom.equalTo(view);
            make.left.equalTo(view).offset(15);
            make.right.equalTo(view).offset(-15);
            
        }];
    }
    return _tableView;
}

-(void)next:(id)sender{
    NSString* value0 = self.valueArray[0];
    NSString* value1 = self.valueArray[1];
    NSString* value2 = self.valueArray[2];
    NSString* value3 = self.valueArray[3];
    if ([StringUtil isEmpty:value0] || [StringUtil isEmpty:value1] || [StringUtil isEmpty:value2] || [StringUtil isEmpty:value3]) {
        [NotifyHelper showMessageWithMakeText:@"请上传图片"];
        return;
    }
    if (self.pos.count == 0) {
        [NotifyHelper showMessageWithMakeText:@"请选择需要申请的SN码"];
        return;
    }
    
    [self addApplyScanRecord:@{@"business_license":value0,
                               @"store_interior":value1,
                               @"shop_head":value2,
                               @"cashier_desk":value3,
                               @"sn_list":[self getPosStr:self.pos]
                               } completion:^(BOOL success, NSString *error) {
                                   if (success) {
                                       [self.navigationController popViewControllerAnimated:YES];
                                   }
    }];
    
}

-(void)navBarRightBtnAction:(id)sender{
    [MXRouter openURL:@"lcwl://ApplyScanPayRecordVC"];
}


-(void)reloadPN:(NSArray*)model{
    self.pos = model;
    [self.tableView reloadData];
}

-(NSString*)getPosStr:(NSArray*)array{
    NSArray *unionOfObjects = [array valueForKeyPath:@"@unionOfObjects.sn"];
    return [unionOfObjects componentsJoinedByString:@","];
}


@end
