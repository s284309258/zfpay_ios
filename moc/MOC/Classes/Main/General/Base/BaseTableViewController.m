//
//  BaseTableViewController.m
//  MoPal_Developer
//
//  Created by Fly on 15/8/12.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UITableViewCell+CellUtils.h"
#import "MPBaseTableViewCell.h"

@interface BaseTableViewController ()

@property (strong, nonatomic) NSString         *cellReuseIdentifier;
@property (assign, nonatomic) UITableViewStyle tableViewStyle;

@end

@implementation BaseTableViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tableViewStyle = UITableViewStyleGrouped;
    }
    return self;
}


- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super init];
    if (self) {
        self.tableViewStyle = style;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self defaultConfigTableView];
    // Do any additional setup after loading the view.
}

#pragma mark - Public

- (void)showRemainingExpandCell{
    self.showMinifiedRow = 0;
    [self.tableView reloadData];
}

#pragma mark - Accessors

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    return _tableView;
}

- (NSMutableArray *)mutableDataSource
{
    if (!_mutableDataSource) {
        _mutableDataSource = [[NSMutableArray alloc] init];
    }
    return _mutableDataSource;
}

- (void)setShowMinifiedRow:(NSUInteger)showMinifiedRow{
    _showMinifiedRow = showMinifiedRow;
    
    if (showMinifiedRow > 0 &&
        showMinifiedRow < [self.mutableDataSource count]) {
        [self.tableView reloadData];
    }
}

- (BOOL)shouldShowMoreCell{
    return (self.showMinifiedRow > 0 &&
            self.showMinifiedRow < [self.mutableDataSource count]);
}

#pragma mark - ConfigTableView

- (void)defaultConfigTableView
{
    self.tableView.sectionFooterHeight = 20;
    if (_spliteType <= kSplitTypeSingleSection) {
        self.spliteType = kSplitTypeSingleSection;
    }
    self.tableView.backgroundColor = [UIColor moBackground];
    self.tableView.separatorColor = [UIColor moLineLight];
    //注册默认的cell
    [self registerCellClass:[MPBaseTableViewCell class] cellReuseId:cellReuseID];
    //去除最后的分割钱 plain
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //    self.tableView.separatorColor = [UIColor greenColor];
    AdjustTableBehavior(self.tableView);
}

- (void)registerTableViewNibWithCellClass:(Class)cellClass{
    [self registerCellNibName:NSStringFromClass(cellClass) cellReuseId:NSStringFromClass(cellClass)];
}
- (void)registerTableViewWithCellClass:(Class)cellClass{
    [self registerCellClass:cellClass cellReuseId:NSStringFromClass(cellClass)];
}

- (void)registerCellNibName:(NSString*)nibName
                cellReuseId:(NSString *)identifier{
    self.cellReuseIdentifier = identifier;
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil]forCellReuseIdentifier:identifier];
}

- (void)registerTableViewReuseHeaderFooter:(Class)viewClass{
    [self.tableView registerClass:viewClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(viewClass)];
}

- (void)registerCellClass:(Class)cellClass
              cellReuseId:(NSString *)identifier{
    self.cellReuseIdentifier = identifier;
    [self.tableView registerClass:cellClass forCellReuseIdentifier:identifier];
}


- (id)subItemAtIndexPath:(NSIndexPath *)indexPath
{
    id subItem = nil;
    switch (_spliteType) {
        case kSplitTypeSingleSection:
            if ([_mutableDataSource count] > indexPath.row) {
                subItem = _mutableDataSource[indexPath.row];
            }
            break;
        case kSplitTypeSingleRow:
            if ([_mutableDataSource count] > indexPath.section) {
                subItem = _mutableDataSource[indexPath.section];
            }
            break;
        case kSplitTypeSectionsRows:{
            if ([_mutableDataSource count] > indexPath.section) {
                id subItems = _mutableDataSource[indexPath.section];
                if ([subItems isKindOfClass:[NSArray class]] &&
                    [subItems count] > indexPath.row) {
                    subItem = subItems[indexPath.row];
                }
            }
            
            break;
        }
    }
    return subItem;
}

#pragma mark UITableViewmutableDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    switch (_spliteType) {
        case kSplitTypeSingleSection:
            return 1;
            break;
        case kSplitTypeSingleRow:
            return [_mutableDataSource count];
            break;
        case kSplitTypeSectionsRows:
            return [_mutableDataSource count];
            break;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_spliteType) {
        case kSplitTypeSingleSection:
            if (self.shouldShowMoreCell) {
                return self.showMinifiedRow + 1;
            }
            return [_mutableDataSource count];
            break;
        case kSplitTypeSingleRow:
            return 1;
            break;
        case kSplitTypeSectionsRows:{
            id subItems = _mutableDataSource[section];
            if ([subItems isKindOfClass:[NSArray class]]) {
                return [subItems count];
            }
            break;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellReuseIdentifier forIndexPath:indexPath];
    id subItem = [self subItemAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(configCellWithModel:)]) {
        [cell configCellWithModel:subItem];
    }
    return cell;
}


#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.shouldShowMoreCell &&
        self.showMinifiedRow  == indexPath.row){
        [self showRemainingExpandCell];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
