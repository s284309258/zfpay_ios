//
//  WhoCanSeeMyInfoVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/17.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "WhoCanSeeMyInfoVC.h"
#import "NSObject+MineHelp.h"

@interface WhoCanSeeMyInfoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation WhoCanSeeMyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.type == WhoCanSeeTypeInfo) {
        self.title = @"允许谁查看我的个人资料";
    } else {
        self.title = @"谁可以看";
    }
    [self setNavBarTitle:self.title];
    
    self.dataSource = @[@"公开",@"私密",@"好友"];
    
    if(![StringUtil isEmpty:self.value]) {
        [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj isEqualToString:self.value]) {
                self.selectIndex = idx;
            }
        }];
    }
    
    [self.view addSubview:self.tableView];
    AdjustTableBehavior(self.tableView);
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavBarRightBtnWithTitle:@"完成" andImageName:nil];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    barBtnItem.tintColor = [UIColor moBlack];
    self.navigationItem.leftBarButtonItem = barBtnItem;
    [self.navBarRightBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];;
}

- (void)navBarRightBtnAction:(id)sender {
    if(self.type == WhoCanSeeTypeDynamic) {
        Block_Exec(self.block,[NSString stringWithFormat:@"%d",self.selectIndex+1]);
        //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    } else {
        [self updateMyBaseInfo:@"detail_status" value:[NSString stringWithFormat:@"%d",_selectIndex+1] personalId:nil completion:^(id data) {
            @weakify(self)
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                ///1-公开  2-好友 3-私密
                @strongify(self)
                Block_Exec(self.block,[NSString stringWithFormat:@"%d",self.selectIndex+1]);
            }];
        }];
    }
}

- (void)backAction:(id)sender {
//    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//
//    }];
    [self.navigationController popViewControllerAnimated:YES];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(self.type == WhoCanSeeTypeInfo) {
        return 60;
    } else {
        return 0.01;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(self.type == WhoCanSeeTypeInfo) {
        UIView *header = [[UIView alloc]init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 50)];
        label.textColor = [UIColor moLineLighter];
        label.font = [UIFont systemFontOfSize:12];
        label.numberOfLines = 0;
        label.text = @"选择个人资料的可见范围，不在这个范围的好友将无法查看你的个人资料，但头像、昵称、性别和签名作为基本资料还可查看。";
        [header addSubview:label];
        return header;
    }
    return [UIView new];
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reusedIdentifier = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrivacySettingCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusedIdentifier];
    }
    
    cell.accessoryType = (self.selectIndex == indexPath.row ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);
    
    cell.textLabel.text = [self.dataSource safeObjectAtIndex:indexPath.row];
    if(indexPath.row == 0) {
        cell.detailTextLabel.text = @"所有朋友可见";
    } else if(indexPath.row == 0) {
        cell.detailTextLabel.text = @"仅自己可见";
    } else if(indexPath.row == 0) {
        cell.detailTextLabel.text = @"仅好友可见";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectIndex = indexPath.row;
    [self.tableView reloadData];
}


- (void)switchValueChange:(UISwitch *)sender {
    
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor moBackground];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    return _tableView;
}
@end
