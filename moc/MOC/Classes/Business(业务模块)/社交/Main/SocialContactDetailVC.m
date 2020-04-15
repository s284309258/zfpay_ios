//
//  SocialContactDetailVC.m
//  Lcwl
//
//  Created by mac on 2018/12/5.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "SocialContactDetailVC.h"
#import "UIView+SingleLineView.h"
#import "WBStatusCell.h"
#import "UIView+Utils.h"
#import "YNPageViewController.h"
#import "SCUserContentVC.h"
#import "YYSimpleWebViewController.h"
#import "WBStatusComposeTextParser.h"
#import "WBStatusComposeViewController.h"
#import "UIAlertController+Blocks.h"
#import "YYPhotoGroupView.h"
#import "YYKit.h"
#import "SJVideoPlayer.h"
#import "SCRequestHelper.h"
#import "LXChatBoxManager.h"
#import "UINavigationBar+Alpha.h"
#import "UIImage+Utils.h"
#import "QNManager.h"
#import "SCConfigManager.h"
#import "UIViewController+NavItem.h"
#import "UIScrollView+ListViewAutoplaySJAdd.h"

@interface SocialContactDetailVC ()<YNPageViewControllerDelegate, YNPageViewControllerDataSource,WBStatusCellDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *header;
@property (strong, nonatomic) WBStatusCell *cell;
@property (strong, nonatomic) UIView *sectionBar;
@property (strong, nonatomic) WBStatusToolbarView *toolbar;
@property (strong, nonatomic) UIView *toolbarBG;
@property (nonatomic, strong) SJVideoPlayer *player;
@property (nonatomic, strong) SCUserContentVC *commentListVC;
@property (nonatomic, strong) SCUserContentVC *transferListVC;
@property (nonatomic, strong) SCUserContentVC *praiseListVC;

@property (nonatomic, strong) UIButton *retweetBnt;
@property (nonatomic, strong) UIButton *commentBnt;
@property (nonatomic, strong) UIButton *likeBnt;

@property (nonatomic, strong) NSString *globalPasteString;
@end

@implementation SocialContactDetailVC

- (void)viewDidLoad {
    [self configUI];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self configUI];
    [self.scrollMenuView addSubview:self.sectionBar];
    [self.sectionBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollMenuView);
    }];
    
    [self.sectionBar layoutIfNeeded];
    
    [self setSelectedPageIndex:1];
    [self adjustIndicatorPostion:1 animation:NO];
    
    [self.view addSubview:self.toolbarBG];
    [self.toolbarBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@(60+safeAreaInsetBottom()));
        //make.bottom.equalTo(@(-safeAreaInsetBottom()));
    }];
    
    self.toolbar.cell = self.cell;
#if 0
    _player = [SJVideoPlayer player];
    _cell.statusView.cardView.button.hidden = YES;
    [_cell.statusView.cardView addSubview:self.player.view];
    _player.view.frame = _cell.statusView.cardView.bounds;
    
    //[NSBundle.mainBundle URLForResource:@"play" withExtension:@"mp4"]
    _player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"]];
    _player.URLAsset.title = nil;
    _player.URLAsset.alwaysShowTitle = YES;
#endif
}

- (void)dealloc {
    //刷新外部列表
    [self.player stop];
    Block_Exec(self.backBlock,nil);
}

+ (instancetype)instanceVC {
    
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleSuspensionTop;
    configration.headerViewCouldScale = YES;
    configration.showTabbar = NO;
    configration.showNavigation = YES;
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = NO;
    configration.showBottomLine = YES;
    configration.bottomLineBgColor = [UIColor whiteColor];
    configration.lineColor = [UIColor whiteColor];
    configration.converColor = [UIColor whiteColor];
    configration.selectedItemColor = [UIColor whiteColor];
    configration.normalItemColor = [UIColor whiteColor];
    
    SCUserContentVC *transferListVC = [[SCUserContentVC alloc] init];
    transferListVC.title = @"转发";
    
    SCUserContentVC *commentListVC = [[SCUserContentVC alloc] init];
    commentListVC.title = @"评论";
    
    SCUserContentVC *praiseListVC = [[SCUserContentVC alloc] init];
    praiseListVC.title = @"赞";
    
    
    SocialContactDetailVC *vc = [SocialContactDetailVC pageViewControllerWithControllers:@[transferListVC, commentListVC, praiseListVC]
                                                              titles:[self getArrayTitles]
                                                              config:configration];
    vc.dataSource = vc;
    vc.delegate = vc;
    vc.transferListVC = transferListVC;
    vc.commentListVC = commentListVC;
    vc.praiseListVC = praiseListVC;
    
    return vc;
}


+ (NSArray *)getArrayTitles {
    return @[@"转发", @"评论", @"赞"];
}

- (void)setLayout:(WBStatusLayout *)layout {
    _layout = layout;
    _transferListVC.circle_id = layout.status.circle_id;
    _commentListVC.circle_id = layout.status.circle_id;
    _praiseListVC.circle_id = layout.status.circle_id;
    
    _transferListVC.layout = layout;
    _commentListVC.layout = layout;
    _praiseListVC.layout = layout;
    
    //更新toolbar
    BOOL liked = layout.status.attitudesStatus == 0 ? NO : YES;
    self.toolbar.likeButton.selected = liked;
    [self.toolbar setLiked:liked withAnimation:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.player vc_viewDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player vc_viewWillDisappear];
    [[LXChatBoxManager shared] hideKeyBoard];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player vc_viewDidDisappear];
}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    SCUserContentVC *baseVC = (SCUserContentVC *)pageViewController.controllersM[index];
    return baseVC.tableView;
}

- (void)pageViewController:(YNPageViewController *)pageViewController
        didEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"#1 contentOffsetY:%f",scrollView.contentOffset.x);
    //[self adjustIndicatorPostion:self.pageIndex animation:YES];
    
    CGFloat offset = scrollView.contentOffset.x;
    if(offset >= SCREEN_WIDTH*2) {
        [self adjustIndicatorPostion:2 animation:YES];
    } else if(offset >= SCREEN_WIDTH) {
        [self adjustIndicatorPostion:1 animation:YES];
    } else if(offset == 0) {
        [self adjustIndicatorPostion:0 animation:YES];
    }
}

- (void)pageViewController:(YNPageViewController *)pageViewController
                 didScroll:(UIScrollView *)scrollView
                  progress:(CGFloat)progress
                 formIndex:(NSInteger)fromIndex
                   toIndex:(NSInteger)toIndex {
//    NSLog(@"#2 contentOffsetY:%f  progress:%f",scrollView.contentOffset.x,progress);
    
}

- (void)configUI {
    self.title = @"详情";
    
    self.cell = [[WBStatusCell alloc] init];
    self.cell.delegate = self;
    [self.cell setLayout:self.layout];
    [self.header addSubview:self.cell];
    [self.cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([self.cell superview]);
    }];
    
    self.cell.statusView.contentView.top = 0;
    self.header.height = self.cell.statusView.toolbarView.top+10;
    self.cell.statusView.toolbarView.hidden = YES;
    self.cell.statusView.commentView.hidden = YES;
    self.headerView = self.header;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = nil;
    
    //[self.navigationController.navigationBar barReset];
    //[self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setNavBarCurrentColor:[UIColor whiteColor] titleTextColor:[UIColor blackColor]];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{
//                                                                      NSForegroundColorAttributeName : [UIColor blackColor],
//                                                                      NSFontAttributeName : [UIFont font19]
//                                                                      }];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBg"] forBarMetrics:UIBarMetricsDefault];
    //[self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    @weakify(self)
    [self setDefaultBackBnt:^(UIButton *btn) {
        @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[MXRouter sharedInstance] configureCurrentVC:self];
}

- (void)sectionBarClick:(UIButton *)sender {
    [self resetSectionBar];
    sender.selected = YES;
    [self.scrollMenuView selectedItemIndex:sender.tag-1000 animated:YES];
    [self adjustIndicatorPostion:sender.tag-1000 animation:YES];
    [self setSelectedPageIndex:sender.tag-1000];
}

- (void)resetSectionBar {
    for(UIButton *bnt in [self.sectionBar subviews]) {
        if([bnt isKindOfClass:[UIButton class]]) {
            bnt.selected = NO;
        }
    }
}

- (void)adjustIndicatorPostion:(NSInteger)pageIndex animation:(BOOL)animation {
    UIImageView *indicator = [self.sectionBar viewWithTag:9999];
    UIButton *bnt = [self.sectionBar viewWithTag:(1000+pageIndex)];
    indicator.bottom = self.sectionBar.bottom;
    [self resetSectionBar];
    bnt.selected = YES;
    
    [UIView animateWithDuration:(animation ? 0.25 : 0) animations:^{
        indicator.centerX = bnt.centerX;
    } completion:^(BOOL finished) {

    }];
}

- (void)reloadMenuView:(NSInteger)pageIndex {
    [super reloadMenuView:pageIndex];
    
    [self.scrollMenuView addSubview:self.sectionBar];
    [self.sectionBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollMenuView);
    }];
}

/// 点击了转发
- (void)clickRepost:(UIButton *)sender {

}

/// 点击了评论按钮
- (void)clickComment:(UIButton *)sender {

}

/// 点击了赞
- (void)clickLike:(UIButton *)sender {
    if(!sender.selected) {
        UIImage *image = [UIImage imageNamed:@"timeline_icon_like"];
        self.toolbar.likeImageView.image = image;
        [self.toolbar.likeImageView like];
    } else {
        UIImage *image = [UIImage imageNamed:@"timeline_icon_unlike"];
        self.toolbar.likeImageView.image = image;
        [self.toolbar.likeImageView shake];
    }
    sender.selected = !sender.selected;
}

- (void)updateTotalCount:(UIButton *)bnt value:(int)value {
    NSString *title = [[bnt.titleLabel.text componentsSeparatedByString:@" "] firstObject];
    int count = [[[bnt.titleLabel.text componentsSeparatedByString:@" "] lastObject] intValue]+value;
    [bnt setTitle:[NSString stringWithFormat:@"%@ %@",title,@(count)] forState:UIControlStateNormal];
}

//更新外部的数据
- (void)updateExternalData:(NSInteger)type data:(NSDictionary *)data {
    if(type == 0) { //转发
        self.layout.status.attitudesCount = [[[[self.retweetBnt titleForState:UIControlStateNormal] componentsSeparatedByString:@" "] lastObject] intValue];
        self.layout.status.attitudesStatus = 1;
        WBCommentItem *item = [WBStatusHelper commentItem:[data valueForKey:@"data"]];
        if([item._id integerValue] > 0) {
            [self.layout.status.praise_info_list safeAddObj:item];
        }
    } else if(type == 1) { //评论
        
    } else if(type == 2) { //赞
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SocialContactListUpdate" object:@(NO)];
}

- (UIButton *)sectionBnt:(NSString *)title {
    UIButton *retweet = [[UIButton alloc] init];
    [retweet setTitle:title forState:UIControlStateNormal];
    retweet.titleLabel.font = [UIFont systemFontOfSize:15];
    [retweet setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [retweet setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [retweet addTarget:self action:@selector(sectionBarClick:) forControlEvents:UIControlEventTouchUpInside];
    return retweet;
}

- (UIView *)header {
    if(!_header) {
        _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        _header.clipsToBounds = YES;
    }
    return _header;
}

- (UIView *)sectionBar {
    if(!_sectionBar) {
        _sectionBar = [[UIView alloc] init];
        _sectionBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        _sectionBar.backgroundColor = [UIColor whiteColor];
        
        _retweetBnt = [self sectionBnt:[NSString stringWithFormat:@"转发 %d",self.layout.status.repostsCount]];
        _retweetBnt.tag = 1000;
        _commentBnt = [self sectionBnt:[NSString stringWithFormat:@"评论 %d",self.layout.status.commentsCount]];
        _commentBnt.tag = 1001;
        _commentBnt.selected = YES;
        _likeBnt = [self sectionBnt:[NSString stringWithFormat:@"赞 %d",self.layout.status.attitudesCount]];
        _likeBnt.tag = 1002;
        
        UIImageView *indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newslist_blue"]];
        indicator.tag = 9999;
        indicator.frame = CGRectMake(0, 0, 10, 3);
        
        [_sectionBar addSubview:_retweetBnt];
        [_sectionBar addSubview:_commentBnt];
        [_sectionBar addSubview:_likeBnt];
        [_sectionBar addSubview:indicator];
        
        [_retweetBnt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo([_retweetBnt superview]).offset(15);
            make.top.bottom.equalTo([_retweetBnt superview]);
        }];
        
        [_commentBnt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo([_commentBnt superview]);
            make.left.equalTo(_retweetBnt.mas_right).offset(20);
        }];
        
        [_likeBnt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo([_likeBnt superview]);
            make.right.equalTo(@(-20));
        }];
        
        [_sectionBar addTopSingleLine:[UIColor moLineLight]];
    }
    return _sectionBar;
}

- (UIView *)toolbarBG {
    if(!_toolbarBG) {
        _toolbarBG = [[UIView alloc] init];
        _toolbarBG.backgroundColor = [UIColor whiteColor];
        [_toolbarBG addSubview:self.toolbar];
    }
    return _toolbarBG;
}

- (WBStatusToolbarView *)toolbar {
    if(!_toolbar) {
        _toolbar = [[WBStatusToolbarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60) type:ToolbarTypeDetail];
        _toolbar.backgroundColor = UIColorHex(F9FAF9);
        [_toolbar setWithLayout:nil];
        UIImage *image = self.layout.status.attitudesStatus == 1 ? [WBStatusHelper imageNamed:@"timeline_icon_like"] : [WBStatusHelper imageNamed:@"timeline_icon_unlike"];
        _toolbar.likeImageView.image = image;
        
        @weakify(self)
        [_toolbar.likeButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self)
            [self clickLike:sender];
        }];
        
        [_toolbar.commentButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self)
            [self clickComment:sender];
        }];
        
        [_toolbar.repostButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self)
            [self clickRepost:sender];
        }];
    }
    return _toolbar;
}

#pragma mark - WBStatusCellDelegate
// 此处应该用 Router 之类的东西。。。这里只是个Demo，直接全跳网页吧～

/// 点击了 Cell
- (void)cellDidClick:(WBStatusCell *)cell {

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
    if(cell.statusView.layout.status.user.userID == [AppUserModel.user_id integerValue]) {
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
                                    if([[data valueForKey:@"success"] boolValue]) {
                                        self.layout.status.commentsCount -= 1;
                                        [self updateTotalCount:self.commentBnt value:-1];
                                    }
                                }];
                            }
                        }];
    } else {
        [UIAlertController showActionSheetInViewController:self
                                                 withTitle:nil
                                                   message:nil
                                         cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:@[@"加好友", @"不感兴趣", @"投诉"]
                        popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {
                            
                        } tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                            if (buttonIndex == 0) {
                                NSLog(@"Cancel Tapped");
                            } else if (buttonIndex == 2) { //加好友
                                [SCRequestHelper addFriend:cell.statusView.layout.status.user.userID];
                            } else if (buttonIndex == 4) {
                                [MXRouter openURL:@"lcwl://ReportViewController" parameters:@{@"circle_id":cell.statusView.layout.status.circle_id ?: @""}];
                                NSLog(@"Delete Tapped");
                            } else if (buttonIndex == 3) { //不感兴趣
                                NSLog(@"Other Button Index %ld", (long)buttonIndex - controller.firstOtherButtonIndex);
                                
                                [SCRequestHelper circleCare:cell.statusView.layout.status.circle_id completion:^(id data) {
                                    if([[data valueForKey:@"success"] boolValue]) {
                                        [NotifyHelper showMessageWithMakeText:@"将减少此类推荐"];
                                    }
                                }];
                            }
                        }];
    }
}

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
    @weakify(self)
    [MXRouter openURL:@"lcwl://PublishDynamic" parameters:@{@"type":@(1),@"model":cell.statusView.layout.status,@"block":^(NSDictionary *data) {
        @strongify(self)
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
        [param setValue:[data valueForKeyPath:@"data.circle_cre_date"] forKey:@"cre_date"];
        [param setValue:[data valueForKeyPath:@"data.circle_content"] forKey:@"content"];
        [param setValue:[data valueForKeyPath:@"data.circle_id"] forKey:@"_id"];
        [self.transferListVC insetData:param];
        self.layout.status.repostsCount += 1;
        [WBStatusHelper appendTransfer:self.layout];
        [self updateTotalCount:self.retweetBnt value:1];
    }}];
}

/// 点击了评论按钮
- (void)cellDidClickComment:(WBStatusCell *)cell {
    @weakify(self)
    [[LXChatBoxManager shared] showKeyBoard:nil block:^(NSString * _Nonnull msg) {
        if(![SCConfigManager validateMsg:msg]) {
            return;
        }
        [SCRequestHelper commentCircle:@"add" content:msg circleId:cell.statusView.layout.status.circle_id commentId:nil commentUserId:nil extraInfo:@{@"circle_user_id":[@(cell.statusView.layout.status.user.userID) description]} completion:^(id data) {
            @strongify(self)
            if([[data valueForKey:@"success"] boolValue]) {
                [NotifyHelper showMessageWithMakeText:@"评论成功"];
                [self.commentListVC insetData:[data valueForKey:@"data"]];
                //更新外部的数据
                self.layout.status.commentsCount += 1;
                [self updateTotalCount:self.commentBnt value:1];
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
    @weakify(self)
    WBStatus *status = cell.statusView.layout.status;
    if(status.attitudesStatus == 0) {
        [SCRequestHelper circlePraise:@{@"circle_id":status.circle_id ?: @"",@"circle_user_id":[@(cell.statusView.layout.status.user.userID) description]} completion:^(id data) {
            @strongify(self)
            BOOL success = [[data valueForKey:@"success"] boolValue];
            if(success) {
                status.praise_id = [NSString stringWithFormat:@"%ld",[[data valueForKeyPath:@"data.id"] integerValue]];
                [self.praiseListVC insetData:[data valueForKey:@"data"]];
                [WBStatusHelper appendPraise:self.layout dic:[data valueForKey:@"data"]];
                [self updateTotalCount:self.likeBnt value:1];
                [cell.statusView.toolbarView setLiked:YES withAnimation:YES];
            }
        }];
    } else {
        [SCRequestHelper circleUnPraise:@{@"circle_id":status.circle_id ?: @"",@"praise_id":status.praise_id ?: @""} completion:^(id data) {
            @strongify(self)
            BOOL success = [[data valueForKey:@"success"] boolValue];
            if(success) {
                [self.praiseListVC removeData:status.praise_id];
                [WBStatusHelper removePraise:self.layout praiseId:status.praise_id];
                [self updateTotalCount:self.likeBnt value:-1];
                //status.praise_id = nil;
                [cell.statusView.toolbarView setLiked:NO withAnimation:YES];
            }
        }];
    }
}

- (void)cellDidClickAward:(WBStatusCell *)cell {
    @weakify(self)
    [MXRouter openURL:@"lcwl://RewardVC" parameters:@{@"circle_id":cell.statusView.layout.status.circle_id,@"circle_user_id":[@(cell.statusView.layout.status.user.userID) description],@"block":^(NSDictionary *data) {
        @strongify(self)
        [WBStatusHelper appendAward:cell.statusView.layout];
        //[self.tableView reloadData];
    }}];
}

/// 点击了用户
- (void)cell:(WBStatusCell *)cell didClickUser:(WBUser *)user {
    if (user.userID == 0) return;

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
    [v presentFromImageView:fromView toContainer:self.navigationController.view animated:YES completion:nil];
}

- (void)cellDidClickVideoPlay:(WBStatusCell *)cell {
    [self playVideoForCell:cell];
}

- (void)playVideoForCell:(WBStatusCell *)cell {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    WBStatusLayout *layout = cell.statusView.layout;//_layouts[indexPath.row];
#ifdef locationData
    if((layout.status.pageInfo.type == 2) && [layout.status.pageInfo.objectType isEqualToString:@"video"]) {
#else
        if((layout.status.pageInfo.type == 2) && [layout.status.pageInfo.objectType isEqualToString:@"video"]) {
#endif
            NSString *urlString = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,(layout.status.isTransfer ? layout.status.trans_link : layout.status.circle_link)];
            NSURL *url = [NSURL URLWithString:urlString];
            
            //NSURL *url = [NSURL URLWithString:(layout.status.isTransfer ? layout.status.trans_link : layout.status.circle_link)];
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
            cell.statusView.cardView.button.hidden = YES;
            //[cell.statusView.cardView addSubview:self.player.view];
            [self.cell addSubview:self.player.view];
            CGRect frame = [self.cell.statusView.cardView convertRect:self.cell.statusView.cardView.bounds toView:self.cell.contentView];
            _player.view.frame = frame;//self.cell.statusView.cardView.frame;
            //    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
            //        make.edges.offset(0);
            //    }];
            
            //[NSBundle.mainBundle URLForResource:@"play" withExtension:@"mp4"]
            
            _player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:url];
            _player.URLAsset.title = nil;
            _player.URLAsset.alwaysShowTitle = YES;
        } else {
            [_player.view removeFromSuperview];
            _player = nil;
        }
    }

/// 点击了 Label 的链接
- (void)cell:(WBStatusCell *)cell didClickInLabel:(YYLabel *)label textRange:(NSRange)textRange {
    NSAttributedString *text = label.textLayout.text;
    if (textRange.location >= text.length) return;
    YYTextHighlight *highlight = [text attribute:YYTextHighlightAttributeName atIndex:textRange.location];
    NSDictionary *info = highlight.userInfo;
    if (info.count == 0) return;
    
    if (info[kWBLinkHrefName]) {
        NSString *url = info[kWBLinkHrefName];
        YYSimpleWebViewController *vc = [[YYSimpleWebViewController alloc] initWithURL:[NSURL URLWithString:url]];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (info[kWBLinkURLName]) {
        WBURL *url = info[kWBLinkURLName];
        WBPicture *pic = url.pics.firstObject;
        if (pic) {
            // 点击了文本中的 "图片链接"
            YYTextAttachment *attachment = [label.textLayout.text attribute:YYTextAttachmentAttributeName atIndex:textRange.location];
            if ([attachment.content isKindOfClass:[UIView class]]) {
                YYPhotoGroupItem *info = [YYPhotoGroupItem new];
                info.largeImageURL = pic.large.url;
                info.largeImageSize = CGSizeMake(pic.large.width, pic.large.height);
                
                YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:@[info]];
                [v presentFromImageView:attachment.content toContainer:self.navigationController.view animated:YES completion:nil];
            }
            
        } else if (url.oriURL.length){
            YYSimpleWebViewController *vc = [[YYSimpleWebViewController alloc] initWithURL:[NSURL URLWithString:url.oriURL]];
            [self.navigationController pushViewController:vc animated:YES];
        }
        return;
    }
    
    if (info[kWBLinkTagName]) {
        WBTag *tag = info[kWBLinkTagName];
        NSLog(@"tag:%@",tag.tagScheme);
        return;
    }
    
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
@end
