//
//  SCUserContentVC.m
//  Lcwl
//
//  Created by mac on 2018/12/5.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "SCUserContentVC.h"
#import "MJRefresh.h"
#import "UIViewController+YNPageExtend.h"
#import "SCUserContentCell.h"
#import "UIAlertController+Blocks.h"
#import "SCRequestHelper.h"
#import "SocialDetailListModel.h"
#import "NSObject+YYModelExt.h"
#import "NSObject+YYModel.h"
#import "LXChatBoxManager.h"
#import "SCConfigManager.h"

/// 开启刷新头部高度
#define kOpenRefreshHeaderViewHeight 0

#define kCellHeight 44

@interface SCUserContentVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
/// 占位cell高度
@property (nonatomic, assign) CGFloat placeHolderCellHeight;
@property (nonatomic, assign) NSInteger page;
@end

@implementation SCUserContentVC

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.page = 1;
//    self.dataArray = [NSMutableArray arrayWithCapacity:1];
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.tableView.backgroundColor = [UIColor whiteColor];
//    
//    [self.tableView registerNib:[UINib nibWithNibName:@"SCUserContentCell" bundle:nil] forCellReuseIdentifier:@"SCUserContentCell"];
//    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self.view);
//        make.bottom.equalTo(@(-safeAreaInsetBottom()-60));
//    }];
//    
//    @weakify(self)
//    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
//        @strongify(self)
//        self.page ++;
//        [self getData];
//    }];
//    
//    [self getData];
//
//}
//
//- (void)getData {
//    NSString *pageStr = [NSString stringWithFormat:@"%@",@(self.page)];
//    if([self.title isEqualToString:@"转发"]) {
//        [SCRequestHelper getTransCircleInfoList:self.circle_id page:pageStr completion:^(id data) {
//            [self parseData:data];
//        }];
//    } else if([self.title isEqualToString:@"评论"]) {
//        [SCRequestHelper getCommentList:self.circle_id page:pageStr completion:^(id data) {
//            [self parseData:data];
//        }];
//    } else if([self.title isEqualToString:@"赞"]) {
//        [SCRequestHelper getPraiseInfoList:self.circle_id page:pageStr completion:^(id data) {
//            [self parseData:data];
//        }];
//    }
//}
//
//- (void)parseData:(NSDictionary *)dic {
//    [self.tableView.footer endRefreshing];
//    
//    BOOL success = [[dic valueForKey:@"success"] boolValue];
//    if(!success) {
//        self.page --;
//        return;
//    }
//    NSArray *arr = [dic valueForKey:@"data"];
//    if(arr && [arr isKindOfClass:[NSArray class]] && arr.count > 0) {
//        NSArray *tempArr = [NSArray modelsArrayWithClass:[SocialDetailListModel class] array:arr];
//        if(self.page == 1) {
//            [self.dataArray removeAllObjects];
//        }
//        [self.dataArray addObjectsFromArray:tempArr];
//        [self.tableView reloadData];
//    }
//}
//
////操作完数据本地进行插入数据
//- (void)insetData:(NSDictionary *)dic {
//    SocialDetailListModel *model = [SocialDetailListModel modelWithDictionary:dic];
//    model.user_id = [AppUserModel.user_id longLongValue];
//    model.user_name = AppUserModel.smartName ?: @"";
//    model.user_head_photo = AppUserModel.head_photo;
//    if(model) {
//        [self.dataArray safeAddObj:model];
//        [self.tableView reloadData];
//    }
//}
//
//- (void)removeData:(NSString *)itemId {
//    if(itemId == nil || itemId.length == 0) {
//        return;
//    }
//    
//    __block NSInteger index = -1;
//    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if([[obj valueForKey:@"_id"] longLongValue] == [itemId longLongValue]) {
//            index = idx;
//            *stop = YES;
//        }
//    }];
//    
//    if(index >= 0) {
//        [self.dataArray safeRemoveObjectAtIndex:index];
//        [self.tableView reloadData];
//    }
//}
//
//- (void)refreshUI {
//    self.backBut.hidden = !self.isShowBackButton;
//    [super setupInteractive];
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    //[super viewWillAppear:animated];
//    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
//    //     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    //        [self.tableView.mj_header beginRefreshing];
//    //    });
//}
//
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
//}
//
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
//}
//
//#pragma mark - 悬浮Center刷新高度方法
//- (void)suspendTopReloadHeaderViewHeight {
//    /// 布局高度
//    CGFloat netWorkHeight = 400;
//    __weak typeof (self) weakSelf = self;
//    
//
//}
//#pragma mark - 求出占位cell高度
//- (CGFloat)placeHolderCellHeight {
//    CGFloat height = self.config.contentHeight - kCellHeight * self.dataArray.count;
//    height = height < 0 ? 0 : height;
//    return height;
//}
//
//- (void)removeComment:(NSString *)circleId commentId:(NSString *)commentId index:(NSInteger)index {
//    [SCRequestHelper commentCircle:@"del" content:nil circleId:circleId commentId:commentId commentUserId:nil extraInfo:@{@"circle_user_id":[@(self.layout.status.user.userID) description]} completion:^(id data) {
//        if([[data valueForKey:@"success"] boolValue]) {
//            //[WBStatusHelper removeComment:cell.statusView.layout dic:@{@"id":_id ?: @""}];
//            [NotifyHelper showMessageWithMakeText:@"删除成功"];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.dataArray removeObjectAtIndex:index];
//                [self.tableView reloadData];
//            });
//        }
//    }];
//}
//
//- (void)showDeleteAlertController:(NSString *)circleId commentId:(NSString *)commentId index:(NSInteger)index {
//    [UIAlertController showActionSheetInViewController:self
//                                             withTitle:nil
//                                               message:nil
//                                     cancelButtonTitle:@"取消"
//                                destructiveButtonTitle:@"删除"
//                                     otherButtonTitles:nil
//                    popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {
//                        
//                    } tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
//                        if (buttonIndex == controller.cancelButtonIndex) {
//                            NSLog(@"Cancel Tapped");
//                        } else if (buttonIndex == controller.destructiveButtonIndex) {
//                            NSLog(@"Delete Tapped");
//                            [self removeComment:circleId commentId:commentId index:index];
//                        }
//                    }];
//}
//
//- (void)moreBntClick:(NSInteger)index {
//    SocialDetailListModel *model = [self.dataArray safeObjectAtIndex:index];
//    NSInteger userId = [[model valueForKey:@"user_id"] integerValue];
//    
//    if(userId == [AppUserModel.user_id integerValue]) {
//        [self showDeleteAlertController:self.circle_id commentId:$str(@"%ld",model._id) index:index];
//    } else {
//        [UIAlertController showActionSheetInViewController:self
//                                                 withTitle:nil
//                                                   message:nil
//                                         cancelButtonTitle:@"取消"
//                                    destructiveButtonTitle:nil
//                                         otherButtonTitles:@[@"回复", @"投诉", @"复制"]
//                        popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {
//                            
//                        } tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
//                            if (buttonIndex == 0) {
//                                NSLog(@"Cancel Tapped");
//                            } else if (buttonIndex == 2) { //回复
//                                [[LXChatBoxManager shared] showKeyBoard:$str(@"回复 %@",model.user_name ?: @"") block:^(NSString * _Nonnull msg) {
//                                    if(![SCConfigManager validateMsg:msg]) {
//                                        return;
//                                    }
//                                    [SCRequestHelper commentCircle:@"add" content:msg circleId:$str(@"%@",@(model.circle_id)) commentId:$str(@"%@",@(model._id)) commentUserId:$str(@"%@",@(model.user_id)) extraInfo:@{@"circle_user_id":[@(self.layout.status.user.userID) description]} completion:^(id data) {
//                                        if([[data valueForKey:@"success"] boolValue]) {
//                                            [NotifyHelper showMessageWithMakeText:@"评论成功"];
//                                            //[WBStatusHelper appendComment:cell.statusView.layout dic:[data valueForKey: @"data"]];
//                                            [self.tableView reloadData];
//                                        }
//                                    }];
//                                }];
//                            } else if (buttonIndex == 4) { //复制
//                                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//                                pasteboard.string = [model valueForKey:@"content"] ?: @"";
//                                NSLog(@"Delete Tapped");
//                            } else if (buttonIndex == 3) { //投诉
//                                [MXRouter openURL:@"lcwl://ReportViewController" parameters:@{@"circle_id":self.circle_id ?: @""}];
//                                NSLog(@"Other Button Index %ld", (long)buttonIndex - controller.firstOtherButtonIndex);
//                            }
//                        }];
//    }
//    
//}
//
//#pragma mark - UITableViewDelegate  UITableViewDataSource
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 0.00001;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15)];
//    
//    return view;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    
//    return 0.00001;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    
//    return [UIView new];
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataArray.count;
//}
//
////- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
////    return 80;
////}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    SCUserContentCell *cell = (SCUserContentCell *)[tableView dequeueReusableCellWithIdentifier:@"SCUserContentCell"];
//    [cell configUI:[_dataArray safeObjectAtIndex:indexPath.row] indexPath:indexPath];
//    [cell hideMoreBnt:![self.title isEqualToString:@"评论"]];
//    cell.block = ^(id data) {
//        if([data isKindOfClass:[NSNumber class]]) {
//            [self moreBntClick:[data integerValue]];
//        } else if([data isKindOfClass:[NSString class]]) {
//            [MXRouter openURL:@"lcwl://PersonalDetailVC" parameters:@{@"other_id":data}];
//        }
//    };
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    SocialDetailListModel *model = [_dataArray safeObjectAtIndex:indexPath.row];
//    
//    if([self.title isEqualToString:@"评论"]) {
//        if(model.user_id == [AppUserModel.user_id integerValue]) {
//            [self showDeleteAlertController:self.circle_id commentId:$str(@"%ld",model._id) index:indexPath.row];
//        } else {
//            [[LXChatBoxManager shared] showKeyBoard:$str(@"回复 %@",model.user_name ?: @"") block:^(NSString * _Nonnull msg) {
//                if(![SCConfigManager validateMsg:msg]) {
//                    return;
//                }
//                [SCRequestHelper commentCircle:@"add" content:msg circleId:$str(@"%@",@(model.circle_id)) commentId:$str(@"%@",@(model._id)) commentUserId:$str(@"%@",@(model.user_id)) extraInfo:@{@"circle_user_id":[@(self.layout.status.user.userID) description]} completion:^(id data) {
//                    if([[data valueForKey:@"success"] boolValue]) {
//                        [NotifyHelper showMessageWithMakeText:@"评论成功"];
//                        //[WBStatusHelper appendComment:cell.statusView.layout dic:[data valueForKey: @"data"]];
//                        [self.tableView reloadData];
//                    }
//                }];
//            }];
//        }
//    } else if([self.title isEqualToString:@"赞"]) {
//        [MXRouter openURL:@"lcwl://PersonalDetailVC" parameters:@{@"other_id":$str(@"%ld",model.user_id)}];
//    } else if([self.title isEqualToString:@"转发"]) {
//        [MXRouter openURL:@"lcwl://SCDetailFromTransferListVC" parameters:@{@"circle_id":$str(@"%ld",model.circle_id) ?: @""}];
//    }
//}
//
//- (UITableView *)tableView {
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.rowHeight = UITableViewAutomaticDimension;
//        _tableView.estimatedRowHeight = 60;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.showsVerticalScrollIndicator = NO;
//    }
//    return _tableView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 88;
//}
//
//- (void)dealloc {
//    NSLog(@"----- %@ delloc", self.class);
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [[LXChatBoxManager shared] hideKeyBoard];
//    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
//}

@end
