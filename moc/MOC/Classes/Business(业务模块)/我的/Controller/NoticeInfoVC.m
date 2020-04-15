//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "NoticeInfoVC.h"
#import "PersonalCenterHelper.h"
#import "QNManager.h"
#import "NoticeModel.h"
#import "XHWebImageAutoSize.h"

@interface NoticeInfoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic) NSInteger textHeight;

@property (nonatomic ,strong)  NoticeModel* model;

@property (strong, nonatomic) NSMutableArray *imgArray;


@end

@implementation NoticeInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavBarTitle:@"详情"];
    self.imgArray = @[];
    self.textHeight = 0;
    [self.view addSubview:self.tableView];
    AdjustTableBehavior(self.tableView);
}


-(void)initData{
    [PersonalCenterHelper getNoticeDetail:@{@"notice_id":self.notice_id} completion:^(BOOL success, id object, NSString *error) {
        if (object) {
            self.model = object;
            self.imgArray = [self.model.notice_content componentsSeparatedByString:@","];
            [self.tableView reloadData];
            
            
        }
    }];
    

    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.imgArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 75;
    }else if(indexPath.section == 1){
         NSString* url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,self.imgArray[indexPath.row]];
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:url] layoutWidth:[UIScreen mainScreen].bounds.size.width estimateHeight:200];
    }
    return self.textHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.textLabel.text = self.model.notice_title;
        
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.detailTextLabel.text = self.model.cre_date;
        cell.detailTextLabel.textColor = [UIColor moPlaceHolder];
        return cell;
    }else if (indexPath.section == 1) {
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


@end
