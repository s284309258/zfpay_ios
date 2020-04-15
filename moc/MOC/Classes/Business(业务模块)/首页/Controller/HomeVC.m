//
//  PersonalCenterVC.m
//  AdvertisingMaster
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "HomeVC.h"
#import "UIView+Utils.h"
#import "ItemCollectionView.h"
#import "OttoCycleLabel.h"
#import <SDCycleScrollView.h>
//#import <WebKit/WebKit.h>
#import "PersonalCenterHelper.h"
#import "ItemModel.h"
#import "NSObject+Home.h"
#import "THLabel.h"
#import "ArticleListView.h"
#import "RFHeader.h"
#import "ShareOverlayer.h"
#import "IIViewDeckController.h"
#import "ApplyMPosVC.h"
#import "NoticeModel.h"
#import "NewsListModel.h"
#import "AppImgModel.h"
#import "QNManager.h"
#import "ShareManager.h"
#import "ItemModel.h"
static float bannerWidth = 375;
static float bannerHeight = 150.0;
static NSInteger headerHeight = 60;
static NSInteger itemHeight = 90;
@interface HomeVC ()<UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
//公告
@property (strong, nonatomic) OttoCycleLabel *cycleLabel;
//公告背景
@property (strong, nonatomic) UIView *cycleLabelView;
// 轮播图
@property (strong , nonatomic) SDCycleScrollView *cycleScrollView;

@property (strong , nonatomic) NSArray *noticeArray;

@property (strong , nonatomic) NSArray *newsArray;

@property (strong , nonatomic) NSArray *appImgArray;

@property (strong , nonatomic) NSArray *shareAppImgArray;

@property (strong , nonatomic) ItemCollectionView* collectionView ;

@property (strong , nonatomic) IIViewDeckController *viewDeckController;

@end

@implementation HomeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshRedPoint];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)refreshRedPoint{
    [self getUnReadNews:@{} completion:^(id object, NSString *error) {
        if (object) {
            [[NSUserDefaults standardUserDefaults]setObject:[object valueForKey:@"collegeFlag"] forKey:@"collegeFlag"];
            [[NSUserDefaults standardUserDefaults]setObject:[object valueForKey:@"applyRateFlag"] forKey:@"applyRateFlag"];
            [[NSUserDefaults standardUserDefaults]setObject:[object valueForKey:@"recallFlag"] forKey:@"recallFlag"];
            [[NSUserDefaults standardUserDefaults]setObject:[object valueForKey:@"cardFlag"] forKey:@"cardFlag"];
            
            [[NSUserDefaults standardUserDefaults]setObject:[object valueForKey:@"appImgFlag"] forKey:@"appImgFlag"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"BadgeNotification" object:object];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    [self setNavBarTitle:@"中掌柜"];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.cycleScrollView;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(@(-(TabbarHeight)));
    }];
    
    @weakify(self)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        @strongify(self)
        [self getNewNotice:@{} completion:^(id object, NSString *error) {
            [self.tableView.header endRefreshing];
            if (object) {
                self.noticeArray = object;
                if (self.noticeArray) {
                    NSMutableArray* strArray = [[NSMutableArray alloc]initWithCapacity:10];
                    [self.noticeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NoticeModel* model = (NoticeModel *)obj;
                        [strArray addObject:model.notice_title];
                    }];
                    self.cycleLabel.textsArr = strArray;
                    [self.cycleLabel startCycling];
                }
            }
        }];
        [self getNewNews:@{} completion:^(id object, NSString *error) {
            [self.tableView.header endRefreshing];
            if (object) {
                self.newsArray = object;
                [self.tableView reloadData];
            }
        }];
    }];
}

-(void)initData{
    self.noticeArray = @[];
    self.newsArray = @[];
    self.appImgArray = @[];
    self.shareAppImgArray = @[];
    [self.tableView reloadData];
    @weakify(self)
    [self getNewNotice:@{} completion:^(id object, NSString *error) {
        @strongify(self)
        if (object) {
            self.noticeArray = object;
            if (self.noticeArray) {
                NSMutableArray* strArray = [[NSMutableArray alloc]initWithCapacity:10];
                [self.noticeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NoticeModel* model = (NoticeModel *)obj;
                    [strArray addObject:model.notice_title];
                }];
                self.cycleLabel.textsArr = strArray;
                [self.cycleLabel startCycling];
            }
        }
    }];
    [self getNewNews:@{} completion:^(id object, NSString *error) {
        if (object) {
            self.newsArray = object;
            [self.tableView reloadData];
        }
    }];
    
    [self getAppImgList:@{@"img_type":@"01"} completion:^(id array, NSString *error) {
        if (array) {
            self.appImgArray = array;
            NSMutableArray* tmpArray = [[NSMutableArray alloc]initWithCapacity:10];
            [self.appImgArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                AppImgModel* appImg = obj;
                NSString* url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,appImg.img_url];
                [tmpArray addObject:url];
            }];
            _cycleScrollView.imageURLStringsGroup = tmpArray;
        }
    }];
    return;
    [self getAppImgList:@{@"img_type":@"02"} completion:^(id array, NSString *error) {
        if (array) {
            NSArray* shareArray = (NSArray*)array;
            NSMutableArray* tmpArray = [[NSMutableArray alloc]initWithCapacity:10];
            [shareArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                AppImgModel* appImg = obj;
                NSString* url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,appImg.img_url];
                [tmpArray addObject:url];
            }];
            
            self.shareAppImgArray = tmpArray;
           
        }
    }];
}

- (SDCycleScrollView *)cycleScrollView {
    if(!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*bannerHeight/bannerWidth) delegate:self placeholderImage:nil];
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.autoScrollTimeInterval = 5.0;
        _cycleScrollView.layer.masksToBounds = YES;
       
    }
    return _cycleScrollView;
}

-(void)recordAction:(id)sender{
    [MXRouter openURL:@"lcwl://MyOrderVC"];
}

-(void)scanAction:(id)sender{
    [MXRouter openURL:@"lcwl://MXBarReaderVC" parameters:nil];
}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return self.newsArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSString* identifier = @"section0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:self.collectionView];
            [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }
        return cell;
    }else if(indexPath.section == 1) {
        NSString* identifier = @"section1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor whiteColor];
            ArticleListView* articleView = [[ArticleListView alloc]initWithFrame:CGRectZero];
            articleView.tag = 101;
            
            [cell.contentView addSubview:articleView];
            cell.backgroundColor = [UIColor clearColor];
            [articleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
            }];
        }
        NewsListModel* model = [self.newsArray objectAtIndex:indexPath.row];
        ArticleListView* tmp = [cell.contentView viewWithTag:101];
        [tmp reloadData:model];
        return cell;
    }else if(indexPath.section == 2) {
        
    }
   
    
    
    return nil;
}

-(void)back:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.collectionView.viewHeight;
    }else if(indexPath.section == 1){
        return 110;
    }
    return 95;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsListModel* model = self.newsArray[indexPath.row];
    [MXRouter openURL:@"lcwl://NewsDetailVC" parameters:@{@"news_id":model.news_id}];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    __block UIView* headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    RFHeader *header = [[RFHeader alloc]init];
    [headerView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headerView);
        make.left.equalTo(headerView).offset(15);
        make.right.equalTo(headerView).offset(-15);
    }];
    NSDictionary* dict =  @{@"color":@"#01C088",@"left":@"行业资讯",@"right":@""};
    [header reloadColor:dict[@"color"] left:dict[@"left"] right:dict[@"right"]];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 44;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return self.cycleLabelView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return headerHeight;
    }
    return 0;
}

- (UIView *)cycleLabelView {
    if(!_cycleLabelView) {
        CGFloat height = headerHeight;
        _cycleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        UIView* backView =  [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, height-20)];
        backView.backgroundColor = [UIColor whiteColor];
        [_cycleLabelView addSubview:backView];
        _cycleLabelView.backgroundColor =  [UIColor colorWithHexString:@"#F2F2F2"];

        self.cycleLabel.x = 50;
       self.cycleLabel.width = SCREEN_WIDTH - self.cycleLabel.x - 23;
       [backView addSubview:self.cycleLabel];
        
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"通知"]];
        icon.frame = CGRectMake(0, 0, 30, 30);
        [backView addSubview:icon];
        
        UIImageView *rightIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"更多"]];
        [backView addSubview:rightIcon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backView).offset(15);
            make.width.height.equalTo(@(30));
            make.centerY.equalTo(backView);
        }];
        [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(backView).offset(-10);
            make.width.height.equalTo(@(13));
            make.centerY.equalTo(backView);
        }];
        
    }
    return _cycleLabelView;
}

- (OttoCycleLabel *)cycleLabel {
    if(!_cycleLabel) {
        _cycleLabel = [[OttoCycleLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerHeight-20) texts:nil];
        _cycleLabel.timeInterval = 1;
        _cycleLabel.backgroundColor = [UIColor whiteColor];
        _cycleLabel.directionMode = DirectionTransitionFromTop;
        _cycleLabel.textsArr = @[@"系统公告:MOCx全新系统上线"];
        _cycleLabel.textAlignment = NSTextAlignmentLeft;
        _cycleLabel.font = [UIFont font14];
        _cycleLabel.textColor = [UIColor moBlack];
        _cycleLabel.clickBlock = ^(id data) {
            [MXRouter openURL:@"lcwl://NoticeVC2"];
        };
        [_cycleLabel startCycling];
    }
    return _cycleLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        _tableView.tableFooterView = footer;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        AdjustTableBehavior(_tableView);
    }
    return _tableView;
}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [NotifyHelper showMessageWithMakeText:msg];
}

-(ItemCollectionView* )collectionView{
    if (!_collectionView) {
        _collectionView = [ItemCollectionView new];
        @weakify(self)
        _collectionView.block = ^(id data) {
            @strongify(self)
            if ([@"推广中心" isEqualToString:data]) {
                [ShareOverlayer showOverLayer:AppUserModel.qr_code_url share:^(id data) {
                    NSString* url = self.shareAppImgArray[[data intValue]];
                    NSString* tmp = AppUserModel.qr_code_url;
                    [ShareManager shareToWeChatPlatform:@"中掌柜" content:@"中掌柜" image:url url:tmp vc:
                    self];
                } save:^(id data) {
                    if (data) {
                        UIImageWriteToSavedPhotosAlbum(data, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
                    }
                } imgArray:self.shareAppImgArray];
            }
        };
    }
    return _collectionView;
}

@end
