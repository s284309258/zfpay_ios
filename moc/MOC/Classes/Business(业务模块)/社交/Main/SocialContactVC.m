//
//  SocialContactVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/15.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "SocialContactVC.h"
#import "YYKit.h"
#import "WBModel.h"
#import "WBStatusLayout.h"
#import "WBStatusCell.h"
#import "YYTableView.h"
#import "YYSimpleWebViewController.h"
#import "WBStatusComposeViewController.h"
#import "YYPhotoGroupView.h"
#import "YYFPSLabel.h"
#import "UIAlertController+Blocks.h"
#import "SJVideoPlayer.h"
#import "SCRequestHelper.h"
#import "LXChatBoxManager.h"
#import "UIScrollView+ListViewAutoplaySJAdd.h"
#import "QNManager.h"
#import "MXBarReaderHelper.h"
#import "SCConfigManager.h"
#import "MJRefreshGifHeader.h"
#import "UIView+XDRefresh.h"
#import "VideoPlayManager.h"
#import "FriendsManager.h"

//#define locationData

@interface SocialContactVC ()<UITableViewDelegate, UITableViewDataSource, WBStatusCellDelegate,SJPlayerAutoplayDelegate>
@property (nonatomic, strong) NSMutableArray *layouts;
//@property (nonatomic, strong) YYFPSLabel *fpsLabel;
@property (nonatomic, strong) SJVideoPlayer *player;
@property (nonatomic, copy) NSString *circle_id;
@property (nonatomic, strong) UINavigationController *browsePhotoNav;
@property (nonatomic, strong) UIViewController *browsePhotoRootVC;
@property (nonatomic, strong) NSString *globalPasteString;
@end

@implementation SocialContactVC


- (instancetype)init {
    self = [super init];
    _tableView = [YYTableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    AdjustTableBehavior(_tableView);
    _layouts = [NSMutableArray new];
    return self;
}

- (void)dealloc {
    [self.view XD_freeReFresh];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.player vc_viewDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player vc_viewWillDisappear];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player vc_viewDidDisappear];
}

- (BOOL)prefersStatusBarHidden {
    return [self.player vc_prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.player vc_preferredStatusBarStyle];
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    //[super viewWillAppear:animated];
    [self refreshUI];
    //[[MXRouter sharedInstance] configureCurrentVC:self];
    //_tableView.mj_header.alpha = 0.2;

//    if(self.tableView.mj_header == nil) {
//        [self addTableViewRefresh];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector( setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[WBStatusHelper imageNamed:@"toolbar_compose_highlighted"] style:UIBarButtonItemStylePlain target:self action:@selector(sendStatus)];
    rightItem.tintColor = UIColorHex(fd8224);
    self.navigationItem.rightBarButtonItem = rightItem;

    _tableView.frame = self.view.bounds;
    //_tableView.height -= (TabbarHeight+safeAreaInsetBottom());

    //_tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    //_tableView.backgroundColor = [UIColor colorWithHexString:@"#434443"];
    _tableView.backgroundView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *footer = [UIView new];
    footer.backgroundColor = [UIColor whiteColor];
    footer.height = (safeAreaInsetBottom());
    _tableView.tableFooterView = footer;

    // 配置列表自动播放
//    [_tableView sj_enableAutoplayWithConfig:[SJPlayerAutoplayConfig configWithPlayerSuperviewTag:101 autoplayDelegate:self]];
//    [_tableView sj_needPlayNextAsset];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update:) name:@"SocialContactListUpdate" object:nil];


//    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    indicator.size = CGSizeMake(80, 80);
//    indicator.center = CGPointMake(self.view.width / 2, self.view.height / 2);
//    indicator.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.670];
//    indicator.clipsToBounds = YES;
//    indicator.layer.cornerRadius = 6;
//    [indicator startAnimating];
//    [self.view addSubview:indicator];
    
    [self addTableViewRefresh];


#ifdef locationData
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //[NSThread sleepForTimeInterval:10];
        for (int i = 2; i <= 2; i++) {
            NSData *data = [NSData dataNamed:[NSString stringWithFormat:@"weibo_%d.json",i]];
            WBTimelineItem *item = [WBTimelineItem modelWithJSON:data];
            for (WBStatus *status in item.statuses) {

                WBStatusLayout *layout = [[WBStatusLayout alloc] initWithStatus:status style:WBLayoutStyleTimeline];
                //                [layout layout];
                [_layouts addObject:layout];
                //break;
            }
        }
//    });

        // 复制一下，让列表长一些，不至于滑两下就到底了
        //[_layouts addObjectsFromArray:_layouts];

        dispatch_async(dispatch_get_main_queue(), ^{
            //self.title = [NSString stringWithFormat:@"Weibo (loaded:%d)", (int)_layouts.count];
            //[indicator removeFromSuperview];
            [_tableView reloadData];
        });
    });
#else
    [self getCircleList];
#endif
}

- (void)addTableViewRefresh {
//    @weakify(self)
//    [self.tableView addGifHeaderWithRefreshingBlock:^{
//        @strongify(self)
//        [self.tableView.footer resetNoMoreData];
//        self.circle_id = @"";
//        [self getCircleList];
//    }];
//
//    [[self.tableView.gifHeader subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if([obj isKindOfClass:[UIImageView class]]) {
//            obj.hidden = YES;
//        }
//    }];

    /**
     添加下拉刷新
     */
    __weak typeof(self) weakSelf = self;
    [self.view XD_refreshWithObject:_tableView atPoint:CGPointZero downRefresh:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        //[weakSelf.tableView.footer resetNoMoreData];
        weakSelf.circle_id = @"";
        [weakSelf getCircleList];
    }];

    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [weakSelf getCircleList];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    //NSLog(@"### observeValueForKeyPath change: %@",change);
    [self.view XD_observeValueForKeyPath:keyPath ofObject:object change:[change mutableCopy] context:context];
}

- (void)update:(NSNotification *)noti {
    [self.tableView reloadData];
}

////停止tableview刷新
- (void)endTableViewRefreshing
{
    if (self.tableView.header.isRefreshing) {
        [self.tableView.header endRefreshing];
    } else if (self.tableView.footer.isRefreshing) {
        [self.tableView.footer endRefreshing];
    }
}
//
- (void)getCircleList {
    NSString *pullType = [StringUtil isEmpty:self.circle_id] ? @"down" : @"up";
    if(self.type == SocialContactTypeRecommand) {
        [SCRequestHelper circleRecommandList:@{@"pull_type": pullType,@"circle_id":self.circle_id} completion:^(id data) {
            [self parseData:data];
        }];
    } else if(self.type == SocialContactTypeCare) {
        NSMutableDictionary *dictInfo = [[NSMutableDictionary alloc] init];
        [dictInfo setValue:pullType forKey:@"pull_type"];
        [dictInfo setValue:self.circle_id forKey:@"circle_id"];
        [SCRequestHelper circleCareList:dictInfo completion:^(id data) {
            [self.view XD_endRefresh];
            [self parseData:data];
        }];
    } else if(self.type == SocialContactTypePersonal) {
        [SCRequestHelper circlePersonalList:@{@"pull_type": pullType,@"circle_id":self.circle_id,@"other_id":self.otherId ?: @""} completion:^(id data) {
            [self parseData:data];
        }];
    } else if(self.type == SocialContactTypePraise) {
        [SCRequestHelper getCircleYesterdayRankList:@{@"type": @"1",@"circle_id":self.circle_id} completion:^(id data) {
            [self parseData:data];
        }];
    } else if(self.type == SocialContactTypeReward) {
        [SCRequestHelper getCircleYesterdayRankList:@{@"type": @"2",@"circle_id":self.circle_id} completion:^(id data) {
            [self parseData:data];
        }];
    }

}

- (void)parseData:(NSDictionary *)dic {
    [self endTableViewRefreshing];

    if([dic isSuccess]) {
        NSArray *statusArr = [WBStatusHelper modelsForDic:[dic valueForKey:@"data"]];
        if([StringUtil isEmpty:self.circle_id] && statusArr.count > 0) {
            [_layouts removeAllObjects];
        }

        NSInteger curTotalCount = self.layouts.count;
        @weakify(self)
        [statusArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self)
            WBStatus *status = obj;
            WBStatusLayout *layout = [[WBStatusLayout alloc] initWithStatus:status style:WBLayoutStyleTimeline];
            if(self.type == SocialContactTypePraise || self.type == SocialContactTypeReward) {
                NSInteger index = curTotalCount + idx + 1;
                layout.index = [NSString stringWithFormat:@"%@%ld",index < 10 ? @"0" : @"",(long)index];
            }

            //                [layout layout];
            [self.layouts addObject:layout];

            if(idx == statusArr.count -1) {
                self.circle_id = status.circle_id;
            }
        }];

        [_tableView reloadData];

        self.tableView.footer.hidden = NO;
        if([statusArr count] <= 0) {
            [self.tableView.footer noticeNoMoreData];
        }

        self.tableView.footer.hidden = self.layouts.count == 0;

        //[self fixFooterLayout];
    }
}

//- (void)fixFooterLayout {
//    self.tableView.footer.height = 90;
//    UILabel *noMoreLabel = [self.tableView.footer valueForKey:@"noMoreLabel"];
//    noMoreLabel.numberOfLines = 0;
//    noMoreLabel.text = [[noMoreLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByAppendingString:@"\n\n"];
//
//    UIButton *loadMoreButton = [self.tableView.footer valueForKey:@"loadMoreButton"];
//    //loadMoreButton.titleLabel.numberOfLines = 0;
//    [loadMoreButton setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
//    //label.text = [[label.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByAppendingString:@"\n\n"];
//}

///用于成功发布朋友圈后插入到第一行
- (void)inserNewData:(NSDictionary *)item {
    if(item == nil || ![item isKindOfClass:[NSDictionary class]]) {
        return;
    }

    NSArray *statusArr = [WBStatusHelper modelsForDic:@[item]];
    if(statusArr.count <= 0) {
        return;
    }

    WBStatusLayout *layout = [[WBStatusLayout alloc] initWithStatus:statusArr.firstObject style:WBLayoutStyleTimeline];
    [self.layouts insertObject:layout atIndex:0];
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        [self.tableView reloadData];
        [self.tableView scrollToTop];
    });
}

- (void)playVideoForCell:(WBStatusCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    WBStatusLayout *layout = cell.statusView.layout;//_layouts[indexPath.row];
#ifdef locationData
    if((layout.status.pageInfo.type == 2) && [layout.status.pageInfo.objectType isEqualToString:@"video"]) {
#else
    if((layout.status.pageInfo.type == 2) && [layout.status.pageInfo.objectType isEqualToString:@"video"]) {
#endif
        NSString *urlString = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,(layout.status.isTransfer ? layout.status.trans_link : layout.status.circle_link)];
        NSURL *url = [NSURL URLWithString:urlString];
        //NSURL *url = [NSURL URLWithString:[layout.status.pageInfo.mediaInfo valueForKey:@"mp4_sd_url"]];
        //NSURL *url = [NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
        if(url == nil) {
            return;
        }

        if ( !_player || !_player.isFullScreen ) {
            [_player stopAndFadeOut]; // 让旧的播放器淡出
            _player = [SJVideoPlayer player]; // 创建一个新的播放器
            _player.generatePreviewImages = NO; // 生成预览缩略图, 大概20张
            // fade in(淡入)
            _player.view.alpha = 0.001;
            [UIView animateWithDuration:0.6 animations:^{
                self.player.view.alpha = 1;
            }];
        }
#ifdef SJMAC
        _player.disablePromptWhenNetworkStatusChanges = YES;
#endif
        //cell.statusView.cardView.button.hidden = YES;

        [[VideoPlayManager share] play:urlString superView:cell.statusView.cardView];
        return;

#if 0
        [cell.statusView.cardView addSubview:self.player.view];
        _player.view.frame = cell.statusView.cardView.bounds;
#else

        UIView *basePlayerView = [[UIView alloc] initWithFrame:cell.statusView.cardView.bounds];
        basePlayerView.tag = 101;
        [cell addSubview:basePlayerView];
        [basePlayerView addSubview:_player.view];
        CGRect frame = [cell.statusView convertRect:cell.statusView.cardView.frame toView:cell];
        basePlayerView.frame = frame;
        _player.view.frame = basePlayerView.bounds;//cell.statusView.cardView.bounds;
#endif


        //    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.offset(0);
        //    }];

        //[NSBundle.mainBundle URLForResource:@"play" withExtension:@"mp4"]

        _player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:url playModel:[SJPlayModel UITableViewCellPlayModelWithPlayerSuperviewTag:101 atIndexPath:indexPath tableView:self.tableView]];
        _player.URLAsset.title = nil;
        _player.URLAsset.alwaysShowTitle = YES;
        SJVideoPlayerSettings.commonSettings.progress_traceColor = [UIColor moBlue];
        [_player play];
    } else {
//        [_player.view removeFromSuperview];
//        _player = nil;
    }
}

- (void)sj_playerNeedPlayNewAssetAtIndexPath:(NSIndexPath *)indexPath {
    WBStatusCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self playVideoForCell:cell];
}

- (void)refreshUI {
    [super setupInteractive];
}
//
- (void)setupInteractive {
    //    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    //    }
}

- (void)initBaseView {

}

- (void)sendStatus {
    WBStatusComposeViewController *vc = [WBStatusComposeViewController new];
    vc.type = WBStatusComposeViewTypeStatus;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    @weakify(nav);
    vc.dismiss = ^{
        @strongify(nav);
        [nav dismissViewControllerAnimated:YES completion:NULL];
    };
    [self presentViewController:nav animated:YES completion:NULL];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[LXChatBoxManager shared] hideKeyBoard];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {

}


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
////    CGFloat offsetY = scrollView.contentOffset.y;
////    NSLog(@"### offsetY: %f",offsetY);
////    if (offsetY < 0) {
////        CGFloat newOffsetY = offsetY/2;
////        CGFloat width = SCREEN_WIDTH+ABS(newOffsetY)*2;
////        CGFloat height = _headerOriginHeight*width/SCREEN_WIDTH;
////        self.header.frame = CGRectMake(newOffsetY, offsetY, width, height);
////    }
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _layouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cell";
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[WBStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
    }

    UIView *basePlayerView = [cell viewWithTag:101];
    if(basePlayerView) {
        [basePlayerView removeFromSuperview];
    }

    [cell setLayout:_layouts[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((WBStatusLayout *)_layouts[indexPath.row]).height;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - WBStatusCellDelegate

/// 点击了 Cell
- (void)cellDidClick:(WBStatusCell *)cell {
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//
//    @weakify(self)
//    [MXRouter openURL:@"lcwl://SocialContactDetailVC" parameters:@{@"WBStatusLayout":_layouts[indexPath.row],@"block":^(NSDictionary *data) {
//        @strongify(self)
//        [self.tableView reloadData];
//    }}];
//    WBStatusLayout *layout = _layouts[indexPath.row];
//    [MXRouter openURL:@"lcwl://SCDetailFromTransferListVC" parameters:@{@"circle_id":$str(@"%ld",[layout.status.circle_id integerValue]) ?: @""}];
}

/// 点击了 Card
- (void)cellDidClickCard:(WBStatusCell *)cell {
//    WBPageInfo *pageInfo = cell.statusView.layout.status.pageInfo;
//    NSString *url = pageInfo.pageURL; // sinaweibo://... 会跳到 Weibo.app 的。。
//    YYSimpleWebViewController *vc = [[YYSimpleWebViewController alloc] initWithURL:[NSURL URLWithString:url]];
//    vc.title = pageInfo.pageTitle;
//    [self.navigationController pushViewController:vc animated:YES];
}

/// 点击了转发内容
- (void)cellDidClickRetweet:(WBStatusCell *)cell {

}

/// 点击了 Cell 菜单
- (void)cellDidClickMenu:(WBStatusCell *)cell {
    if(self.type == SocialContactTypePraise || self.type == SocialContactTypeReward) {
        return;
    }

    @weakify(self)
    if(cell.statusView.layout.status.user.userID == [AppUserModel.chatUser_id integerValue]) {
        [UIAlertController showActionSheetInViewController:self
                                                 withTitle:nil
                                                   message:nil
                                         cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:@"删除"
                                         otherButtonTitles:nil
                        popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {

                        } tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                            if (buttonIndex == controller.cancelButtonIndex) {
                                NSLog(@"Cancel Tapped");
                            } else if (buttonIndex == controller.destructiveButtonIndex) {
                                NSLog(@"Delete Tapped");
                                [SCRequestHelper circleDelete:@{@"circle_id":cell.statusView.layout.status.circle_id} completion:^(id data) {
                                    @strongify(self)
                                    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
                                    [self.layouts safeRemoveObjectAtIndex:indexPath.row];
                                    [self.tableView reloadData];
                                }];
                            }
                        }];
    } else {
        [UIAlertController showActionSheetInViewController:self
                                                 withTitle:nil
                                                   message:nil
                                         cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:@[/*@"加好友", */@"举报", @"屏蔽"]
                        popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {

                        } tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                            if (buttonIndex == 0) {
                                NSLog(@"Cancel Tapped");
                            }/* else if (buttonIndex == 2) { //加好友
                                [SCRequestHelper addFriend:cell.statusView.layout.status.user.userID];
                            }*/ else if (buttonIndex == 2) {
                                [MXRouter openURL:@"lcwl://ReportViewController" parameters:@{@"circle_id":cell.statusView.layout.status.circle_id ?: @""}];
                                NSLog(@"Delete Tapped");
                            } else if (buttonIndex == 3) { //不感兴趣
                                NSLog(@"Other Button Index %ld", (long)buttonIndex - controller.firstOtherButtonIndex);
                                
                                if([StringUtil isEmpty:cell.statusView.layout.status.circle_id]) {
                                    return;
                                }

                                [FriendsManager complain:@{@"complain_type":@"1",@"friend_id":@"",@"resoan":@"2,3"} completion:^(BOOL success, NSString *error) {
                                    [NotifyHelper showMessageWithMakeText:@"屏蔽成功"];
                                    
                                    NSMutableArray *muArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"deleteCirleIds"];
                                    if(muArr == nil) {
                                        muArr = [NSMutableArray arrayWithCapacity:1];
                                    } else {
                                        muArr = [NSMutableArray arrayWithArray:muArr];
                                    }
                                    [muArr addObject:cell.statusView.layout.status.circle_id];
                                    [[NSUserDefaults standardUserDefaults] setObject:muArr forKey:@"deleteCirleIds"];
                                    [[NSUserDefaults standardUserDefaults] synchronize];
                                    
                                    __block WBStatusLayout *layout = nil;
                                    [_layouts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                        WBStatusLayout *lay = obj;
                                        if([lay.status.circle_id isEqualToString:cell.statusView.layout.status.circle_id]) {
                                            layout = obj;
                                            *stop = YES;
                                        }
                                    }];
                                    
                                    if(layout != nil) {
                                        [_layouts removeObject:layout];
                                        [_tableView reloadData];
                                    }
                                    
                                }];                            }
                        }];
    }
}
//
/// 点击了下方 Tag
- (void)cellDidClickTag:(WBStatusCell *)cell {
//    WBTag *tag = cell.statusView.layout.status.tagStruct.firstObject;
//    NSString *url = tag.tagScheme; // sinaweibo://... 会跳到 Weibo.app 的。。
//    YYSimpleWebViewController *vc = [[YYSimpleWebViewController alloc] initWithURL:[NSURL URLWithString:url]];
//    vc.title = tag.tagName;
//    [self.navigationController pushViewController:vc animated:YES];
}

/// 点击了关注
- (void)cellDidClickFollow:(WBStatusCell *)cell {

}

/// 点击了转发
- (void)cellDidClickRepost:(WBStatusCell *)cell {
    [self cellDidClickMenu:cell];
//    @weakify(self)
//    __weak UIViewController *weakSelf = self; //首页采用rootviewcontroller弹出,确保不被tabbar挡住，其他情况使用self弹出
//    [MXRouter openURL:@"lcwl://PublishDynamic" parameters:@{@"weakSelf":(![self.nextResponder isKindOfClass:NSClassFromString(@"YNPageScrollView")] ? weakSelf : [NSNull null]),@"type":@(1),@"model":cell.statusView.layout.status,@"block":^(NSDictionary *data) {
//        @strongify(self)
//        [WBStatusHelper appendTransfer:cell.statusView.layout];
//        [self.tableView reloadData];
//    }}];
//    WBStatusComposeViewController *vc = [WBStatusComposeViewController new];
//    vc.type = WBStatusComposeViewTypeRetweet;
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    @weakify(nav);
//    vc.dismiss = ^{
//        @strongify(nav);
//        [nav dismissViewControllerAnimated:YES completion:NULL];
//    };
//    [self presentViewController:nav animated:YES completion:NULL];
}

/// 点击了评论按钮
- (void)cellDidClickComment:(WBStatusCell *)cell {
    [[LXChatBoxManager shared] showKeyBoard:nil block:^(NSString * _Nonnull msg) {
        if(![SCConfigManager validateMsg:msg]) {
            return;
        }
        [SCRequestHelper commentCircle:@"add" content:msg circleId:cell.statusView.layout.status.circle_id commentId:nil commentUserId:nil extraInfo:@{@"circle_user_id":[@(cell.statusView.layout.status.user.userID) description]} completion:^(id data) {
            if([[data valueForKey:@"success"] boolValue]) {
                [NotifyHelper showMessageWithMakeText:@"评论成功"];
                [WBStatusHelper appendComment:cell.statusView.layout dic:[data valueForKey: @"data"]];
                [self.tableView reloadData];
            }
        }];
    }];
}

/// 点击了评论内容
- (void)cellDidClickCommentContent:(WBStatusCell *)cell {

}

/// 点击了赞
- (void)cellDidClickLike:(WBStatusCell *)cell {
    WBStatus *status = cell.statusView.layout.status;

    [NotifyHelper showHUD];
    if(status.attitudesStatus == 0) {
        [SCRequestHelper circlePraise:@{@"circle_id":status.circle_id ?: @"",@"circle_user_id":[@(status.user.userID) description]} completion:^(id data) {
            [NotifyHelper hideHUD];
            BOOL success = [[data valueForKey:@"success"] boolValue];
            if(success) {
                status.praise_id = [NSString stringWithFormat:@"%ld",[[data valueForKeyPath:@"data.id"] integerValue]];
                [WBStatusHelper appendPraise:cell.statusView.layout dic:[data valueForKey:@"data"]];
                [self.tableView reloadData];
            } else {
                [cell.statusView.toolbarView setLiked:0 withAnimation:YES];
            }
        }];
    } else {
        [SCRequestHelper circleUnPraise:@{@"circle_id":status.circle_id ?: @"",@"praise_id":status.praise_id ?: @""} completion:^(id data) {
            [NotifyHelper hideHUD];
            BOOL success = [[data valueForKey:@"success"] boolValue];
            if(success) {
                [WBStatusHelper removePraise:cell.statusView.layout praiseId:status.praise_id];
                status.praise_id = nil;
                [self.tableView reloadData];
            } else {
                [cell.statusView.toolbarView setLiked:1 withAnimation:YES];
            }
        }];
    }

    [cell.statusView.toolbarView setLiked:!status.attitudesStatus withAnimation:YES];

}

/// 点击视频播放按钮
- (void)cellDidClickVideoPlay:(WBStatusCell *)cell {
    [self playVideoForCell:cell];
}

- (void)cellDidClickAward:(WBStatusCell *)cell {
    @weakify(self)
    [MXRouter openURL:@"lcwl://RewardVC" parameters:@{@"circle_id":cell.statusView.layout.status.circle_id,@"circle_user_id":[@(cell.statusView.layout.status.user.userID) description],@"block":^(NSDictionary *data) {
        @strongify(self)
        [WBStatusHelper appendAward:cell.statusView.layout];
        [self.tableView reloadData];
    }}];
}

/// 点击了用户
- (void)cell:(WBStatusCell *)cell didClickUser:(WBUser *)user {
    if (user.userID == 0) return;
//    NSString *url = [NSString stringWithFormat:@"http://m.weibo.cn/u/%lld",user.userID];
//    YYSimpleWebViewController *vc = [[YYSimpleWebViewController alloc] initWithURL:[NSURL URLWithString:url]];
//    [self.navigationController pushViewController:vc animated:YES];

    [MXRouter openURL:@"lcwl://PersonalDetailVC" parameters:@{@"other_id":[NSString stringWithFormat:@"%@",@(user.userID)]}];
}

/// 点击了图片
- (void)cell:(WBStatusCell *)cell didClickImageAtIndex:(NSUInteger)index {
    UIView *fromView = nil;
    NSMutableArray *items = [NSMutableArray new];
    WBStatus *status = cell.statusView.layout.status;
    NSArray<WBPicture *> *pics = status.retweetedStatus ? status.retweetedStatus.pics : status.pics;

    for (NSUInteger i = 0, max = pics.count; i < max; i++) {
        UIView *imgView = cell.statusView.picViews[i];
        WBPicture *pic = pics[i];
        WBPictureMetadata *meta = pic.largest.badgeType == WBPictureBadgeTypeGIF ? pic.largest : pic.large;
        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
        item.thumbView = imgView;
        item.largeImageURL = meta.url;
        item.largeImageSize = CGSizeMake(meta.width, meta.height);
        [items addObject:item];
        if (i == index) {
            fromView = imgView;
        }
    }

    YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:items];
    v.blurEffectBackground = NO;
    //[v presentFromImageView:fromView toContainer:MoApp.window animated:YES completion:nil];
    v.dismissBlock = ^(id data){
        [self.browsePhotoNav.view removeFromSuperview];
        if(self.superMainVC) {
            [[MXRouter sharedInstance] configureCurrentVC:self.superMainVC];
        } else if(self.navigationController != nil) {
            [[MXRouter sharedInstance] configureCurrentVC:self];
        }

        if(data != nil && [data isKindOfClass:[NSString class]]) {
            [[[MXBarReaderHelper alloc] init] dealWithReadingData:data];
        }

        [self.browsePhotoRootVC.view removeAllSubviews];
    };

    if(self.browsePhotoRootVC == nil) {
        self.browsePhotoRootVC = [[UIViewController alloc] init];
    }
    self.browsePhotoNav = [[UINavigationController alloc] initWithRootViewController:self.browsePhotoRootVC];

    [self.browsePhotoRootVC.navigationController setNavigationBarHidden:YES animated:NO];
    self.browsePhotoRootVC.view.backgroundColor = [UIColor clearColor];
    self.browsePhotoNav.view.backgroundColor = [UIColor clearColor];
    [[MXRouter sharedInstance] configureCurrentVC:self.browsePhotoRootVC];

    v.presentVC = self.browsePhotoRootVC;
    //[self presentViewController:self.browsePhotoNav animated:YES completion:nil];
    if([self.nextResponder isKindOfClass:NSClassFromString(@"YNPageScrollView")]) {
        [MoApp.window.rootViewController.view addSubview:self.browsePhotoNav.view];
    } else {
        [self.view addSubview:self.browsePhotoNav.view];
    }
    [v presentFromImageView:fromView toContainer:self.browsePhotoRootVC.view animated:YES completion:nil];
}

/// 点击了 Label 的链接
- (void)cell:(WBStatusCell *)cell didClickInLabel:(YYLabel *)label textRange:(NSRange)textRange {
    NSAttributedString *text = label.textLayout.text;
    if (textRange.location >= text.length) return;
    YYTextHighlight *highlight = [text attribute:YYTextHighlightAttributeName atIndex:textRange.location];
    NSDictionary *info = highlight.userInfo;
    if (info.count == 0) return;

    if([[info valueForKey:@"type"] isEqualToString:@"personal"]) {
        NSString *userId = [NSString stringWithFormat:@"%@",[info valueForKeyPath:@"user_id"]];
        if(userId) {
            [MXRouter openURL:@"lcwl://PersonalDetailVC" parameters:@{@"other_id":userId}];
        }
    } else if([[info valueForKey:@"type"] isEqualToString:@"commentContent"]) {
        NSString *userId = [NSString stringWithFormat:@"%@",[info valueForKeyPath:@"commentItem.user_id"]];
        NSString *userName = [NSString stringWithFormat:@"%@",[info valueForKeyPath:@"commentItem.user_name"]];
        NSString *_id = [NSString stringWithFormat:@"%@",[info valueForKeyPath:@"commentItem._id"]];
        NSString *circleId = [NSString stringWithFormat:@"%@",[info valueForKeyPath:@"commentItem.circle_id"]];

        if(_id.length > 0 &&  [userId isEqualToString:AppUserModel.user_id]) {
            [UIAlertController showActionSheetInViewController:self
                                                     withTitle:nil
                                                       message:nil
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:@"删除"
                                             otherButtonTitles:nil
                            popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {

                            } tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                if (buttonIndex == controller.cancelButtonIndex) {
                                    NSLog(@"Cancel Tapped");
                                } else if (buttonIndex == controller.destructiveButtonIndex) {
                                    NSLog(@"Delete Tapped");
                                    [SCRequestHelper commentCircle:@"del" content:nil circleId:circleId commentId:_id commentUserId:nil extraInfo:@{@"circle_user_id":[@(cell.statusView.layout.status.user.userID) description]}  completion:^(id data) {
                                        if([[data valueForKey:@"success"] boolValue]) {
                                            [WBStatusHelper removeComment:cell.statusView.layout dic:@{@"id":_id ?: @""}];
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                [NotifyHelper showMessageWithMakeText:@"删除成功"];
                                                [self.tableView reloadData];
                                            });
                                        }
                                    }];
                                }
                            }];
        } else {
            [[LXChatBoxManager shared] showKeyBoard:$str(@"回复 %@",userName ?: @"") block:^(NSString * _Nonnull msg) {
                if(![SCConfigManager validateMsg:msg]) {
                    return;
                }
                [SCRequestHelper commentCircle:@"add" content:msg circleId:circleId commentId:_id commentUserId:userId extraInfo:@{@"circle_user_id":[@(cell.statusView.layout.status.user.userID) description]} completion:^(id data) {
                    if([[data valueForKey:@"success"] boolValue]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [NotifyHelper showMessageWithMakeText:@"回复成功"];
                            [WBStatusHelper appendComment:cell.statusView.layout dic:[data valueForKey: @"data"]];
                            [self.tableView reloadData];
                        });
                    }
                }];
            }];
        }
    } else if([[info valueForKey:@"type"] isEqualToString:@"forward"]) {

    }

//    if (info[kWBLinkHrefName]) {
//        NSString *url = info[kWBLinkHrefName];
//        YYSimpleWebViewController *vc = [[YYSimpleWebViewController alloc] initWithURL:[NSURL URLWithString:url]];
//        [self.navigationController pushViewController:vc animated:YES];
//        return;
//    }
//
//    if (info[kWBLinkURLName]) {
//        WBURL *url = info[kWBLinkURLName];
//        WBPicture *pic = url.pics.firstObject;
//        if (pic) {
//            // 点击了文本中的 "图片链接"
//            YYTextAttachment *attachment = [label.textLayout.text attribute:YYTextAttachmentAttributeName atIndex:textRange.location];
//            if ([attachment.content isKindOfClass:[UIView class]]) {
//                YYPhotoGroupItem *info = [YYPhotoGroupItem new];
//                info.largeImageURL = pic.large.url;
//                info.largeImageSize = CGSizeMake(pic.large.width, pic.large.height);
//
//                YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:@[info]];
//                [v presentFromImageView:attachment.content toContainer:self.navigationController.view animated:YES completion:nil];
//            }
//
//        } else if (url.oriURL.length){
//            YYSimpleWebViewController *vc = [[YYSimpleWebViewController alloc] initWithURL:[NSURL URLWithString:url.oriURL]];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        return;
//    }
//
//    if (info[kWBLinkTagName]) {
//        WBTag *tag = info[kWBLinkTagName];
//        NSLog(@"tag:%@",tag.tagScheme);
//        return;
//    }
//
//    if (info[kWBLinkTopicName]) {
//        WBTopic *topic = info[kWBLinkTopicName];
//        NSString *topicStr = topic.topicTitle;
//        topicStr = [topicStr stringByURLEncode];
//        if (topicStr.length) {
//            NSString *url = [NSString stringWithFormat:@"http://m.weibo.cn/k/%@",topicStr];
//            YYSimpleWebViewController *vc = [[YYSimpleWebViewController alloc] initWithURL:[NSURL URLWithString:url]];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        return;
//    }
//
//    if (info[kWBLinkAtName]) {
//        NSString *name = info[kWBLinkAtName];
//        name = [name stringByURLEncode];
//        if (name.length) {
//            NSString *url = [NSString stringWithFormat:@"http://m.weibo.cn/n/%@",name];
//            YYSimpleWebViewController *vc = [[YYSimpleWebViewController alloc] initWithURL:[NSURL URLWithString:url]];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        return;
//    }
}

- (void)cell:(WBStatusCell *)cell didLongPressInLabel:(YYLabel *)label textRange:(NSRange)textRange {
    // 获得菜单
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if(menu.menuVisible) {
        return;
    }

    self.globalPasteString = label.textLayout.text.string;
    // 让label成为第一响应者
    [cell becomeFirstResponder];

    // 设置菜单内容，显示中文，所以要手动设置app支持中文
    menu.menuItems = @[
                       [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(getContent:)]
                       ];
    //CGRect rect = CGRectInset(label.bounds, label.bounds.size.width/2, label.bounds.size.height/2);
    // 菜单最终显示的位置
    [menu setTargetRect:label.bounds inView:cell.contentView];

    // 显示菜单
    [menu setMenuVisible:YES animated:YES];
}

- (void)getContent:(UIMenuController *)menu
{
    // 将label的文字存储到粘贴板
    [UIPasteboard generalPasteboard].string = self.globalPasteString;
}

- (NSString *)tabTitle {
    return @"圈圈";
}

-(NSString*)iconImageNormal{
    return @"tab_icon_find_nor";
}

-(NSString*)iconImageSelected{
    return @"tab_icon_find_hl";
}
@end
