//
//  ReportView.m
//  HWPanModal_Example
//
//  Created by mac on 2019/6/29.
//  Copyright © 2019 wangcongling. All rights reserved.
//

#import "PosOverlayView.h"
#import <Masonry.h>
#import "PosSliderView.h"
#import "SSSearchBar.h"
#import "ScanTraditionalPosModel.h"
#import "SPButton.h"
static NSInteger leftPadding = 15;
static NSInteger rowHeight = 65;
@interface PosOverlayView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UILabel* titleLbl;

@property (nonatomic , strong) SPButton* rightBtn;

@property (nonatomic , strong) UITableView* tableView;

@property (nonatomic , strong) NSArray* dataArray;

@property (strong, nonatomic) UIButton *nextBtn;

@property (strong, nonatomic) UIView* titleView;

@property (strong, nonatomic) MXSeparatorLine* line;

@property (nonatomic) NSInteger selectIndex;

@property (strong, nonatomic) SSSearchBar* barView;

@property (strong, nonatomic) NSMutableArray* selectArray;

@property (strong, nonatomic) NSString* keyword;

@property (nonatomic , strong) NSMutableArray* filterArray;

@end

@implementation PosOverlayView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.selectArray = [[NSMutableArray alloc]initWithCapacity:10];
        self.dataArray = @[];
        self.filterArray = [[NSMutableArray alloc]initWithCapacity:10];
        self.keyword = @"";
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
    [self.titleView addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-leftPadding);
        make.centerY.equalTo(self.titleView);
        make.width.equalTo(@(80));
        make.height.equalTo(@(20));
    }];
    [self.titleView addSubview:self.titleLbl];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleView).offset(leftPadding);
        make.right.equalTo(self.rightBtn.mas_left);
        make.centerY.equalTo(self.titleView);
    }];
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self.titleView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl);
        make.right.equalTo(self.rightBtn);
        make.bottom.equalTo(self.titleView);
        make.height.equalTo(@(1));
    }];
    
    
    
    [self addSubview:self.tableView];
    self.barView  = [[SSSearchBar alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 45.0)];
    self.barView.placeholder = @"搜索SN码";
    self.barView.delegate = self;
    _tableView.tableHeaderView = self.barView;
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
    return self.filterArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
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
        PosSliderView* slider = [[PosSliderView alloc]init];
        slider.tag = 101;
        [cell.contentView addSubview:slider];
        [slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        MXSeparatorLine* line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
        [cell addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(cell);
            make.bottom.equalTo(cell.mas_bottom);
            make.height.equalTo(@(1));
        }];
    }
   
    PosSliderView* tmp = [cell.contentView viewWithTag:101];
    ScanTraditionalPosModel* model = self.filterArray[indexPath.row];
    
    BOOL isSelected = NO;
    if ([self.selectArray containsObject:model]) {
        isSelected = YES;
    }
    [tmp reload:model select:isSelected];
    return cell;
}

-(UILabel* )titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLbl.text = @"请选择POS机SN码";
        _titleLbl.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    }
    return _titleLbl;
}


- (SPButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
        _rightBtn.imageTitleSpace = 5;
        _rightBtn.frame = CGRectMake(0, 0, 80, 45);
        _rightBtn.titleLabel.font = [UIFont font14];
        [_rightBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateSelected];
        [_rightBtn setImage:[UIImage imageNamed:@"None"] forState:UIControlStateNormal];
        [_rightBtn setTitle:@"全选(0)" forState:UIControlStateNormal];
        [_rightBtn setTitle:@"全选(0)" forState:UIControlStateSelected];
        [_rightBtn setTitleColor:[UIColor moBlack] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor moBlack] forState:UIControlStateSelected];
        [_rightBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

-(void)click:(id)sender{
    _rightBtn.selected = !_rightBtn.selected;
    [self updateRightBtn];
    [self.tableView reloadData];
}


-(void)updateRightBtn{
    if (_rightBtn.selected) {
        [self.selectArray  removeAllObjects];
        [self.selectArray addObjectsFromArray:self.filterArray];
        [_rightBtn setTitleColor:[UIColor moBlack] forState:UIControlStateSelected];
        [_rightBtn setTitle:[NSString stringWithFormat:@"全选(%ld)",self.selectArray.count] forState:UIControlStateSelected];
    }else{
        [self.selectArray  removeAllObjects];
        [_rightBtn setTitleColor:[UIColor moBlack] forState:UIControlStateNormal];
        [_rightBtn setTitle:[NSString stringWithFormat:@"全选(%ld)",self.selectArray.count] forState:UIControlStateNormal];
    }
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
        self.block(self.selectArray);
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ScanTraditionalPosModel* model = self.filterArray[indexPath.row];
    BOOL bol  = [self.selectArray containsObject:model];
    //是否存在
    if (bol) {
        [self.selectArray removeObject:model];
    }else{
        [self.selectArray addObject:model];
    }
    [self.tableView reloadData];
     [_rightBtn setTitle:[NSString stringWithFormat:@"全选(%d)",self.selectArray.count] forState:UIControlStateSelected];
     [_rightBtn setTitle:[NSString stringWithFormat:@"全选(%d)",self.selectArray.count] forState:UIControlStateNormal];
}

-(void)configPosModel:(NSArray*)posArray{
    self.dataArray = posArray;
    [self getFilterArray];
    [self.tableView reloadData];
}



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.keyword = searchText;
    [self getFilterArray];
    [self.tableView reloadData];
}

-(NSArray*)getFilterArray{
    self.filterArray = [[NSMutableArray alloc]initWithCapacity:10];
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ScanTraditionalPosModel* model =  (ScanTraditionalPosModel*)obj;
        if ([StringUtil isEmpty:self.keyword]) {
            [self.filterArray addObject:model];
        }else{
            if ([model.sn rangeOfString:self.keyword].location!=NSNotFound) {
                [self.filterArray addObject:model];
            }
        }
    }];
    return self.filterArray;
}
@end
