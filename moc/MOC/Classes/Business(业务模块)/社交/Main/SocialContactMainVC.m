//
//  SocialContactMainVC.m
//  Lcwl
//
//  Created by mac on 2018/12/6.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "SocialContactMainVC.h"
#import "UIView+Utils.h"
#import "UIView+SingleLineView.h"
#import "SocialContactVC.h"
#import "UIView+Frame.h"
#import "UINavigationBar+Alpha.h"
#import "UIImage+Utils.h"
#import "UIViewController+Extension.h"
#import "BaseMenuViewController.h"
#import "PhotoBrowser.h"
#import "MXRouter.h"
#import "UIImage+Color.h"
//#import "ChatForwadVC.h"
//#import "MXConversation.h"
//#import "TalkManager.h"
//#import "RoomManager.h"
//#import "ChatSendHelper.h"
#import "UIAlertController+Blocks.h"
#import "FBKVOController.h"
//#import "LcwlChat.h"
#import "PersonalDetailModel.h"
#import "UIButton+WebCache.h"
#import "QNManager.h"
//#import "NSObject+Mine.h"
#import <Photos/Photos.h>
#import "NSObject+Mine.h"

@interface SocialContactMainVC ()<YNPageViewControllerDelegate, YNPageViewControllerDataSource, MenuViewControllerDelegate,SocialContactVCDelegate>
@property (strong, nonatomic) UIView *header;
@property (strong, nonatomic) UIImageView *headerBG;
@property (strong, nonatomic) UIButton *headPhoto;
@property (strong, nonatomic) UILabel *nameLbl;
@property (strong, nonatomic) UIView *sectionBar;
/// 导航栏标题
@property (strong, nonatomic) UILabel *navTitleLabel;
@property (nonatomic,strong) UIButton *navBarRightButton; //导航栏右侧按钮
@property (nonatomic, strong) UIBarButtonItem *rightBarItem;
@property (nonatomic, assign) CGFloat headerOriginHeight;
@property (nonatomic, strong) UIButton *retweetBnt;
@property (nonatomic, strong) UIButton *commentBnt;
@property (nonatomic, strong) UIButton *publishBnt;
@property (nonatomic, strong) UIImageView *indicator;

@property (nonatomic, strong) UIColor *currentBarColor;
@property (nonatomic, strong) UIColor *currentTitelTextColor;
@property (nonatomic, strong) UIImage *currentImage;
@property (nonatomic, assign) UIStatusBarStyle barStyle;

@property (nonatomic, strong) FBKVOController *kvoController;

@property (nonatomic, assign) CGFloat curProgress;
@end

@implementation SocialContactMainVC

- (FBKVOController *)kvoController {
    if (!_kvoController) {
        _kvoController = [FBKVOController controllerWithObserver:self];
    }
    
    return _kvoController;
}

- (void)viewDidLoad {
    [self configUI];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.currentImage = [UIImage createImageWithColor:[UIColor clearColor]];
    //[self updateMenu];
    
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
//    [self setSelectedPageIndex:1];
    [self adjustIndicatorPostion:0 animation:NO];
    //[self setSelectedPageIndex:self.pageIndex];
    self.barStyle = UIStatusBarStyleLightContent;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNewCircle:) name:@"PublishCircleSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadHeader) name:@"SocialContactReloadHeader" object:nil];
    
    [self.controllersM enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SocialContactVC *vc = (SocialContactVC *)obj;
        vc.superMainVC = self;
    }];
    
    [self reloadHeader];
    //self.view.backgroundColor = [UIColor colorWithHexString:@"#434443"];
}

- (void)updateNewCircle:(NSNotification *)noti {
    NSDictionary *dic = noti.object;
    if(dic == nil && ![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    SocialContactVC *vc = [self.controllersM lastObject];
    [vc inserNewData:dic];
    
    [self sectionBarClick:self.commentBnt];
}

- (void)configUI {
    //self.title = @"详情";
    _headerOriginHeight = SCREEN_WIDTH*854.0/1075.0;
    
    self.headerView = self.header;
    self.scaleBackgroundView = self.header;
    
    self.currentBarColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    self.currentTitelTextColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    
    [self setNavBarTitle:@"区块圈"];
    
    [self.backBut setImage:[UIImage imageNamed:@"public_white_back"] forState:UIControlStateNormal];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //[self configNavigationBar];
    [[MXRouter sharedInstance] configureCurrentVC:self];
//    self.config.suspenOffsetY = NavigationBar_Height;
//    [self configNavibar:self.curProgress];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)configNavigationBar {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.navigationBar setNavBarColor:self.currentBarColor];
//    [self.navigationController.navigationBar setTitleColor:self.currentTitelTextColor];
//    return;
    [self.navigationController.navigationBar barReset];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:self.currentImage forBarMetrics:UIBarMetricsDefault];
    
    //[self.navigationController.navigationBar setTitleColor:[UIColor redColor]];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSBackgroundColorAttributeName:[UIColor redColor]}];
//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    [self setNavBarRightBtnWithColor:self.navTitleLabel.textColor];
    //[self.navBarRightBtn setImage:[[UIImage imageNamed:@"我发的朋友圈white"] jsq_imageMaskedWithColor:self.navTitleLabel.textColor] forState:UIControlStateNormal];
    self.rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.navBarRightBtn];
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    self.navBarRightBtn.frame = CGRectMake(0, 0, 23, 23);
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIButton alloc] init]];
    
    //[self observeNavigationBarBGAlpha];
}

///设置导航栏右上角button的颜色状态
- (void)setNavBarRightBtnWithColor:(UIColor *)color {
    [self.navBarRightBtn setImage:[[UIImage imageNamed:@"我发的朋友圈white"] jsq_imageMaskedWithColor:color] forState:UIControlStateNormal];
    
    [self.backBut setImage:[[UIImage imageNamed:@"public_white_back"] jsq_imageMaskedWithColor:color] forState:UIControlStateNormal];
}

///导航栏背景图alpha莫名的被改
- (void)observeNavigationBarBGAlpha {
    static BOOL isFirst = YES;
    if(isFirst) {
        UIView *view = [[self.navigationController.navigationBar subviews] firstObject];
        if(view == nil) {
            return;
        }
        //NSClassFromString(@"_UIBarBackground")
        UIImageView *backgroundImageView = [view valueForKey:@"backgroundImageView"];
        if(backgroundImageView != nil) {
            [self observeBarAlpha:backgroundImageView];
        }
        isFirst = NO;
    }
}

- (void)observeBarAlpha:(UIImageView *)backgroundImageView {
    @weakify(self)
    [self.kvoController observe:backgroundImageView keyPath:@"alpha" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        @strongify(self)
        if(![[change valueForKey:@"kind"] isEqualToNumber:[change valueForKey:@"new"]]) {
            [self unobserveBarAlpha:backgroundImageView];
            backgroundImageView.alpha = 1;
            [self setNavBarRightBtnWithColor:[UIColor blackColor]];
            //[self.navBarRightBtn setImage:[[UIImage imageNamed:@"我发的朋友圈white"] jsq_imageMaskedWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
            [self observeBarAlpha:backgroundImageView];
        }
    }];
}

- (void)unobserveBarAlpha:(UIImageView *)backgroundImageView {
    [self.kvoController unobserve:backgroundImageView keyPath:@"alpha"];
}

#pragma mark - ReWrite
- (void)setNavBarTitle:(NSString *)title {
    self.navTitleLabel.text = title;
    self.navigationItem.titleView = self.navTitleLabel;
}

- (void)navBarRightBtnAction:(id)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //[MXRouter openURL:@"lcwl://PersonalDetailVC" parameters:nil];
    [[PhotoBrowser shared] dynamicShowPhotoLibrary:self allowSelectVideo:YES lastSelectAssets:nil completion:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nullable assets, BOOL isOriginal) {
        if([images isKindOfClass:[NSArray class]]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
                [param setValue:images forKey:@"photosArr"];
                [param setValue:assets forKey:@"assets"];
                if(assets.count == 1) {
                    PHAsset *asset = [assets lastObject];
                    [param setValue:@(asset.mediaType == PHAssetMediaTypeVideo) forKey:@"curSelectVideo"];
                }
                [MXRouter openURL:@"lcwl://PublishDynamic" parameters:param];
            });
        }
    }];
}

- (void)publishDynamic:(UIGestureRecognizer *)gestrue {
    if (gestrue.state == UIGestureRecognizerStateBegan)
    {
        [MXRouter openURL:@"lcwl://PublishDynamic" parameters:nil];
    }
}

+ (instancetype)instanceVC {
    
    YNPageConfigration *configration = [[self class] pageConfigration];
    
    SocialContactMainVC *vc = [[self class] pageViewControllerWithControllers:[self getArrayVCs]
                                                                                  titles:[self getArrayTitles]
                                                                                  config:configration];
    vc.dataSource = vc;
    vc.delegate = vc;
    
    return vc;
}

+ (YNPageConfigration *)pageConfigration {
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleSuspensionTop;
    configration.headerViewCouldScale = NO;
    configration.showTabbar = NO;
    configration.showNavigation = NO;
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = NO;
    configration.showBottomLine = YES;
    configration.bottomLineBgColor = [UIColor whiteColor];
    configration.lineColor = [UIColor whiteColor];
    configration.converColor = [UIColor whiteColor];
    configration.selectedItemColor = [UIColor whiteColor];
    configration.normalItemColor = [UIColor whiteColor];
    configration.menuHeight = 0;
    configration.menuWidth = SCREEN_WIDTH-20;
    configration.showAddButton = NO;
    //configration.cutOutHeight = 10;
    configration.headerViewScaleMode = YNPageHeaderViewScaleModeCenter;
    return configration;
}


+ (NSArray *)getArrayVCs {
    
    SocialContactVC *vc_2 = [[SocialContactVC alloc] init];
    vc_2.title = @"好友";
    vc_2.type = SocialContactTypeCare;
    
    return @[vc_2];
}

+ (NSArray *)getArrayTitles {
    return @[@"好友"];
}

- (void)adjustSectionBar:(CGFloat)offset {
    
    CGFloat value = ABS(offset / SCREEN_WIDTH);
    
    self.retweetBnt.transform = CGAffineTransformMakeScale(1-value*0.3, 1-value*0.3);
    
    self.commentBnt.transform = CGAffineTransformMakeScale(0.7+value*0.3, 0.7+value*0.3);
    
    self.indicator.centerX = self.retweetBnt.centerX + (self.commentBnt.centerX - self.retweetBnt.centerX)*value;
}

//- (void)reloadMenuView:(NSInteger)pageIndex {
//    [super reloadMenuView:pageIndex];
//    
//    [self updateMenu];
//}
//
//- (void)updateMenu {
//    [self.scrollMenuView addSubview:self.sectionBar];
//    [self.sectionBar mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.scrollMenuView);
//    }];
//    
//    [self.sectionBar layoutIfNeeded];
//}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    SocialContactVC *baseVC = (SocialContactVC *)pageViewController.controllersM[index];
    return baseVC.tableView;
}

- (void)pageViewController:(YNPageViewController *)pageViewController
        didEndDecelerating:(UIScrollView *)scrollView {
    //NSLog(@"#1 contentOffsetY:%f",scrollView.contentOffset.x);
    //[self adjustIndicatorPostion:self.pageIndex animation:YES];
    
    CGFloat offset = scrollView.contentOffset.x;
    if(offset >= SCREEN_WIDTH) {
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
    NSLog(@"#2 contentOffsetY:%f  progress:%f",scrollView.contentOffset.x,progress);
    [self adjustSectionBar:scrollView.contentOffset.x];
}

- (void)configNavibar:(CGFloat)progress {
    self.navigationController.navigationBar.translucent = progress < 1;
    self.currentImage = [UIImage createImageWithColor:RGBA(255, 255, 255, progress)];
    [self.navigationController.navigationBar setBackgroundImage:self.currentImage forBarMetrics:UIBarMetricsDefault];
    self.navTitleLabel.textColor = [UIColor colorWithWhite:0 alpha:progress];
    [self setNavBarRightBtnWithColor:[UIColor colorWithWhite:1-progress alpha:1]];
    [self updateStatusBar:(progress >= 1 ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent)];
}

- (void)pageViewController:(YNPageViewController *)pageViewController
            contentOffsetY:(CGFloat)contentOffset
                  progress:(CGFloat)progress {
    //NSLog(@"--- contentOffset = %f, progress = %f", contentOffset, progress);
    
    
    //[self.navigationController.navigationBar setBackgroundColor:RGBA(0, 0, 0, progress)];
    //[self.navigationController.navigationBar setTitleColor:[UIColor colorWithWhite:1-progress alpha:progress]];
    //[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1-progress alpha:progress]}];
    
    //[self.navBarRightBtn setImage:[[UIImage imageNamed:@"我发的朋友圈white"] jsq_imageMaskedWithColor:[UIColor colorWithWhite:1-progress alpha:1]] forState:UIControlStateNormal];
    self.curProgress = progress;
    [self configNavibar:progress];
}

//- (void)pageViewController:(YNPageViewController *)pageViewController
//            contentOffsetY:(CGFloat)contentOffsetY
//                  progress:(CGFloat)progress {
//    NSLog(@"#3 contentOffsetY:%f  progress:%f",contentOffsetY,progress);
//
//    CGFloat offsetY = ABS(contentOffsetY)-_headerOriginHeight-self.sectionBar.height;
//    NSLog(@"offsetY: %f",offsetY);
//    if (offsetY > 0) {
//        CGFloat newOffsetY = offsetY/2;
//        CGFloat width = SCREEN_WIDTH+ABS(newOffsetY)*2;
//        CGFloat height = _headerOriginHeight*width/SCREEN_WIDTH;
//        self.header.frame = CGRectMake(-newOffsetY, -offsetY, width, height);
//    }
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    @weakify(self)
//    [self.navigationController.navigationBar showWithOffset:scrollView.contentOffset.y currentColors:^(UIColor *currentBarColor, UIColor *currentTitelColor) {
//        @strongify(self)
//        self.currentBarColor = currentBarColor;
//        self.currentTitelTextColor = currentTitelColor;
//        if(scrollView.contentOffset.y) {
//
//        }
//
//        CGFloat offsetY = scrollView.contentOffset.y;
//        //定义，移动40距离的时候，缩小到最小
//        CGFloat progress;
//        if (offsetY > -64) {
//            progress = (offsetY + 64)/40;
//            progress = MIN(progress, 1);
//        }else{
//            progress = 0;
//        }
//        //处理Scale与Alpha
//        CGFloat scale = 1 - 0.4*progress;
//        CGFloat alpha = 1 - progress;
//        //        self.navTextfield.backgroundColor = [self lightGrayWithAplpa:alpha];
//        //计算要位移的距离
////        CGFloat navHeight = 44;
////        CGFloat navOffSetY = -1 * navHeight * 0.4 * progress;
////        CGFloat textFieldOffsetY = navHeight * 0.2 * progress;
////        CGAffineTransform scaleTran = CGAffineTransformMakeScale(scale, scale);
////        CGAffineTransform transTran = CGAffineTransformMakeTranslation(0, textFieldOffsetY);
//        //        self.navTextfield.transform = CGAffineTransformConcat(scaleTran, transTran);
//        //        self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0,navOffSetY);
//    }];
//}

- (void)sectionBarClick:(UIButton *)sender {
    [self resetSectionBar];
    sender.selected = YES;
    //[self.scrollMenuView selectedItemIndex:sender.tag-1000 animated:YES];
    //[self adjustIndicatorPostion:sender.tag-1000 animation:YES];
    [self setSelectedPageIndex:sender.tag-1000];
}

- (void)popularityClick:(UIButton *)sender {
    [MXRouter openURL:@"lcwl://SCPopularityMainVC" parameters:nil];
}

- (void)sendFriendCircle:(UIButton *)sender {
    [MXRouter openURL:@"lcwl://PublishDynamic" parameters:nil];
}

- (void)addMoreBntClick:(UIButton *)sender {
    [self showPopMenu:@[@"发朋友圈", @"发起群聊", @"添加好友", @"扫一扫", @"我发的朋友圈"] iconArr:@[@"im_publish_feed_icon", @"im_create_team_icon", @"im_add_friend_icon",@"im_scan_qr_icon",@"我发的朋友圈"] sender:sender];
}

- (void)updateStatusBar:(UIStatusBarStyle)style {
    if(style == UIStatusBarStyleDefault) {
        if(self.barStyle != UIStatusBarStyleDefault) {
            self.barStyle = UIStatusBarStyleDefault;
            [self setNeedsStatusBarAppearanceUpdate];
        }
    } else if(style == UIStatusBarStyleLightContent) {
        if(self.barStyle != UIStatusBarStyleLightContent) {
            self.barStyle = UIStatusBarStyleLightContent;
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.barStyle;
}

- (void)resetSectionBar {
    for(UIButton *bnt in [self.sectionBar subviews]) {
        if([bnt isKindOfClass:[UIButton class]]) {
            bnt.selected = NO;
        }
    }
}

- (void)adjustIndicatorPostion:(NSInteger)pageIndex animation:(BOOL)animation {
    //UIImageView *indicator = [self.sectionBar viewWithTag:9999];
    UIButton *bnt = [self.sectionBar viewWithTag:(1000+pageIndex)];
    //indicator.top = self.sectionBar.height-indicator.height;
    [self resetSectionBar];
    bnt.selected = YES;
    //CGFloat desX = bnt.centerX;
//    [UIView animateWithDuration:(animation ? 0.25 : 0) animations:^{
//        indicator.centerX = desX;
//    } completion:^(BOOL finished) {
//
//    }];
}

- (void)menu:(BaseMenuViewController *)menu didClickedItemUnitWithTag:(NSInteger)tag andItemUnitTitle:(NSString *)title {
//    if(tag == 0) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [MXRouter openURL:@"lcwl://PublishDynamic" parameters:nil];
//        });
//    } else if(tag == 1) {
//        //选择一个群
//        [MXRouter openURL:@"lcwl://GroupChatVC" parameters:@{@"callBack":^(NSArray* selectArray){
//            PersonalDetailModel* user = [LcwlChat shareInstance].user;
//            if (selectArray.count == 1) {
//
//                id model = selectArray[0];
//                if ([model isKindOfClass:[ChatGroupModel class]]) {
//                    ChatGroupModel* group = (ChatGroupModel*)model;
//                    MXConversation* con = [[MXConversation alloc]init];
//                    con.conversationType = eConversationTypeGroupChat;
//                    con.chat_id = group.groupId;
//                    [[LcwlChat shareInstance].chatManager createConversationObject:con];
//                    [TalkManager pushChatViewUserId:group.groupId type:eConversationTypeGroupChat];
//                }else if([model isKindOfClass:[FriendModel class]]){
//                    FriendModel* friend = (FriendModel*)model;
//                    MXConversation* con = [[MXConversation alloc]init];
//                    con.conversationType = eConversationTypeChat;
//                    con.chat_id = friend.userid;
//                    [[LcwlChat shareInstance].chatManager createConversationObject:con];
//                    [TalkManager pushChatViewUserId:friend.userid type:eConversationTypeChat];
//                }
//
//                return;
//            }
//            __block NSMutableArray* idArray = [[NSMutableArray alloc]initWithCapacity:10];
//            __block NSMutableArray* nameArray = [[NSMutableArray alloc]initWithCapacity:10];
//            [selectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                FriendModel* friend = (FriendModel*)obj;
//                [idArray addObject:friend.userid];
//                [nameArray addObject:friend.name];
//            }];
//            NSData *data=[NSJSONSerialization dataWithJSONObject:idArray options:NSJSONWritingPrettyPrinted error:nil];
//
//            NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//            jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
//            [RoomManager createGroup:@{@"userId":jsonStr} completion:^(id group, NSString *error) {
//                if (group) {
//                    ChatGroupModel* model = (ChatGroupModel*)group;
//                    [[LcwlChat shareInstance].chatManager insertGroup:model];
//                    NSString* tip = [NSString stringWithFormat:@"你邀请%@加入了群聊",[nameArray componentsJoinedByString:@"、"]];
//                    [ChatSendHelper sendSgroup:tip from:model.groupId messageType:SGROUPTypeCreate];
//                    FriendModel* selfModel = [user toFriendModel];
//                    selfModel.groupid = model.groupId;
//                    selfModel.groupNickname = selfModel.name;
//                    [[LcwlChat shareInstance].chatManager insertGroupMember:selfModel];
//                    [selectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                        FriendModel* friend = (FriendModel*)obj;
//                        friend.groupid = model.groupId;
//                        friend.groupNickname = friend.name;
//                        [[LcwlChat shareInstance].chatManager insertGroupMember:friend];
//                    }];
//                    [TalkManager pushChatViewUserId:model.groupId type:eConversationTypeGroupChat];
//
//                }else{
//                    [NotifyHelper showMessageWithMakeText:error];
//                }
//
//            }] ;
//
//        }}];
//    } else if(tag == 2) {
//        [MXRouter openURL:@"lcwl://AddFriendVC" parameters:nil];
//    } else if(tag == 3) {
//        [MXRouter openURL:@"lcwl://MXBarReaderVC" parameters:nil];
//    }else if(tag == 4) {
//        [MXRouter openURL:@"lcwl://PersonalDetailVC" parameters:nil];
//    }
}

- (void)changeHeaderBG {
    @weakify(self)
    [UIAlertController showActionSheetInViewController:self
                                             withTitle:nil
                                               message:nil
                                     cancelButtonTitle:@"取消"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@[@"更换朋友圈封面"]
                    popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {
                        
                    } tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        @strongify(self)
                        if (buttonIndex == 0) {
                            NSLog(@"Cancel Tapped");
                        } else if (buttonIndex == 2) {
                            [self showPhotoLibrary];
                        }
                    }];
}

- (void)showPhotoLibrary {
    @weakify(self)
    [[PhotoBrowser shared] showSelectSocialContactPhotoLibrary:self completion:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nullable assets, BOOL isOriginal) {
        @strongify(self)
        if([images isKindOfClass:[NSArray class]]) {
            if([[images firstObject] isKindOfClass:[UIImage class]]) {
                UIImage *image = [images firstObject];
                if(image != nil && [image isKindOfClass:[UIImage class]] && image.size.width > 0) {
                    self.headerBG.image = image;
                    self.headerBG.height = image.size.height*SCREEN_WIDTH/image.size.width;
                    self.header.width = SCREEN_WIDTH;
                    self.header.height = image.size.height*SCREEN_WIDTH/image.size.width+37;
                    self.headerView = self.header;
                    
//                    [MXCache setValue:image forKey:[NSString stringWithFormat:@"%@_%@",@"SocialContactHeaderBG",AppUserModel.user_id]];
                    [self reloadData];
                    [self reloadSuspendHeaderViewFrame];
                    //[self updateMenu];
                    
                    [[QNManager shared] uploadImage:image completion:^(id data) {
                        if(data && [NSURL URLWithString:data]) {
                            [self modifyUserInfo:@{@"circle_back_img":data} showMsg:NO completion:^(BOOL success, NSString *error) {
                                if(success) {
                                    //[LcwlChat shareInstance].user.circle_back_img = data;
                                }
                            }];
                        }
                    }];
                }
                
            }
        }
    }];
}

- (UIButton *)sectionBnt:(NSString *)title {
    UIButton *retweet = [[UIButton alloc] init];
    [retweet setTitle:title forState:UIControlStateNormal];
    retweet.titleLabel.font = [UIFont systemFontOfSize:20];
    [retweet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [retweet setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [retweet addTarget:self action:@selector(sectionBarClick:) forControlEvents:UIControlEventTouchUpInside];
    return retweet;
}

- (void)reloadHeader {
    _nameLbl.text = AppUserModel.smartName;
    [_headPhoto sd_setImageWithURL:[NSURL URLWithString:AppUserModel.head_photo] forState:UIControlStateNormal placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(image == nil) {
            [_headPhoto setBackgroundImage:[UIImage imageNamed:@"avatar_default"] forState:UIControlStateNormal];
        }
    }];
}

- (UIView *)header {
    if(!_header) {
        _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        
        _headerBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _headerOriginHeight)];
        _headerBG.contentMode = UIViewContentModeScaleAspectFill;
        _headerBG.userInteractionEnabled = YES;
        _headerBG.clipsToBounds = YES;
        NSString *circle_back_img = nil;
        __weak typeof(_headerBG)weakHeaderBG = _headerBG;
        [_headerBG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://jiasu.wzftop.com/%@",AppUserModel.circle_back_img]] placeholderImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#434443"] size:CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*854.0/1075.0)] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            CATransition *transition = [CATransition animation];
            transition.type = kCATransitionFade;
            transition.duration =0.25;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [weakHeaderBG.layer addAnimation:transition forKey:nil];
        }];
        
        [_header addSubview:_headerBG];
        _header.height = _headerOriginHeight + 37.5;
        
        _nameLbl = [[UILabel alloc] init];
        _nameLbl.text = AppUserModel.smartName;
        _nameLbl.textColor = [UIColor whiteColor];
        _nameLbl.font = [UIFont boldFont14];
        [_header addSubview:_nameLbl];
        
        _headPhoto = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _headPhoto.layer.cornerRadius = 5;
        _headPhoto.clipsToBounds = YES;
        //[_headPhoto setImage:[UIImage imageNamed:@"avatar_default"] forState:UIControlStateNormal];
        [_header addSubview:_headPhoto];
        [_headPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-19));
            make.right.equalTo(@(-15.5));
            make.width.height.equalTo(@(50));
        }];
        
        [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_headPhoto.mas_left).offset(-10);
            make.top.equalTo(_headPhoto.mas_top).offset(6);
        }];
        _header.backgroundColor = [UIColor whiteColor];
        
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(publishDynamic:)];
        [self.publishBnt addGestureRecognizer:gesture];
        [_header addSubview:self.publishBnt];
    }
    return _header;
}

- (UIView *)sectionBar {
    if(!_sectionBar) {
        _sectionBar = [[UIView alloc] init];
        _sectionBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
        _sectionBar.backgroundColor = [UIColor whiteColor];
        
        self.retweetBnt = [self sectionBnt:@"推荐"];
        self.retweetBnt.tag = 1000;
        self.retweetBnt.frame = CGRectMake(15, 27, 42, 24);
        self.retweetBnt.layer.anchorPoint = CGPointMake(0.5, 0.85);
        //self.retweetBnt.titleLabel.font = [UIFont systemFontOfSize:20];
        
        self.commentBnt = [self sectionBnt:@"好友"];
        self.commentBnt.tag = 1001;
        self.commentBnt.selected = YES;
        self.commentBnt.frame = CGRectMake(42+20, 27, 42, 24);
        self.commentBnt.layer.anchorPoint = CGPointMake(0.5, 0.85);
        self.commentBnt.transform = CGAffineTransformMakeScale(0.7, 0.7);
        
        UIButton *popularityBnt = [[UIButton alloc] init];
        [popularityBnt setTitle:@"  人气" forState:UIControlStateNormal];
        [popularityBnt setImage:[UIImage imageNamed:@"人气"] forState:UIControlStateNormal];
        popularityBnt.titleLabel.font = [UIFont systemFontOfSize:14];
        [popularityBnt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [popularityBnt addTarget:self action:@selector(popularityClick:) forControlEvents:UIControlEventTouchUpInside];
        popularityBnt.tag = 2000;
        
        UIImageView *newIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new"]];
        newIcon.frame = CGRectMake(12, 13, 18, 11);
        [popularityBnt addSubview:newIcon];
        
        UIButton *sendBnt = [[UIButton alloc] init];
        [sendBnt setTitle:@"  发圈" forState:UIControlStateNormal];
        [sendBnt setImage:[UIImage imageNamed:@"朋友圈_发朋友圈"] forState:UIControlStateNormal];
        sendBnt.titleLabel.font = [UIFont systemFontOfSize:14];
        [sendBnt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sendBnt addTarget:self action:@selector(sendFriendCircle:) forControlEvents:UIControlEventTouchUpInside];
        sendBnt.tag = 2001;
        
        UIButton *addBnt = [[UIButton alloc] init];
        [addBnt setImage:[UIImage imageNamed:@"朋友圈_添加"] forState:UIControlStateNormal];
        [addBnt addTarget:self action:@selector(addMoreBntClick:) forControlEvents:UIControlEventTouchUpInside];
        addBnt.tag = 2002;
        
        _indicator = [[UIImageView alloc] init];
        _indicator.tag = 9999;
        _indicator.frame = CGRectMake(0, 0, 15, 3);
        _indicator.backgroundColor = [UIColor blueColor];
        _indicator.clipsToBounds = YES;
        _indicator.layer.cornerRadius = 1.5;
        _indicator.top = _sectionBar.height - 3;
        _indicator.centerX = self.retweetBnt.centerX;
        
        [_sectionBar addSubview:self.retweetBnt];
        [_sectionBar addSubview:self.commentBnt];
        [_sectionBar addSubview:popularityBnt];
        [_sectionBar addSubview:sendBnt];
        [_sectionBar addSubview:addBnt];

        [_sectionBar addSubview:_indicator];
        
//        [self.retweetBnt mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo([self.retweetBnt superview]).offset(-10);
//            make.left.equalTo([self.retweetBnt superview]).offset(15);
//        }];
//
//        [self.commentBnt mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo([self.commentBnt superview]).offset(-10);
//            //make.left.equalTo(self.retweetBnt.mas_right).offset(20);
//            make.right.equalTo([self.commentBnt superview].mas_left).offset(100);
//        }];
        
        [addBnt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.bottom.equalTo([addBnt superview]);
            make.right.equalTo([addBnt superview].mas_right).offset(-15);
        }];
        
        [sendBnt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.bottom.equalTo([sendBnt superview]);
            make.right.equalTo(addBnt.mas_left).offset(-20);
        }];
        
        [popularityBnt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.bottom.equalTo([sendBnt superview]);
            make.right.equalTo(sendBnt.mas_left).offset(-20);
        }];
        
        [_sectionBar addBottomSingleLine:[UIColor moLineLight]];
    }
    return _sectionBar;
}

- (UILabel *)navTitleLabel {
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 24)];
        _navTitleLabel.backgroundColor = [UIColor clearColor];
        _navTitleLabel.font = [UIFont systemFontOfSize:19.0f];
        _navTitleLabel.textAlignment = NSTextAlignmentCenter;
        _navTitleLabel.textColor = [UIColor whiteColor];
    }
    
    return _navTitleLabel;
}

- (UIButton *)publishBnt {
    if (!_publishBnt) {
        _publishBnt = [UIButton buttonWithType:UIButtonTypeCustom];
        _publishBnt.frame = CGRectMake(SCREEN_WIDTH-100, NavigationBar_Bottom-30, 80, 30);
        _publishBnt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _publishBnt.titleLabel.font = [UIFont font14];
        [_publishBnt setImage:[UIImage imageNamed:@"我发的朋友圈white"] forState:UIControlStateNormal];
        [_publishBnt setTitleColor:[UIColor moBlack] forState:UIControlStateNormal];
        [_publishBnt setTitleColor:[UIColor moDarkGray] forState:UIControlStateDisabled];
        [_publishBnt addTarget:self action:@selector(navBarRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _publishBnt;
}

@end
