//
//  SettingVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/16.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "MerchantAgentVC.h"
#import "MerchantListCell.h"
#import "SSSearchBar.h"
#import "RFHeader.h"
#import "ImgTextTextView.h"
#import "NSObject+Home.h"
#import "RefererAgencyModel.h"
#import "QNManager.h"
#import "ReferAgencyNumModel.h"
static NSString* reuseIdentifierBar = @"reuseIdentifierBar";
@interface MerchantAgentVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) SSSearchBar* barView;

@property (strong, nonatomic) NSString* keyword;

@property (strong, nonatomic) NSString* last_id;

@property (strong, nonatomic) ReferAgencyNumModel* referer;

@property (strong, nonatomic) UILabel* posNumLbl;


@end

@implementation MerchantAgentVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavBarTitle:@"我的代理商"];
    self.referer = [ReferAgencyNumModel new];
    self.dataSource = @[];
    AdjustTableBehavior(self.tableView);
    [self.view addSubview:self.barView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initData{
    
    self.last_id = @"";
    @weakify(self)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        @strongify(self)
        self.last_id = @"";
        [self getReferAgencyList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
             [self.tableView.header endRefreshing];
            if (array) {
                self.dataSource = array;
                [self.tableView reloadData];
                RefererAgencyModel* tmp = self.dataSource.lastObject;
                self.last_id = tmp.user_id;
            }
        }];
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        @strongify(self)
        [self getReferAgencyList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
            [self.tableView.footer endRefreshing];
            if (array) {
                [self.dataSource addObjectsFromArray: array];
                [self.tableView reloadData];
                RefererAgencyModel* tmp = self.dataSource.lastObject;
                self.last_id = tmp.user_id;
            }
        }];
    }];
    [self getReferAgencyList:@{@"last_id":self.last_id,@"key_word":self.keyword} completion:^(id array, NSString *error) {
        if (array) {
            self.dataSource = array;
            [self.tableView reloadData];
            RefererAgencyModel* tmp = self.dataSource.lastObject;
            self.last_id = tmp.user_id;
        }
    }];
    [self getReferAgencyNum:@{} completion:^(id object, NSString *error) {
        if (object) {
            self.referer = object;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    __block UIView* headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    RFHeader *header = [[RFHeader alloc]init];
    header.backgroundColor =  [UIColor colorWithHexString:@"#EFEFF4"];
    [headerView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headerView);
        make.left.equalTo(headerView).offset(15);
        make.right.equalTo(headerView).offset(-15);
    }];
   
    [header reloadColor:@"#1CCC9A" left:[NSString stringWithFormat:@"总人数:%@人",self.referer.referer_num] right:@""];

    [headerView addSubview:self.posNumLbl];
    [self.posNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headerView);
        make.right.equalTo(@(-15));
    }];
    NSString* tra_pos_num = self.referer.tra_pos_num;
    NSString* tra_act_num = self.referer.tra_act_num;
    NSString* tra_inact_num = self.referer.tra_inact_num;
    tra_pos_num = tra_pos_num?:@"0";
    tra_act_num = tra_act_num?:@"0";
    tra_inact_num = tra_inact_num?:@"0";
    if (![StringUtil isEmpty:tra_pos_num]&&![StringUtil isEmpty:tra_act_num]&&![StringUtil isEmpty:tra_inact_num]) {
        NSString* str1 = [NSString stringWithFormat:@"传统POS共计%@台",tra_pos_num];
        NSMutableAttributedString* attr1 = [[NSMutableAttributedString alloc]initWithString:str1];
        [attr1 addFont:[UIFont font11] substring:str1];
        [attr1 addColor:[UIColor moBlack] substring:str1];
        {
            NSString* str = [NSString stringWithFormat:@" 已激活%@",tra_act_num];
            NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
            [attr addColor:[UIColor lightGrayColor] substring:@"已激活"];
            [attr addFont:[UIFont font11] substring:@"已激活"];
            [attr addColor:[UIColor moGreen] substring:tra_act_num];
            [attr addFont:[UIFont systemFontOfSize:13] substring:tra_act_num];
            [attr1 appendAttributedString:attr];
        }
        {
            NSString* str = [NSString stringWithFormat:@" 未激活%@",tra_inact_num];
            NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
            [attr addColor:[UIColor lightGrayColor] substring:@"未激活"];
            [attr addFont:[UIFont font11] substring:@"未激活"];
            [attr addColor:[UIColor moRed] substring:tra_inact_num];
            [attr addFont:[UIFont systemFontOfSize:13] substring:tra_inact_num];
            [attr1 appendAttributedString:attr];
        }
        
        NSString* m_pos_num = self.referer.m_pos_num;
        NSString* m_act_num = self.referer.m_act_num;
        NSString* m_inact_num = self.referer.m_inact_num;
        m_pos_num = m_pos_num?:@"0";
        m_act_num = m_act_num?:@"0";
        m_inact_num = m_inact_num?:@"0";
        NSString* str2 = [NSString stringWithFormat:@"\nMPOS共计%@台",m_pos_num];
        NSMutableAttributedString* attr2 = [[NSMutableAttributedString alloc]initWithString:str2];
        [attr2 addFont:[UIFont font11] substring:str2];
        [attr2 addColor:[UIColor moBlack] substring:str2];
        {
           NSString* str = [NSString stringWithFormat:@" 已激活%@",m_act_num];
           NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
           [attr addColor:[UIColor lightGrayColor] substring:@"已激活"];
           [attr addFont:[UIFont font11] substring:@"已激活"];
           [attr addColor:[UIColor moGreen] substring:m_act_num];
           [attr addFont:[UIFont systemFontOfSize:13] substring:m_act_num];
           [attr2 appendAttributedString:attr];
        }
        {
           NSString* str = [NSString stringWithFormat:@" 未激活%@",m_inact_num];
           NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
           [attr addColor:[UIColor lightGrayColor] substring:@"未激活"];
           [attr addFont:[UIFont font11] substring:@"未激活"];
           [attr addColor:[UIColor moRed] substring:m_inact_num];
           [attr addFont:[UIFont systemFontOfSize:13] substring:m_inact_num];
           [attr2 appendAttributedString:attr];
        }
        
        NSString* e_pos_num = self.referer.e_pos_num;
        NSString* e_act_num = self.referer.e_act_num;
        NSString* e_inact_num = self.referer.e_inact_num;
        e_pos_num = e_pos_num?:@"0";
        e_act_num = e_act_num?:@"0";
        e_inact_num = e_inact_num?:@"0";
        NSString* str3 = [NSString stringWithFormat:@"\nEPOS共计%@台",e_pos_num];
        NSMutableAttributedString* attr3 = [[NSMutableAttributedString alloc]initWithString:str3];
        [attr3 addFont:[UIFont font11] substring:str3];
        [attr3 addColor:[UIColor moBlack] substring:str3];
        {
           NSString* str = [NSString stringWithFormat:@" 已激活%@",e_act_num];
           NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
           [attr addColor:[UIColor lightGrayColor] substring:@"已激活"];
           [attr addFont:[UIFont font11] substring:@"已激活"];
           [attr addColor:[UIColor moGreen] substring:e_act_num];
           [attr addFont:[UIFont systemFontOfSize:13] substring:e_act_num];
           [attr3 appendAttributedString:attr];
        }
        {
           NSString* str = [NSString stringWithFormat:@" 未激活%@",e_inact_num];
           NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
           [attr addColor:[UIColor lightGrayColor] substring:@"未激活"];
           [attr addFont:[UIFont font11] substring:@"未激活"];
           [attr addColor:[UIColor moRed] substring:e_inact_num];
           [attr addFont:[UIFont systemFontOfSize:13] substring:e_inact_num];
           [attr3 appendAttributedString:attr];
        }

        [attr1 appendAttributedString:attr2];
        [attr1 appendAttributedString:attr3];
        [attr1 setLineSpacing:5 substring:attr1.string alignment:NSTextAlignmentRight];
        self.posNumLbl.attributedText = attr1;
    }
    
    
//    self.posNumLbl.text = [NSString stringWithFormat:@"传统POS数量:%@ 已激活:%@ 未激活:%@\nMPOS数量:%@ 已激活:%@ 未激活:%@",self.referer.tra_pos_num,self.referer.tra_act_num,self.referer.tra_inact_num,self.referer.m_pos_num,self.referer.m_act_num,self.referer.m_inact_num];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];;
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBar];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierBar];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        ImgTextTextView* view = [ImgTextTextView new];
        view.desc.textColor = [UIColor moPlaceHolder];
        view.tag = 101;
        [cell.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
    }
    RefererAgencyModel* model = self.dataSource[indexPath.row];
    ImgTextTextView* view = [cell.contentView viewWithTag:101];
    NSString* url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,model.head_photo];
    [view reloadLeft:url top:model.real_name bottom:model.user_tel];
    [view setImageSize:CGSizeMake(40, 40)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RefererAgencyModel* model = self.dataSource[indexPath.row];
    [MXRouter openURL:@"lcwl://AgentAddressBookVC" parameters:@{@"model":model}];
}


- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
      
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(45, 0, 0, 0));
        }];
    }
    return _tableView;
}

-(SSSearchBar*)barView{
    if (!_barView) {
        _barView  = [[SSSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 45.0)];
        _barView.placeholder = @"搜索姓名/手机号";
        _barView.backgroundColor = [UIColor whiteColor];
        _barView.delegate = self;
    }
    return _barView;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.last_id = @"";
    self.keyword = searchText;
    [self initData];
}

-(UILabel*)posNumLbl{
    if (!_posNumLbl) {
        _posNumLbl = [UILabel new];
        _posNumLbl.font = [UIFont font12];
        _posNumLbl.textColor = [UIColor moBlack];
        _posNumLbl.numberOfLines = 0 ;
    }
    return _posNumLbl;
}
@end
