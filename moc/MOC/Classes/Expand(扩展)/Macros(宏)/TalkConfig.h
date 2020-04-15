//
//  TalkConfig.h
//  MoPal_Developer
//
//  Created by yuhx on 15/8/17.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#ifndef MoPal_Developer_TalkConfig_h
#define MoPal_Developer_TalkConfig_h

typedef enum: NSInteger
{
    Normal,
    Certificate,//兑换券
    Voucher//优惠券
}ForwardType;//券类型

// 刷新好友列表
#define kRefreshFriend @"refreshFriendNotification"
// 刷新群组聊天
#define kRefreshGroup @"refreshGroupNotification"
// 刷新商家关注
#define kRefreshMopromo @"refreshMopromoNotification"
// 刷新好友分组
#define kRefreshSplitGroup @"refreshSplitGroupNotification"
// 刷新聊天列表
#define kRefreshChatList @"refreshChatNotification"
// 从网络抓取好友列表
#define kRefreshFriendFromNet @"refreshNetFriendNotification"
#define kDelivery_state_request @"request"      // 客户端发送消息

#define kDelivery_state_acked @"acked"          // 服务器对客户端acked回执 （以发送）
#define kDelivery_state_received @"received"    // 收客户端发送received回执 （以接收）
#define kDelivery_state_read @"read"            // 接收客户端发送delivery回执 （已读）
#define KDelivery_state_nomal @"request"

#define KDelivery_state_destroy @"destroy"
#define KDelivery_state_sgroup @"sgroup"
#define KDelivery_state_s @"s"
#define KDelivery_state_rich @"rich"
#define KDelivery_state_group @"groupchat"

// 扩展标签
#define kExternXmlTag @"mx"
#define KExternXmlMessageTag @"message"
#define KExternaXmlErrorTag @"error"

typedef NS_ENUM(NSInteger,MXChatBarMoreItemType) {
    MXChatBarMoreItemTypeAblum = 1,   // 相册
    MXChatBarMoreItemTypeCamera,      // 拍照
    MXChatBarMoreItemTypeLocation,    // 位置
    MXChatBarMoreItemTypeRedPackage,  // 发红包
    MXChatBarMoreItemTypeContact      // 名片
};

/*************************************************聊天begin***************************************************************/
#define talk_upload_file MOXIAN_URL_STR_NEW(@"file",@"/mo_common_fileuploadservice/m2/upload")

#define talk_group_list MOXIAN_URL_STR_NEW(@"talk",@"/mo_talk/m2/chatrooms")

#define talk_group_participants MOXIAN_URL_STR_NEW(@"talk",@"/mo_talk/m2/chatrooms/%@/participants")

#define talk_group_exit MOXIAN_URL_STR_NEW(@"talk",@"/mo_talk/m2/chatrooms/%@")

//#define talk_group_add_member MOXIAN_URL_STR_NEW(@"talk",@"/mo_talk/m2/chatrooms/%@/participants")

#define talk_group_delete_member MOXIAN_URL_STR_NEW(@"talk",@"/mo_talk/m2/chatrooms/%@/participant")

#define talk_group_update_nickname MOXIAN_URL_STR_NEW(@"talk",@"/mo_talk/m2/chatrooms/%@/participant")
//修改我在群的属性
//#define talk_group_update_group_attribute MOXIAN_URL_STR_NEW(@"talk",@"/mo_talk/m2/chatrooms/%@/participants")


#define talk_group_create MOXIAN_URL_STR_NEW(@"talk",@"/mo_talk/m2/chatrooms")

#define talk_group_detail MOXIAN_URL_STR_NEW(@"talk",@"/mo_talk/m2/chatrooms/%@")

#define talk_group_member_operate MOXIAN_URL_STR_NEW(@"talk",@"/mo_talk/m2/chatrooms/%@/%@/%@")
#define talk_group_update_info MOXIAN_URL_STR_NEW(@"talk",@"/mo_talk/m2/chatrooms/%@")

#define talk_group_set_creater MOXIAN_URL_STR_NEW(@"talk",@"/mo_talk/m2/chatrooms/%@/admin")

#define talk_group_reset_qrcode MOXIAN_URL_STR_NEW(@"talk",@"/mo_talk/m2/chatrooms/%@/qrcode")

#define talk_group_invite_link  MOXIAN_URL_STR_NEW(@"talk",@"/mo_talk/m2/chatrooms/%@/link")

#define talk_group_report MOXIAN_URL_STR_NEW(@"talk",@"/mo_talk/m2/chatrooms/%@/report")
#define talk_server_time MOXIAN_URL_STR_NEW(@"setting",@"/mo_common_appsetting/m2/servertime")
/************************************************* 聊天end*****************************************************************/


/*************************************************魔友begin***************************************************************/
#define friend_getList MOXIAN_URL_STR(@"/mx-api/api/mgt/connections/users")

//关于群组的操作
#define group_createOrdelete MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/group")

//好友列表
#define haoyoulist  MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/friend")

//修改备注
#define changeRemark MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/friend/note")

//获取粉丝列表
#define fansList MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/friend/{uid}/fans?page={page}&size={size}")

//获取关注列表
#define attentionList MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/friend/my/users?page={page}&size={size}")

//获取好友粉丝列表
#define friendfansList MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/friend/{uid}/fans?page={page}&size={size}")

//获取好友关注列表
#define friendattentionList MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/friend/{uid}/users?page={page}&size={size}")

//获取附件的人
#define nearbyPeople MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/friend/nearby/people")

#define phonePeople MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/friend/phones")

#define GrabsShopPoint MOXIAN_URL_STR_NEW(@"mobiz",@"/mo_biz/m2/shop/nomerchant/grabs")

//举报好友
#define reportFriend MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/info")
//获取举报类型 新接口 --> http://pal.devm2.moxian.com:80/mo_pal/m2/info/options
#define reportType MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/info/options")
//加入黑名单
#define addInBlackList MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/friend/black")
//精确搜索
#define searchmoment MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/friend/users")
//获取关注商家列表
#define getAttentionShopList MOXIAN_URL_STR_NEW(@"fans",@"/mo_fans/m2/shopfans/getallfollowshops")

// 获取好友详情
#define get_friend_details MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/friend")

// 关注
#define AddFiendUrl MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/friend/{ID}")

// 添加成员
#define AddFriendsToMultipleUrl  MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/group/friends/multiple")
// 查询好友已添加的组
#define FriendGroupsUrl  MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/group/{fid}/groups")
//保存位置
#define NearbyFansLocation MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/friend/location")

#define GetFriendRelationShipUrl MOXIAN_URL_STR_NEW(@"pal",@"/mo_pal/m2/friend/relationship/{uid}")

// 获取表情下载列表
#define talk_get_gif_url MOXIAN_URL_STR_NEW(@"file",@"/mo_common_fileuploadservice/m2/image/getImagePacketList")

/*************************************************魔友end*****************************************************************/


#endif
