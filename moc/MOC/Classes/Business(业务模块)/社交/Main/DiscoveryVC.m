//
//  DiscoveryVC.m
//  BOB
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 AlphaGo. All rights reserved.
//

#import "DiscoveryVC.h"
#import "BaseSTDTableViewCell.h"

@interface DiscoveryVC ()

@end

@implementation DiscoveryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self updateForLanguageChanged];
    [self setNavBarTitle:@"区块"];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
}

- (void)navBarRightBtnAction:(id)sender {
    [MXRouter openURL:@"lcwl://MessageCenterVC"];
}

#pragma mark - setup
- (void)configTableView:(UITableView *)tableView
{
    tableView.backgroundColor = [UIColor moBackground];
    [tableView std_registerCellClass:[BaseSTDTableViewCell class]];
    
    STDTableViewSection *sectionData = [[STDTableViewSection alloc] initWithCellClass:[BaseSTDTableViewCell class]];
    [tableView std_addSection:sectionData];
    
    sectionData = [[STDTableViewSection alloc] initWithCellClass:[BaseSTDTableViewCell class]];
    [tableView std_addSection:sectionData];
    
    sectionData = [[STDTableViewSection alloc] initWithCellClass:[BaseSTDTableViewCell class]];
    [tableView std_addSection:sectionData];
}

- (void)setupTableViewDataSource
{
    BaseSTDCellModel *model = [BaseSTDCellModel model:@"区块圈" text:@"区块圈" rightIcon:@"Arrow" jumpVC:@"SocialContactMainVC"];
    //model.textFont = [UIFont systemFontOfSize:17];
    
    [self.tableView std_addItems:@[[BaseSTDTableViewCell cellItemWithData:model cellHeight:50]] atSection:0];
    
    BaseSTDCellModel *model1 = [BaseSTDCellModel model:@"_扫一扫" text:@"扫一扫" rightIcon:@"Arrow" jumpVC:@"MXBarReaderVC"];
    //model1.textFont = [UIFont systemFontOfSize:17];
    
    BaseSTDCellModel *model2 = [BaseSTDCellModel model:@"搜一搜" text:@"搜一搜" rightIcon:@"Arrow" jumpVC:@""];
    //model2.textFont = [UIFont systemFontOfSize:17];
    [self.tableView std_addItems:@[[BaseSTDTableViewCell cellItemWithData:model1 cellHeight:50],
                                   [BaseSTDTableViewCell cellItemWithData:model2 cellHeight:50]] atSection:1];
    
    BaseSTDCellModel *model3 = [BaseSTDCellModel model:@"购物" text:@"购物" rightIcon:@"Arrow" jumpVC:@""];
    //model3.textFont = [UIFont systemFontOfSize:17];
    
    BaseSTDCellModel *model4 = [BaseSTDCellModel model:@"游戏" text:@"游戏" rightIcon:@"Arrow" jumpVC:@""];
    //model4.textFont = [UIFont systemFontOfSize:17];
    [self.tableView std_addItems:@[[BaseSTDTableViewCell cellItemWithData:model3 cellHeight:50],
                                   [BaseSTDTableViewCell cellItemWithData:model4 cellHeight:50]] atSection:2];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0 || (indexPath.section == 1 && indexPath.row == 0)) {
        return [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    } else {
        [NotifyHelper showMessageWithMakeText:Lang(@"暂未开放")];
    }
}
@end
