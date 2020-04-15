//
//  GetFriendsManager.h
//  MoPal_Developer
//
//  Created by GreenTreeInn on 15/4/15.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MXRequest.h"
//#import "GetFriends.h"
//#import "DelFans.h"
//#import "AddFans.h"
//#import "SearchMoment.h"
//#import "NearFriends.h"
//#import "PhoneFriends.h"
//#import "ChangeRemark.h"
//#import "AddGroups.h"
//#import "DeleteGroup.h"
//#import "changeGroupName.h"
//#import "selectFriendByGroup.h"
//#import "GroupList.h"
//#import "addFriendInGroup.h"
//#import "deleteFriendInGroup.h"
//#import "FriendWithOutGroup.h"
//#import "FriendModel.h"
//#import "ReportFriend.h"
//#import "AddBlackList.h"
//#import "GroupModel.h"
//#import "GroupListModel.h"
//#import "GroupFriendModel.h"
//#import "BlackList.h"
//#import "DeleteBlack.h"
//#import "FansLocationApi.h"
#import "MXRequest.h"

@interface FriendsManager : NSObject

// 获取好友列表
+ (MXRequest *)getFriendList:(NSDictionary*) param completion:(MXHttpRequestListCallBack)completion;

// 查询好友
+ (MXRequest *)searchFriendList:(NSString*) param completion:(MXHttpRequestListCallBack)completion;

//上传通讯录
+ (MXRequest *)moblieImportBook:(NSMutableArray*) param completion:(MXHttpRequestListCallBack)completion;

////得到好友验证信息
//+ (MXRequest *)getFriendMessage:(NSDictionary*) param completion:(MXHttpRequestListCallBack)completion ;

// 添加好友
+ (MXRequest *)addFriend:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;

// 删除好友
+ (MXRequest *)delFriend:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;

//发送好友验证信息接口
+ (MXRequest *)sendVerifyMsg:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;

// 修改好友备注
//+ (MXRequest *)setNoteName:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;

// 投诉 色情 2，欺诈3，广告骚扰
//敏感信息 5，侵权 6，赌博
//7，其他

+ (MXRequest *)complain:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;


+ (MXRequest *)getRemoveFriendInfo:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;

+ (MXRequest *)removeManyFriend:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack)completion;
//
//// 获取附近的人
//+ (MXRequest *)getNearByList:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion;
//
//// 获取通讯录好友列表
//+ (MXRequest *)getPhoneByList:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion;
//
//// 创建群组
//+ (MXRequest *)addGroup:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion;
//
//// 删除群组
//+ (MXRequest *)removeGroup:(NSDictionary *)param completion:(MXHttpRequestCallBack)completion;
//
//// 编辑群名
//+ (MXRequest *)changeGroupName:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion;
//
//// 查询组好友列表
//+ (MXRequest *)selectFriendWithGroup:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion;
//
//// 添加成员
//+ (MXRequest *)addFriendInGroup:(NSDictionary *)param completion:(MXHttpRequestCallBack)completion;
//
//// 删除成员
//+ (MXRequest *)removeFriendInGroup:(NSDictionary *)param completion:(MXHttpRequestCallBack)completion;
//
// 群组列表
//+ (MXRequest *)groupList:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion;
//
////抓取好友分组
//+ (void)fetchFriendGroups;
//
//// 未分组好友
//+ (MXRequest *)notinGroupWithFriend:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion;
//
//// 举报好友
//+ (MXRequest *)reportFriends:(NSDictionary *)param completion:(MXHttpRequestCallBack)completion;
//
//// 加入黑名单
//+ (MXRequest *)addBlackList:(NSDictionary *)param completion:(MXHttpRequestCallBack)completion;
//
//// 获取黑名单
//+ (MXRequest *)getBlackList:(NSDictionary *)param completion:(MXHttpRequestListCallBack)completion;
//
//// 删除黑名单
//+ (MXRequest *)deleteBlackList:(NSDictionary *)param completion:(MXHttpRequestCallBack)completion;
//
//+(NSMutableArray*)searchFriendByKeyword:(NSString*)keyword source:(NSMutableArray*) datasource;
//
//
////+(NSMutableArray*)chatRecordByKeyword:(NSString*)keyword source:(NSMutableArray*) datasource;
//
//
//// 获取好友详情
//+ (MXRequest*)fetchMopalDetailInfosWithUsersId:(NSString*)userId completion:(MXHttpRequestListCallBack)completion;
//
//// 关注用户
////+ (MXRequest *)addFriend:(NSString*)followID completion:(MXHttpRequestCallBack)completion;
//
//+ (MXRequest *)addFriend:(MoYouModel*)moyou completion:(MXHttpRequestCallBack)completion;
//
//// 获取举报类型
//+ (MXRequest *)fetchReportOption:(MXHttpRequestListCallBack)completion;
//// 添加成员到多个组
//+ (MXRequest *)addFriendsToMultipleGroups:(NSDictionary*)param completion:(MXHttpRequestCallBack)completion;
//// 查询好友已添加的组
//+ (MXRequest *)fetchFriendGroups:(NSDictionary*)param completion:(MXHttpRequestListCallBack) completion;
////关注商铺的模糊查询接口
//+ (MXRequest*)searchShopByName:(NSDictionary*)param completion:(MXHttpRequestListCallBack) completion;
////保存位置
//+ (MXRequest*)saveFansLocation:(NSDictionary*)param completion:(MXHttpRequestCallBack) completion;
//
////获取好友关系
//+ (MXRequest*)getFriendRelation:(NSDictionary*)param completion:(MXHttpRequestObjectCallBack) completion;
//
////根据字符串返回状态
//+(MoRelationshipType)getShipStateByString:(NSString*)relation;
//
////扫描送积分查询信息
//+ (MXRequest*)grabsShopPoint:(MXHttpRequestObjectCallBack)completion;

@end
