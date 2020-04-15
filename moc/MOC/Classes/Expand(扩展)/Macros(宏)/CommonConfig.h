//
//  CommonConfig.h
//  MoPal_Developer
//
//  Created by 王 刚 on 14/12/29.
//  Copyright (c) 2014年 MoXian. All rights reserved.

#ifndef MoPal_Developer_CommonConfig_h
#define MoPal_Developer_CommonConfig_h

//#import "TalkConfig.h"
//#import "EnumDefine.h"
//#import "MXNotificationKey.h"
//#import "MXBannerKey.h"
#import "MXThirdPlatformKey.h"
#import "MXUIDefine.h"
#import "MXDeviceDefine.h"
#import "AppDelegate.h"
#import "DeviceManager.h"

///指定图片尺寸
#define AssignSize(url,w,h) [NSString stringWithFormat:@"%@?imageView2/1/w/%d/h/%d",url,((int)(w*[[UIScreen mainScreen] scale])),((int)(h*[[UIScreen mainScreen] scale]))]

///视屏第一帧截图
#define VideoScreenshot(url,w,h) [NSString stringWithFormat:@"%@?vframe/jpg/offset/0/w/%d/h/%d",url,((int)(w*[[UIScreen mainScreen] scale])),((int)(h*[[UIScreen mainScreen] scale]))]
#define VideoFirstScreenShot(url) [NSString stringWithFormat:@"%@?vframe/jpg/offset/0",url]

#ifdef Open_Log_Debug
    #define MLog(fmt, ...)      NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
    #define NSLog(fmt, ...)
    #define MLog(fmt, ...)
#endif

// add by yang.xiangbao
#define weakify(var) \
autoreleasepool {} \
__weak __typeof__(var) var ## _weak = var;

#define strongify(var) \
autoreleasepool {} \
__strong __typeof__(var) var = var ## _weak;
// the end


#define ALPHA	@"#ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define ALPHA2    @"ABCDEFGHIJKLMNOPQRSTUVWXYZ#"
#define ALPHA3    @"ABCDEFGHIJKLMNOPQRSTUVWXYZ#未"
#define SEND_SMS_TIME 60 // 发送短信间隔时间:秒


#define MXLang(key,comment) comment//[[LanguageManager sharedManager] localizedStringForKey:(key) withComment:(comment)]

#define MoApp ((AppDelegate *)[UIApplication sharedApplication].delegate)

//#define UserKey @"userKey"

//从服务器请求的当前时间
#define CurrentTimeCache   @"currentTime"
#define AppCurrentTime     [MXCache valueForKey:CurrentTimeCache]

// 当前国家的countryCode,如中国86等
#define AppCurrentCountryCode [MXCache valueForKey:@"CountryCode"]

// 消息提醒开关
#define AppMessageUnreadNotificationKey @"acceptUnreadMsgNotification"
#define AppMessageUnreadNotificationState [MXCache valueForKey:AppMessageUnreadNotificationKey]

// 用户授权列表
#define User_AuthListCache [NSString stringWithFormat:@"%@/authListCache.plist",[DocumentManager cacheDocDirectory]]

#define kMY_USER_ID @"myMotalkUserId"
#define kMY_USER_PASSWORD @"myMotalkUserPassword"
#define kMY_USER_NICKNAME @"myMotalkUserNickname"
#define kMY_USER_Head @"myMotalkUserHead"
#define kMY_USER_LoginName @"myMotalkUserLoginName"


#define kXMPPmyJID @"myMotalkXmppJid"
#define kXMPPmyPassword @"myMotalkXmppPassword"
#define kXMPPNewMsgNotifaction @"xmppNewMsgNotifaction" // 新消息通知
#define kXMPPMotalkOnlineNotifaction @"motalkOnlineNotifaction" // motalk在线通知,
#define kXMPPMotalkOfflineNotifaction @"motalkOfflineNotifaction" // motalk下线通知,
#define kMXBackButtonNavigationBarTag 10000000
#define MY_USER_ID [[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]

#define TestMotalkPort [[MXNetworkConfig sharedInstance] getMotalkPort]

#define TestMotalkHost [[MXNetworkConfig sharedInstance] getMotalkServer]
#define TestMotalkHost1 [[MXNetworkConfig sharedInstance] getMotalkDomain]

#define APPSHORTVERSION   [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define APPBUILDVERSION   [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

//#import "MXChatHeaders.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(1.0f)]
#define HexColor(hex) [UIColor colorWithHexString:hex]

//下线
#define KNOTIFICATION_LOGINCHANGE_Kick_Off @"Kick_Off"  //同帐号登录不同手机踢下线
#define KNOTIFICATION_LOGINCHANGE_Block_Kick_Off @"Block_Kick_Off" //冻结踢下线

#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"
#define TABBARNOTIFICATIONCENTER(SELECTOR) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SELECTOR) name:@"tabbarNotification" object:nil]
#define REMOVETABBARNOTIFICATIONCENTER  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tabbarNotification" object:nil]

#define ADD_DESTROYMSG_NOTIFICATION(SELECTOR) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SELECTOR) name:@"destroyMessage" object:nil]

#define REMOVE_DESTROYMSG_NOTIFICATION [[NSNotificationCenter defaultCenter] removeObserver:self name:@"destroyMessage" object:nil]

// 用户对象model
#define AppUserModel (MoApp.currentAppUserInfosModel)

//状态栏rect
#define Status_Height [[UIApplication sharedApplication] statusBarFrame].size.height
//navigationBarHeight
#define NavigationBar_Width  [[MXRouter sharedInstance] getTopNavigationController].navigationBar.width
#define NavigationBar_Height [[MXRouter sharedInstance] getTopNavigationController].navigationBar.height
#define NavigationBar_Bottom ([[MXRouter sharedInstance] getTopNavigationController].navigationBar.height + Status_Height)
#define TabbarHeight [[MXRouter sharedInstance] tabbarHeight]
//聊天表情大小
#define ChatFaceSize 18
#define BUBBLE_LEFT_IMAGE_NAME @"Motalk_message_bg_other" // bubbleView 的背景图片
#define BUBBLE_RIGHT_IMAGE_NAME @"Motalk_message_bg_self"

// 聊天设置免打扰
static const NSString *kNotDisturb = @"NotDisturb";



#define IS_AUTO_LOGIN @"isAutoLogin"

// 全局免打扰设置
//声音
#define kGlobalNotSoundDisturb     @"GlobalNotSoundDisturb"
//震动
#define kGlobalNotVibrationDisturb @"GlobalNotVibrationDisturb"

//是否开启免打扰
#define kGlobalAvoidTimeDisturb    @"GlobalAvoidTimeDisturb"
//免打扰开始时间
#define kGlobalStartTimeDisturb    @"GlobalStartTimeDisturb"
//免打扰结束时间
#define kGlobalEndTimeDisturb      @"GlobalEndTimeDisturb"

#define kFirstRunAppToEnableSoundAndVibration @"FirstRunAppToEnableSoundAndVibration"


#define AddChangeLanguageNotificationCenter(SELECTOR) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SELECTOR) name:@"changeLanguageNotification" object:nil]



//#define iPhone6Plus  [DeviceManager deviceType]==MXDeviceScreenIphone6Plus
// App 类型
static const NSString *appType = @"lcwl";

#define kLocationDidUpdateFailer @"kLocationDidUpdateFailer"



#define ChatDestroyShow @"DestroyShow"
#define ChatDestroyConfirm @"DestroyConfirm"
#define ChatDestroyFirstTip @"DestroyFirst"
#define ChatFocusFirstTip @"FocusFirst"
//#import "PlaceHolderImageManager.h"
#import "MKBlockAdditions.h"

//话题的placeholder图片
#define kTopicPlaceHolderImg   @""
#define kPersonCenterHolderImg @""

//红包ID  刷新附近红包列表
#define kRedPacketIDKey @"redPacketID"

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#undef  AS_STATIC_PROPERTY
#define AS_STATIC_PROPERTY( __name ) \
- (NSString *)__name; \
+ (NSString *)__name;


#undef  DEF_STATIC_PROPERTY
#define DEF_STATIC_PROPERTY( __name ) \
- (NSString *)__name \
{ \
return (NSString *)[[self class] __name]; \
} \
+ (NSString *)__name \
{ \
return [NSString stringWithFormat:@"%s", #__name]; \
}

#undef  DEF_STATIC_CGFloat
#define DEF_STATIC_CGFloat( __name, __value ) \
- (CGFloat)__name \
{ \
return [[self class] __name]; \
} \
+ (CGFloat)__name \
{ \
return __value; \
}

#endif




