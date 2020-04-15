//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "NewsDetailVC.h"
#import "NSObject+Home.h"
#import "NewsListModel.h"
#import "RFHeader.h"
#import "QNManager.h"
#import "XHWebImageAutoSize.h"
#import "SPButton.h"
@interface NewsDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic,strong) NewsListModel* model;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (nonatomic ,strong) RFHeader* header;

@property (strong, nonatomic) NSMutableArray *imgArray;

@property (strong, nonatomic) SPButton *button;

@end

@implementation NewsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavBarTitle:@"详情"];
    self.dataSource = @[];
    self.imgArray = @[];
    [self.view addSubview:self.tableView];
    AdjustTableBehavior(self.tableView);
}


-(void)initData{
    [self getNewsDetail:@{@"news_id":self.news_id} completion:^(id object, NSString *error) {
        if (object) {
            self.model = object;
            self.imgArray = [self.model.news_content componentsSeparatedByString:@","];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.imgArray.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSString *url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,self.model.news_nav];
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:url] layoutWidth:[UIScreen mainScreen].bounds.size.width-16 estimateHeight:200];
    }else if(indexPath.section == 1){
        return 75;
    }else if(indexPath.section == 2){
        NSString *url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,self.imgArray[indexPath.row]];
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:url] layoutWidth:[UIScreen mainScreen].bounds.size.width-16 estimateHeight:200];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return [RFHeader getHeight];
    }
     return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
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
    }else {
         return [UIView new];
    }
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
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
            NSString* url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,self.model.news_nav];
            [cover sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                /** 缓存image size */
                [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                    /** reload  */
                    if(result)  [tableView  xh_reloadDataForURL:imageURL];
                }];
            }];
        }
        return cell;
        
    }
    if (indexPath.section == 1) {
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
            [cell.contentView addSubview:self.button];
            [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(60));
                make.height.equalTo(@(45));
                make.right.equalTo(cell.contentView).offset(-15);
                make.bottom.equalTo(cell.mas_bottom).offset(-5);
            }];
        }
        [self.button setTitle:self.model.browse_num forState:UIControlStateNormal];
        
        cell.textLabel.text = self.model.news_title;
        cell.detailTextLabel.text = self.model.cre_date;
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
            NSString* url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,self.imgArray[indexPath.row]];
            [cover sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                /** 缓存image size */
                [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                    /** reload  */
                    if(result)  [tableView  xh_reloadDataForURL:imageURL];
                }];
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

- (UIButton *)button{
    if (!_button) {
        _button = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionLeft];
        _button.frame = CGRectMake(0, 0, 65, 45);
        _button.titleLabel.font = [UIFont font14];
        [_button setImage:[UIImage imageNamed:@"浏览"] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor moPlaceHolder] forState:UIControlStateNormal];
    }
    return _button;
}
@end
