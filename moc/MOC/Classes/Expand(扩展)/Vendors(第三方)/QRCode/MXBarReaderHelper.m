//
//  MXBarReaderHelper.m
//  MoPal_Developer
//
//  Created by yuhx on 15/7/22.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MXBarReaderHelper.h"
#import "MXBarReaderVC.h"
#import "NSObject+Additions.h"
#import "MXAlertViewHelper.h"
#import "MXNet.h"
static NSString* tag_user = @"user?";
static NSString* tag_group = @"group?";
static NSString* QR_HEAD = @"https://bill.s1.natapp.cc/givinggift/userCrowd/twoDimensionaCodes/";
@interface  MXBarReaderHelper ()

// 扫描类型
@property (nonatomic, assign) SweepType sweepType;
//web页面
@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, weak) MXBarReaderVC *barReaderVC;

@end

@implementation MXBarReaderHelper

- (instancetype)initWithBarReaderVC:(MXBarReaderVC*)barReaderVC
{
    self = [super init];
    if (self) {
        _barReaderVC = barReaderVC;
    }
    return self;
}

- (void)dealWithReadingData:(NSString *)qrCode {
    //special by lhy 2016年02月26日
    //扫描过程中被踢下线，则不做任何请求
//    if ([StringUtil isEmpty:AppUserModel.token]) {
//        [self startReader];
//        return;
//    }

    NSString *content = [self resetSweepTypeWithQrcode:qrCode];
    
    switch (self.sweepType) {
        case AddFriendType:   // 关注好友
            [self addFriendWithID:content];
            break;
        case AddShop:
        {
            [self sweepShopInfoWithContent:content];
            break;
        }
        case MoxianUrl:
        {
            [self sweepMoxianUrlWithContent:content];
            break;
        }
        case SweepCardOneTime:
        {
            break;
        }
        case SweepCodeOneMoreTime:
        {
            break;
        }
        case ThirdParty:
        {
            [self showThirdPartyWithContent:content];
            break;
        }
        case AddGroup:
        {
            [self inviteVCwithContent:content];
            break;
        }
        case SweepActivity:
        {
            [self sweepActivityWithContent:content];
            break;
        }
        case Grabs:
        {
            [self sweepShopQRGivePoint];
            break;
        }

        default:
            break;
    }
}

#pragma mark - 区分不同环境的二维码地址
- (NSString *)qrCodeUrlType:(NSString *)type {
//
//    NSString *url = [NSString stringWithFormat:@"http://%@%@",@"m",SERVER_ROOT];
//    if (!type) {
//        return url;
//    }
//
//    return [NSString stringWithFormat:@"%@?type=%@", url, type];
    return @"erwerima";
}

#pragma mark-确定扫描模块,分析扫描内容
-(NSString *)resetSweepTypeWithQrcode:(NSString *)qrCode
{
    NSString *content = nil;
    self.sweepType = ThirdParty;
    content = qrCode;
    //  扫描关注好友
    NSInteger startIndex;
    if ((startIndex = [qrCode rangeOfString:@"user?"].location) != NSNotFound){
        self.sweepType = AddFriendType;
        content = [qrCode substringFromIndex:startIndex+@"user?".length];
    }
    //扫描群二维码
    if ((startIndex = [qrCode rangeOfString:@"group?"].location) != NSNotFound){
        self.sweepType = AddGroup;
        content = [qrCode substringFromIndex:startIndex+@"group?".length];
    }
    return content;
}

#pragma mark - 扫一扫关注
- (void)addFriendWithID:(NSString*)qrCode
{
    if (![qrCode isKindOfClass:[NSString class]]) {
        return;
    }
    NSInteger startIndex;
    NSString *content;
    if ((startIndex = [qrCode rangeOfString:@"userId="].location) != NSNotFound){
        self.sweepType = AddFriendType;
        content = [qrCode substringFromIndex:startIndex+@"userId=".length];
    }
    [MXRouter openURL:@"lcwl://PersonalDetailVC" parameters:@{@"other_id":content}];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_barReaderVC startReader];
}

#pragma mark-扫一扫第三方
-(void)showThirdPartyWithContent:(NSString *)content
{
    if (![content isKindOfClass:[NSString class]]) {
        return;
    }
    
//    SweepThirdResultVC *resultVC = [[SweepThirdResultVC alloc]initWithNibName:@"SweepThirdResultVC" bundle:nil];
//    resultVC.sweepContent = content;
//
//    if ([content rangeOfString:@"http://"].location != NSNotFound || [content rangeOfString:@"https://"].location != NSNotFound) {
//        resultVC.isUrl = YES;
//    }
//    else
//    {
//        resultVC.isUrl = NO;
//    }
//    [_barReaderVC.navigationController pushViewController:resultVC animated:YES];
    if([content containsString:@"?userId="]) {
        [MXRouter openURL:@"lcwl://PersonalDetailVC" parameters:@{@"other_id":[[content componentsSeparatedByString:@"?userId="] lastObject] ?: @""}];
        return;
    }
    [MXRouter openURL:@"lcwl://MBWebVC" parameters:@{@"url":[NSURL URLWithString:content] ?: @""}];
}

#pragma mark-跳转到web页
-(void)jumpToWebViewWithUrlString:(NSString*)urlString
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

#pragma mark-扫描店铺
-(void)sweepShopInfoWithContent:(NSString *)content
{
    if (!content) {
        return;
    }
    
    // 商店信息
//    MXShopHomeInfoApi *shopInfoApi = [[MXShopHomeInfoApi alloc] initWithParameter:@{@"id" : content}];
//    [NotifyHelper showHUDAddedTo:_barReaderVC.view animated:YES];
//    @weakify(self)
//    [shopInfoApi startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//        @strongify(self)
//        [NotifyHelper hideAllHUDsForView:_barReaderVC.view animated:YES];
//        NSDictionary *dictionary = request.responseJSONObject;
//        BOOL authenSuccess = [[dictionary valueForKeyPath:@"data.authItype"] integerValue] == AuthenSuccess;
//        if (dictionary && [dictionary isKindOfClass:[NSDictionary class]]) {
//            if ([dictionary[@"result"] boolValue] && authenSuccess) {
//                [MXRouter openURL:@"moxian://MXStoreHomeVC" parameters:@{@"shopId" : content, kEventId : @(kEvent_100001)}];
//            }
//            else
//            {
//                if ([dictionary[@"code"] isEqualToString:@"mx2204154"] || !authenSuccess) {
//                    [MXAlertViewHelper showAlertViewWithMessage:MXLang(@"Scan_tryAgain", @"扫描出错,再试试呗~") title:MXLang(@"Shops_ShopIsError", @"店铺不存在") okTitle:MXLang(@"Public_Ok", @"确定") cancelTitle:nil completion:^(BOOL cancelled, NSInteger buttonIndex) {
//                        @strongify(self)
//                        [self startReader];
//                    }];
//                }
//                else
//                {
//                    NSString *tempString = [NSString stringWithFormat:@"ErrorCode_%@",dictionary[@"code"]];
//                    [NotifyHelper showMessageWithMakeText:MXLang(tempString, @"缺少服务器多语言资源包")];
//                    [self startReader];
//                }
//            }
//        }
//
//    } failure:^(MXRequest *request) {
//        @strongify(self)
//        [NotifyHelper hideAllHUDsForView:_barReaderVC.view animated:YES];
//        [NotifyHelper showMessageWithMakeText:[shopInfoApi requestServerErrorString]];
//        [self startReader];
//    }];
}

#pragma mark-扫描m.moxian.com
-(void)sweepMoxianUrlWithContent:(NSString *)content
{
    [self jumpToWebViewWithUrlString:content];
    [self startReader];
//    [_barReaderVC.navigationController popViewControllerAnimated:YES];
}

#pragma mark-扫描群


-(void)inviteVCwithContent:(NSString*)content{
    NSString* groupTag = @"groupId=";
    NSString* inviteTag = @"&inviteCode=";
    NSInteger indexGroup = [content rangeOfString:groupTag].location;
    NSInteger indexInvite = [content rangeOfString:inviteTag].location;
    NSString* groupId = [content substringWithRange:NSMakeRange(indexGroup+groupTag.length,indexInvite - indexGroup-groupTag.length)];
    NSString* inviteId = [content substringWithRange:NSMakeRange(indexInvite+inviteTag.length, content.length-(indexInvite+inviteTag.length))];
    [MXRouter openURL:@"lcwl://GroupDetailVC" parameters:@{@"groupid":groupId,@"inviteid":inviteId}];
}

#pragma mark-扫描活动
-(void)sweepActivityWithContent:(NSString *)content
{
    //contetnt 为魔商活动ID
    //special by lhy 魔商活动才有二维码 2015年12月22日
//    ActivityListModel *model = [[ActivityListModel alloc] init];
//    model.type = @"2";
//    model.activityId = content;
//    [MXRouter openURL:@"moxian://ActivityInfoVC" parameters:@{@"model":model}];
}

#pragma mark-扫商家二维码送积分
- (void)sweepShopQRGivePoint{
    MLog();
    @weakify(self)
//    [GetFriendsManager grabsShopPoint:^(id object, NSString *error) {
//        NSDictionary *dic = (NSDictionary *)object;
//        if([dic isKindOfClass:[NSDictionary class]]) {
//        [MXAlertViewHelper showAlertViewWithMessage:nil title:[dic objectForKey:@"needReturnInfo"] okTitle:[dic objectForKey:@"buttonInfo"] cancelTitle:nil completion:^(BOOL cancelled, NSInteger buttonIndex) {
//            @strongify(self)
//            [self.barReaderVC.navigationController popViewControllerAnimated:YES];
//        }];
//        }
//    }];
}

#pragma mark-扫一扫充值魔分（单次充值）
-(void)sweepSingleRechargeWithContent:(NSString *)content
{
    
}

#pragma mark-扫一扫充值魔分（多次充值）
-(void)sweepManyTimesRechargeWithContent:(NSString *)content
{
    
}

-(void)startReader
{
    [self.barReaderVC startReader];
}
//user?userId=xxx
+(NSString *)makeGroupQRCode:(NSString *)groupid invite:(NSString *)inviteId{
    return [NSString stringWithFormat:@"%@group?groupId=%@&inviteCode=%@",QR_HEAD,groupid,inviteId];
}
@end
