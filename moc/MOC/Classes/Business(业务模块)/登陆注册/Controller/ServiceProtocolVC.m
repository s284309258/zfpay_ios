//
//  ServiceProtocolVC.m
//  XZF
//
//  Created by mac on 2019/10/19.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ServiceProtocolVC.h"
@interface ServiceProtocolVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation ServiceProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

-(void)setupUI{
    [self setNavBarTitle:@"用户服务协议"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight, 0));
    }];
    self.dataArray = @[@"service1",@"service2",@"service3",@"service4",@"service5",@"service6",@"service7",@"service8"];
    [self.tableView reloadData];
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView* cover = [UIImageView new];
        cover.tag = 101;
        [cell.contentView addSubview:cover];
        [cover mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    UIImageView* cover = [cell.contentView viewWithTag:101];
    NSString* image = self.dataArray[indexPath.row];
    cover.image = [UIImage imageNamed:image];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_WIDTH*1700.0/1200.0;
}
@end
