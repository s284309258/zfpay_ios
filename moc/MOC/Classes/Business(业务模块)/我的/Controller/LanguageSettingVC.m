//
//  LanguageSettingVC.m
//  MOC
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "LanguageSettingVC.h"
#import "Language.h"

@interface LanguageSettingVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UIView *header;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *data;
@property(nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation LanguageSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarTitle:Lang(@"设置语言")];
    [self setNavBarRightBtnWithTitle:Lang(@"完成") andImageName:nil];
    
    self.view.backgroundColor = [UIColor moBackground];
    
    self.data = @[
                  @{@"title":@"简体中文",@"desc":@""},
                  @{@"title":@"英语",@"desc":@""},
                  @{@"title":@"法语",@"desc":@""},
                  @{@"title":@"俄罗斯语",@"desc":@""},
                  @{@"title":@"加拿大语",@"desc":@""}
                  ];
    [self.view addSubview:self.tableView];
    [self layoutUI];
}

- (void)layoutUI {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(@(0));
    }];
}

- (void)navBarRightBtnAction:(id)sender {
    [Language setLanguage:self.indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
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
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCELL"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingCELL"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    
    NSDictionary *dict = [self.data safeObjectAtIndex:indexPath.row];
    cell.textLabel.text = dict[@"title"];//[arr safeObjectAtIndex:0];
    if(self.indexPath.row == indexPath.row) {
        UIImageView *accessoryV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        accessoryV.image = [UIImage imageNamed:@"勾选"];
        cell.accessoryView = accessoryV;
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        //cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = nil;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.indexPath = indexPath;
    [self.tableView reloadData];
}

- (void)backAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChangedNotification object:nil];
    [super backAction:sender];
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

@end
