//
//  MXRemotePush.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/4/8.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MXRemotePush.h"
//#import "GeTuiSdk.h"
#import "MXPushCIDApi.h"
#import "MXUnbindCIDApi.h"
#import "MXPushModel.h"
#import "NSObject+Property.h"
#import <YYKit/NSObject+YYModel.h>
#import "BaseNavigationController.h"
#import "GVUserDefaults+Properties.h"
#import "UserModel.h"

// 企业key 应用名称：MopalM2_Group_Online 到期：2018 年 03 月 24 日 16:40:52
#define kAppId          @"rp66oTaR8c7GXgV5dofO87"
#define kAppKey         @"SoGUaOATYk8uF2bWWuemt5"
#define kAppSecret      @"IeKQoz6ptV5ExgDu3g5X8"

// 企业key_Test 应用名称：MopalM2_Group_Test 到期：2018 年 03 月 24 日 16:40:52
#define kAppIdTest      @"qPtoQjVQT76gDr2KRajzD7"
#define KAppKeyTest     @"J4fwiCi6q48kHwoTjIzed8"
#define kAppSecretTest  @"CqLLgmytKp9l6sVQX7XIf1"

// app store key 应用名称：MopalM2_Store_Online 到期：2017 年 12 月 03 日 11:33:41
#define kAppStoreId     @"wgOI4UDgN76zrfKfXdM1M8"
#define kAppStoreKey    @"2TImB359w2AHLktg5twbe4"
#define kAppStoreSecret @"zOjx8sWCpV6iljdtArkdI"


#define kExcuteToDealOffLineNotification @"kExcuteToDealOffLineNotification"
#define kOffLineMessageType              @"kOffLineMessageType"

@interface MXRemotePush () //<GeTuiSdkDelegate>
{
    NSString *_deviceToken;

}
//@property (assign, nonatomic) SdkStatus sdkStatus;
@property (nonatomic, copy)   NSString *clientId;

@end

@implementation MXRemotePush
//
//+ (MXRemotePush *)sharedInstance
//{
//    static id sharedInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedInstance = [[self alloc] init];
//    });
//    return sharedInstance;
//}
//
//- (id)init{
//    
//    self=[super init];
//    
//    if (self) {
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(excuteToDealOffLineNotification:) name:kExcuteToDealOffLineNotification object:nil];
//    }
//    
//    return self;
//}
//
//#pragma mark - 注册推送通知
//- (void)registerRemoteNotification
//{
//#ifdef __IPHONE_8_0
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
//        
//        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//    } else {
//        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
//    }
//#else
//    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
//#endif
//}
//
//#pragma mark - 初始化SDK首先要调用
//- (void)start
//{
////    _sdkStatus = SdkStatusStoped;
////
////    [self startGeTuiSdk];
////
////    [GeTuiSdk runBackgroundEnable:YES];
////
////    [GeTuiSdk lbsLocationEnable:YES andUserVerify:YES];
////
////    MLog(@"[GexinSdk version]:%@",[GeTuiSdk version]);
//}
//
///**
// *  根据不同的环境获取AppID
// */
//- (void)startGeTuiSdk{
//    
//    NSString *appId     = nil;
//    NSString *appKey    = nil;
//    NSString *appSecret = nil;
//    
//    if ([StringUtil isGroupApp]) {
//#ifdef OpenDebugVC
//        MXMoXianServerDomain serverType = [GVUserDefaults standardUserDefaults].serverType;
//        if (serverType == MXMoXianServerDomainOnline) {
//            appId     = kAppId;
//            appKey    = kAppKey;
//            appSecret = kAppSecret;
//        }else{
//            appId     = kAppIdTest;
//            appKey    = KAppKeyTest;
//            appSecret = kAppSecretTest;
//        }
//#else
//        appId     = kAppId;
//        appKey    = kAppKey;
//        appSecret = kAppSecret;
//#endif
//    }else{
//        appId     = kAppStoreId;
//        appKey    = kAppStoreKey;
//        appSecret = kAppStoreSecret;
//    }
//    
////    [GeTuiSdk startSdkWithAppId:appId appKey:appKey appSecret:appSecret delegate:self];
//}
//
//#pragma mark - 停止推送,清理内存
//- (void)stopSdk
//{
////    _sdkStatus = SdkStatusStoped;
//}
//
//- (void)resume {
////    [GeTuiSdk resume];
//}
//
//
//#pragma mark - send message
//- (NSString *)sendMessage:(NSData *)body error:(NSError **)error
//{
//    
//    return @"";
////    return [GeTuiSdk sendMessage:body error:error];
//}
//
//#pragma mark - 上传个推用户id
//- (void)pushClientIDToServer
//{
//    if (self.clientId) {
//        if ([StringUtil isEmpty:AppUserModel.token]) {
//            return;
//        }
//        NSNumber *deviceType =  [StringUtil isGroupApp] ? @(2) : @(3);
//        MXPushCIDApi *api = [[MXPushCIDApi alloc] initWithParameter:@{
//                                                                      @"cid" : _clientId,
//                                                                      @"deviceType" : deviceType,
//                                                                      @"appType":@1
//                                                                      }
//                             ];
//        api.ignoreCache = YES;
//        [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
////            [NotifyHelper showMessageWithMakeText:request.responseJSONObject];
//        } failure:nil];
//    }
//}
//
//#pragma mark - 个推设备解绑
//- (void)unbindClientID
//{
//    
//    UserModel* user = AppUserModel;
//    if (self.clientId && user.userId && user.token) {
//        MXUnbindCIDApi *api = [[MXUnbindCIDApi alloc] initWithParameter:@{@"cid" : _clientId}];
//        api.ignoreCache = YES;
//        [api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
//            MLog(@"______responseJSONObject %@",request.responseJSONObject);
//        } failure:^(MXRequest *request) {
//            MLog(@"error %@",@(request.responseStatusCode));
//        }];
//    }
//}
//
//#pragma mark - 向个推服务器注册deviceToken
//- (void)registerForRemoteNotificationsForGeTuiWithDeviceToken:(NSData*)deviceToken
//{
//    
////    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
////    _deviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
////    MXLog(@"deviceToken:%@", _deviceToken,nil);
////
////    [MXCache setValue:_deviceToken forKey:@"deviceToken"];
////
////    // [3]:向个推服务器注册deviceToken
////    [GeTuiSdk registerDeviceToken:_deviceToken];
//}
//
//#pragma mark - 如果APNS注册失败，通知个推服务器
//- (void)registerGeTuiError
//{
//    // [3-EXT]:如果APNS注册失败，通知个推服务器
//  
//    [GeTuiSdk registerDeviceToken:@""];
// 
//}
//
//#pragma mark - 离线消息处理推送数据(iOS7以前的方法)
//- (void)didReceiveRemoteNotification:(NSDictionary *)userinfo {
//    [self didReceiveRemoteNotificationBackground:userinfo];
//}
//
//#pragma mark - 离线消息处理推送数据(iOS7以后的方法)
//- (void)didReceiveRemoteNotificationBackground:(NSDictionary *)userInfo application:(UIApplication *)application {
//    [self didReceiveRemoteNotificationBackground:userInfo];
//}
//
//- (void)didReceiveRemoteNotificationBackground:(NSDictionary *)userInfo
//{
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    
//    // [4-EXT]:处理APN
//    NSString *payloadMsg = [userInfo objectForKey:@"payload"];
//    
//    NSDictionary *aps = [userInfo objectForKey:@"aps"];
////    NSNumber *contentAvailable = aps == nil ? nil : [aps objectForKeyedSubscript:@"content-available"];
//    
////    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@, [content-available: %@]", [NSDate date], payloadMsg, contentAvailable];
////    MLog(@"Background Remote data %@",record);
//    
//    NSString *body = aps[@"alert"][@"body"];
//    
////    if (payloadMsg && ([body rangeOfString:@"转账"].location == NSNotFound || [body rangeOfString:@"钱包"].location == NSNotFound)) {
////        NSDictionary *msgDic = [MXJsonParser jsonToDictionary:payloadMsg];
////        NSNumber *type = msgDic[@"t"];
////        [MXCache setValue:[NSString stringWithFormat:@"%@",type] forKey:kOffLineMessageType];
////    } else if (body && ([body rangeOfString:@"转账"].location != NSNotFound || [body rangeOfString:@"钱包"].location != NSNotFound)) {
////        [self handleWalletPush:userInfo];
////        MXLog(body, nil);
////    }
//}
//
//// 当登录成功后，检测本地有没有离线推送的值，如果有，则通知切换界面跳转
//- (void)sendNotificationMessage {
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kExcuteToDealOffLineNotification object:nil];
//}
//
//#pragma mark - GexinSdkDelegate
//- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId
//{
////    // [4-EXT-1]: 个推SDK已注册
////    _sdkStatus = SdkStatusStarted;
////    self.clientId = clientId;
////
////    [self pushClientIDToServer];
////
////    if (_deviceToken) {
////
////        [GeTuiSdk registerDeviceToken:_deviceToken];
////
////    }
//}
//
//// 长连接
//- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
//    // [4]: 收到个推消息
////    NSString *payloadMsg = nil;
////    if (payloadData) {
////        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
////    }
////
////    NSDictionary *sendMsgDic = [MXJsonParser jsonToDictionary:payloadMsg];
////
////    NSNumber *type = sendMsgDic[@"t"];
////
////    NSString *temp = [NSString stringWithFormat:@"ErrorCode_%@",sendMsgDic[@"msg"]];
////    NSString *hint = MXLang(temp, @"缺少服务器多语言资源包");
////
////    if ([type integerValue] == 2) {
////        [MXCache setValue:@"NO" forKey:IS_AUTO_LOGIN];
////        [MXAlertViewHelper showAlertViewWithMessage:hint title:MXLang(@"Public_Sorry", @"抱歉") okTitle:MXLang(@"Public_Create_Company", @"创建公司") cancelTitle:MXLang(@"Public_I_Know",@"我知道了") completion:^(BOOL cancelled, NSInteger buttonIndex) {
////            if (buttonIndex == 1) {
////                [MXCache setValue:@"YES" forKey:IS_AUTO_LOGIN];
////            }
////
////        }];
////    }
////    else if ([type integerValue] == 8) {
////        [[NSNotificationCenter defaultCenter] postNotificationName:@"UsingCoinCertificateQrcode" object:sendMsgDic[@"couponId"]];
////    }
////    else if ([type integerValue] == 5) {
////        MXPushModel *pushMode=[MXPushModel new];
////        [pushMode setPropertyWithDictionary:sendMsgDic];
////        [self.class saveCachePushMsg:pushMode];
////        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushMessage" object:pushMode];
////    }else if ([type integerValue] == 7) { // 摇一摇在线推送
////
////        NSMutableArray *prizeArray = [MXCache valueForKey:kShakeGetShakedPrizeArray];
////        if (prizeArray==nil) {
////            prizeArray=[NSMutableArray array];
////        }
////        [prizeArray addObject:sendMsgDic[@"msg"]];
////
////        [MXCache setValue:prizeArray forKey:kShakeGetShakedPrizeArray];
////        [[NSNotificationCenter defaultCenter] postNotificationName:kShakeGetShakedPrizeNotification object:nil];
////
////    }else if([type integerValue] == 9){ // 挖矿游戏推线
////
////        [self showLocalNotification:sendMsgDic[@"msg"]];
////
////    } else if ([type integerValue] == 11) {
////        if (![StringUtil isEmpty:sendMsgDic[@"msg"]]) {
////            MXPushModel *pushMode=[MXPushModel new];
////            [pushMode setPropertyWithDictionary:sendMsgDic];
////            [self.class saveCachePushMsg:pushMode];
////            [[NSNotificationCenter defaultCenter]postNotificationName:@"PushMessage_Wallet" object:pushMode];
////        }
////    }
////    else if([type integerValue] == -2){
////       UIApplicationState state = [UIApplication sharedApplication].applicationState;
////        if (state == UIApplicationStateBackground) {
////            AppDelegate *appDelegate =App;
////            MainViewController *mainVC=appDelegate.mainVC;
////            [mainVC switchToChatList];
////        }
////    }
//}
//
//#pragma mark - 处理钱包转账
//- (void)handleWalletPush:(NSDictionary *)dict {
////    MXLog(@"____> 收到钱包推送______>", nil);
////    [MXCache setValue:@(YES) forKey:@"Wallet_Transfer"];
//}
//
////缓存推送消息
//+(void)saveCachePushMsg:(MXPushModel*)model{
//    if (model) {
//        [MXCache setValue:model forKey:[NSString stringWithFormat:@"PushMessage_%@_%@",@(model.t),AppUserModel.userId]];
//    }
//}
////删除推送消息
//+(void)deleteCachePushMsgWithType:(NSUInteger)type{
//    [MXCache removeValueForKey:[NSString stringWithFormat:@"PushMessage_%@_%@",@(type),AppUserModel.userId]];
//}
////读取缓存消息
//+(MXPushModel*)readCachePushMsgWithType:(NSUInteger)type{
//    return [MXCache valueForKey:[NSString stringWithFormat:@"PushMessage_%@_%@",@(type),AppUserModel.userId]];
//}
//
//- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
//    // [4-EXT]:发送上行消息结果反馈
//    NSString *record = [NSString stringWithFormat:@"Received sendmessage:%@ result:%d", messageId, result];
//    MLog(@"%@",record);
//}
//
//- (void)GeTuiSdkDidOccurError:(NSError *)error
//{
//    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
//    MLog(@"%@",[NSString stringWithFormat:@">>>[GexinSdk error]:%@", [error localizedDescription]]);
//}
//
////
////- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
////
////    // [EXT]:通知SDK运行状态
////
////    _sdkStatus = aStatus;
////
//////    [NotifyHelper showMessageWithMakeText:[NSString stringWithFormat:@"%d",aStatus]];
////}
//
//// 当离线推送时，更新badgeNum
//- (void)showNotificationWithMessage{
//
//    //发送通知
//    //    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//    UIApplication *application = [UIApplication sharedApplication];
//    NSInteger badgeNum = application.applicationIconBadgeNumber;
//    
//    
//    [application setApplicationIconBadgeNumber:badgeNum++];
//
//    
//}
//
//#pragma mark - 通知
//- (void)excuteToDealOffLineNotification:(NSNotification*)notification {
//    NSString *offLineType=[MXCache valueForKey:kOffLineMessageType];
//
//    if (![StringUtil isEmpty:offLineType]) {
//        // 魔聊离线推送
//        if ([offLineType intValue]==-1) {
//            AppDelegate *appDelegate = MoApp;
//            MainViewController *mainVC=appDelegate.mainVC;
//            
////            if (mainVC) {
////                [mainVC switchToChatList];
////                [MXCache setValue:@"-10000" forKey:kOffLineMessageType];
////            }
//        }
//    }
//}
//
//#pragma mark - 挖矿游戏推送
//- (void)showLocalNotification:(NSString*)msg {
//    
//    
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    notification.fireDate = [NSDate date];
//    
//    notification.alertBody = [NSString stringWithFormat:@"%@", msg];
//
//    notification.alertAction =MXLang(@"Public_aps_open", @"打开");
//    notification.timeZone = [NSTimeZone defaultTimeZone];
//    notification.soundName = UILocalNotificationDefaultSoundName;
//  
//    //发送通知
//    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//}

@end
