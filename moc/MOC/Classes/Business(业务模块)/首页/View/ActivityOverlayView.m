//
//  ReportView.m
//  HWPanModal_Example
//
//  Created by mac on 2019/6/29.
//  Copyright © 2019 wangcongling. All rights reserved.
//

#import "ActivityOverlayView.h"
#import <Masonry.h>
#import "PosSliderView.h"
#import "TextTextImgView.h"
#import "PosActivityRewardModel.h"
static NSInteger leftPadding = 15;
static NSInteger rowHeight = 65;
@interface ActivityOverlayView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UILabel* titleLbl;

@property (nonatomic , strong) UITableView* tableView;

@property (nonatomic , strong) NSArray* dataArray;

@property (strong, nonatomic) UIButton *nextBtn;

@property (strong, nonatomic) UIView* titleView;

@property (strong, nonatomic) PosActivityRewardModel *selectModel;


@end

@implementation ActivityOverlayView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.dataArray = @[];
        [self initUI];
        [self layout];
    }
    return self;
}


-(NSInteger)getHeight{
    return 400;
}

-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    self.titleView = [[UIView alloc]initWithFrame:CGRectZero];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(50));
    }];
    [self.titleView addSubview:self.titleLbl];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self.titleView);
    }];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(leftPadding);
        make.right.equalTo(self).offset(-leftPadding);
        make.top.equalTo(self.titleView.mas_bottom);
        make.height.equalTo(@(4*rowHeight));
    }];
    [self addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(leftPadding);
        make.right.equalTo(self).offset(-leftPadding);
        make.top.equalTo(self.tableView.mas_bottom).offset(leftPadding);
        make.height.equalTo(@(44));
    }];
}

-(void)layout{
    
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellId];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        TextTextImgView* slider = [[TextTextImgView alloc]init];
        slider.tag = 101;
        [cell.contentView addSubview:slider];
        [slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
        MXSeparatorLine* line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
        [cell addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(cell);
            make.bottom.equalTo(cell.mas_bottom);
            make.height.equalTo(@(1));
        }];
    }
    TextTextImgView* tmp = [cell.contentView viewWithTag:101];
    PosActivityRewardModel* model = self.dataArray[indexPath.row];
    NSString* title = [NSString stringWithFormat:@"库存数量:%@台",model.pos_num];
    NSString* desc = [NSString stringWithFormat:@"交易额达到%@万,返现%@元",model.expenditure,model.reward_money];
    NSString* selectImg = @"";
    if (self.selectModel == model) {
        selectImg = @"勾选";
    }
    [tmp reloadTop:title bottom:desc right:selectImg];
    return cell;
    
}

-(UILabel* )titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLbl.text = @"请选择活动等级";
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    }
    return _titleLbl;
}

- (UIButton *)nextBtn {
    if(!_nextBtn) {
        _nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(15, 30, SCREEN_WIDTH-30, 44);
        [_nextBtn setTitle:Lang(@"确定") forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _nextBtn.backgroundColor = [UIColor darkGreen];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.clipsToBounds = YES;
        _nextBtn.layer.cornerRadius = 4;
        
        [_nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

-(void)next:(id)sender{
    if (self.block) {
        self.block(self.selectModel);
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectModel = self.dataArray[indexPath.row];
    [self.tableView reloadData];
}

-(void)configActivityModel:(NSArray*)activityArray{
    self.dataArray = activityArray;
    [self.tableView reloadData];
}
@end
