//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "WalletStudyDetailVC.h"
#import "CTActivitiesView.h"
#import "NSObject+Home.h"
#import "MoneyLockerCollegeDetailModel.h"
#import "RFHeader.h"
#import "QNManager.h"
#import "SJVideoPlayer.h"
@interface WalletStudyDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic,strong) MoneyLockerCollegeDetailModel* model;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (nonatomic ,strong) RFHeader* header;

@property (nonatomic) NSInteger img_height;

@property (nonatomic ,strong) UIImageView* img;

@property (nonatomic ,strong)  UIImageView* imageview;

@property (nonatomic ,strong)  UIButton* playBtn;

@property (nonatomic, strong) SJBaseVideoPlayer *player;

@end

@implementation WalletStudyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavBarTitle:@"详情"];
    self.dataSource = @[];
    self.img_height = 500;
    [self.view addSubview:self.tableView];
    AdjustTableBehavior(self.tableView);
}


-(void)initData{
    [self getMoneyLockerCollegeDetail:@{@"money_locker_id":self.money_locker_id} completion:^(id object, NSString *error) {
        if (object) {
            self.model = object;
            NSString* url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,self.model.money_locker_content];
            self.img = [UIImageView new];
            [self.img sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                CGSize size = image.size;
                self.img_height = SCREEN_WIDTH*size.height/size.width;
                [self.tableView reloadData];
            }];
            url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,self.model.money_locker_cover];
            if ([self.model.money_locker_nav hasSuffix:@"jpg"] || [self.model.money_locker_nav hasSuffix:@"png"]) {
                self.playBtn.hidden = YES;
            }
            [self.imageview sd_setImageWithURL:[NSURL URLWithString:url]];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 75;
    }
    return self.img_height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return [RFHeader getHeight];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [UIView new];
    }
    __block UIView* headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    headerView.backgroundColor = [UIColor whiteColor];
    RFHeader *header = self.header;
    [headerView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headerView);
        make.left.equalTo(headerView).offset(15);
        make.right.equalTo(headerView).offset(-15);
    }];
    return headerView;
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            MXSeparatorLine* line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
            [cell.contentView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(cell.contentView);
                make.left.right.equalTo(cell.contentView);
                make.height.equalTo(@(1));
            }];
        }
        
        cell.textLabel.text = self.model.money_locker_title;
        cell.detailTextLabel.text = self.model.cre_datetime;
        cell.detailTextLabel.textColor = [UIColor moPlaceHolder];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView* cover = [UIImageView new];
            cover.tag = 101;
            [cell.contentView addSubview:cover];
            [cover mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }
        UIImageView* cover = [cell.contentView viewWithTag:101];
        if (self.model) {
            NSString* url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,self.model.money_locker_content];
            [cover sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            }];
        }
        return cell;
    }
    return nil;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        UIView* topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        self.imageview = [UIImageView new];
        [topView addSubview:self.imageview];
        self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.playBtn setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [topView addSubview:self.playBtn];
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(60));
            make.centerX.equalTo(topView);
            make.centerY.equalTo(topView);
        }];
        [self.playBtn addTarget:self action:@selector(videoPlay:) forControlEvents:UIControlEventTouchUpInside];
        [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(topView);
        }];
        _tableView.tableHeaderView = topView;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _tableView;
}

-(RFHeader*)header{
    if (!_header) {
        _header = [[RFHeader alloc]init];
        [_header reloadColor:@"#1CCC9A" left:@"详情介绍" rightImg:@"" rightText:@""];
    }
    return _header;
}

-(void)videoPlay:(id)sender{
      self.playBtn.hidden = YES;
    _player = [SJVideoPlayer player];
    NSString* url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,self.model.money_locker_nav];
    _player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:url]];
    [self.imageview addSubview:_player.view];
    self.imageview.userInteractionEnabled = YES;
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (BOOL)prefersStatusBarHidden {
    return [self.player vc_prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.player vc_preferredStatusBarStyle];
}
@end
