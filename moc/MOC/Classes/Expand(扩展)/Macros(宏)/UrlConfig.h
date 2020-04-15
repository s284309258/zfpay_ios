//
//  UrlConfig.h
//  MoPromo
//
//  Created by litiankun on 14-7-17.
//  Copyright (c) 2014年 MOPromo. All rights reserved.
//

#import "StringUtil.h"
#import "MXNetworkConfig.h"

#ifndef MoPromo_UrlConfig_h
#define MoPromo_UrlConfig_h

// 谷歌服务开发api
#define GOOGLE_AUTOCOMPLETE_PLACES @"https://maps.googleapis.com/maps/m1/place/autocomplete/json"
#define GOOGLE_PLACES_DETAILS @"https://maps.googleapis.com/maps/m1/place/details/json"
#define SERVER_ROOT [[MXNetworkConfig sharedInstance] getBaseRoot]

#define MOXIAN_URL_STR(PATH_) [NSString stringWithFormat:@"%@%@",SERVER_ROOT,PATH_]

#define MX_HTTP_URL_FORMAT(PREFIX_,PATH_) [NSString stringWithFormat:@"http://%@%@%@",PREFIX_,SERVER_ROOT,PATH_]

#define MOXIAN_URL_STR_NEW(PREFIX_,PATH_)   [NSString stringWithFormat:@"%@://%@%@%@",MX_OPTIONAL_HTTPPROXY,PREFIX_,SERVER_ROOT,PATH_]

//add by yangjiale
#define MOXIAN_URL_HTTPS(PREFIX_,PATH_) [NSString stringWithFormat:@"%@://%@%@%@",MX_REQUIRED_HTTPPROXY,PREFIX_,SERVER_ROOT,PATH_]
//end

//定义domain
#define MOXIAN_DOMAIN  [[MXNetworkConfig sharedInstance] getMotalkDomain]


#define MerchantKey [[MXNetworkConfig sharedInstance] merchantKey]

// 登录前缀
#define MOXIAN_LOGIN_PREX [[MXNetworkConfig sharedInstance] getLoginPrexDomain]

//返回值为必须为https(在OPENHTTPS下)
#define MX_REQUIRED_HTTPPROXY  [[MXNetworkConfig sharedInstance] getRequiredHttpsProxy]

//返回值为http或者https(在OPENHTTPS下)
#define MX_OPTIONAL_HTTPPROXY  [[MXNetworkConfig sharedInstance] getOptionalHttpsProxy]


//暂时解决陌生人没有头像的问题
#define MOXIAN_STRANGER(_ID) [NSString stringWithFormat:@"chatwith%@",_ID]

/*************************************************用户中心begin************************************************************/

// 收货地址
#define personal_center_get_shippingaddress_list MOXIAN_URL_STR_NEW(@"moxian",@"/mo_moxian/m2/deliveryaddress")

// 获取我的标签
#define personal_center_get_usertags_list MOXIAN_URL_STR_NEW(@"moxian",@"/mo_moxian/m2/userprofile/systemtagsinfo")

// 用户相关消息编辑
#define personal_center_edit_userinfos MOXIAN_URL_STR_NEW(@"moxian",@"/mo_moxian/m2/userprofile/baseinfo")

// 用户个人信息详细
#define personal_center_userinfos_details MOXIAN_URL_STR_NEW(@"moxian",@"/mo_moxian/m2/userprofile")

// 上传用户头像
#define personal_center_userinfos_uploadavatar MOXIAN_URL_STR_NEW(@"moxian",@"/mo_moxian/m2/avatar/uploadavatar")

// 设置用户默认头像
#define personal_center_userinfos_set_user_default_avatar MOXIAN_URL_STR_NEW(@"moxian",@"/mo_moxian/m2/avatar/setavatar")

// 删除用户头像
#define personal_center_userinfos_set_user_delete_avatar MOXIAN_URL_STR_NEW(@"moxian",@"/mo_moxian/m2/avatar/delete")

/*************************************************用户中心begin************************************************************/

///*************************************************设置begin***************************************************************/

// 设置消息提醒/获取消息提醒详情
#define personal_center_setting_message_setremind MOXIAN_URL_STR_NEW(@"push",@"/mo_common_push/m2/messageremind")
// 亮点功能
#define personal_center_setting_abutus_updateinfos MOXIAN_URL_STR_NEW(@"comment",@"/mo_comment/m2/versionintroduce")

// 第三方授权信息
#define personal_center_setting_thirdparty_permissions MOXIAN_URL_STR(@"/mo_common_user/m2/thirdParty")
//版本更新（登录后检测
//#define personal_center_setting_new_permissions MOXIAN_URL_STR_NEW(@"setting",@"/mo_common_appsetting/m2/merchantsetting/getnewversion")
#define personal_center_setting_new_permissions MOXIAN_URL_STR_NEW(@"setting",@"/mo_common_appsetting/m2/merchantsetting/norestfilter/checkversion")

/*************************************************设置end*****************************************************************/


/*************************************************逛逛end*****************************************************************/
/** 获取Banner广告 */
#define banner_getList MOXIAN_URL_STR_NEW(@"ad",@"/mo_ad/m2/ad/banners")
#define banner_visitAd MOXIAN_URL_STR_NEW(@"ad",@"/mo_ad/m2/ad/visits")

//推荐活动
#define shop_getActivity MOXIAN_URL_STR_NEW(@"ad",@"/mo_ad/m2/ad/activities")
//推荐行业分类
#define shop_recommendModule MOXIAN_URL_STR_NEW(@"mobiz",@"/mo_biz/m2/shop/nomerchant/getFecommendShops")
//推荐活动分类
#define shop_getCategory MOXIAN_URL_STR_NEW(@"mobiz",@"/mo_biz/m2/industryCategory/nomerchant/recommendcategory")
//推荐商家
#define shop_recommendMerchant MOXIAN_URL_STR_NEW(@"mobiz",@"/mo_biz/m2/shop/nomerchant/getFecommendShops")

//关注列表
#define hotGoods_getList MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/mallattentionresource/nomerchant")
//店铺动态点赞
#define upVoteTrend_url MOXIAN_URL_STR_NEW(@"moment",@"/mo_moment/api/post/star")
//店铺动态取消点赞
#define cancelUpVoteTrend_url MOXIAN_URL_STR_NEW(@"moment",@"/mo_moment/api/post/unstar")
//获取逛街发现模块列表
#define findGoods_getList MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/mallfoundresource/nomerchant")
//商品详情
#define shopDetail MOXIAN_URL_STR(@"/mo_goods/m2/shopgoods/getShopGoodsById")
//Banner广告
#define shop_getBanner  MOXIAN_URL_STR_NEW(@"ad",@"/mo_ad/m2/ad/banners")
//(商城)查询产品详情
#define shop_GoodsDetail MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/shopgoodsdisplay/nomerchant/getshopgoodsdetailbyid")
//店铺动态详情
#define shop_TrendDetail MOXIAN_URL_STR_NEW(@"moment",@"/mo_shop_moment/m2/post")
//店铺推荐商品
#define shop_recommandGoods MOXIAN_URL_STR_NEW(@"mobiz",@"/mo_biz/m2/shop/nomerchant/getrecommendgoods")
//新版本优惠券详情
#define newCouponDetail MOXIAN_URL_STR_NEW(@"order",@"/mo_order/m2/cardbag/couponDetail")
//新版兑换券详情
#define card_newCoinDetail_url MOXIAN_URL_STR_NEW(@"order", @"/mo_order/m2/cardbag/exchangeCouponDetail/")

//关注店铺
#define payAttention_Shop MOXIAN_URL_STR_NEW(@"fans",@"/mo_fans/m2/shopfans/shop/follow")

//商品浏览量+1
#define goodsBrowse_addOne MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/shopgoodsdynamic/nomerchant/shopgoodsdynamic/addvisitcnt")

//商品收藏量+1
#define goodsCollect_addOne MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/shopgoodsdynamic/nomerchant/shopgoodsdynamic/addcollectioncnt")
//商品收藏量-1
#define goodsCollect_subOne MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/shopgoodsdynamic/nomerchant/shopgoodsdynamic/reducecollectioncnt")
/*************************************************逛逛end*****************************************************************/

//分类根据条件（分类，城市，距离等）获取优惠券接口
#define Coupon_List MOXIAN_URL_STR(@"")

//优惠劵搜索接口
#define Search_Coupon MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/nomerchant/goodssearch/coupon")

//搜索店铺所有商品列表（商品、优惠劵两类）
#define Search_Shop_CouponList MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/shopgoodsdisplay/nomerchant/getshopgoodsdisplaylist")

//请求商品详情url
#define Goods_Detail MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/shopgoods/shops/%@/goods/%@")

//领取商品详情url
#define Goods_PickUp MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/shopCoupon/nomerchant/savecoupon")


//立即使用优惠劵url
#define Goods_ImmediatelyUse MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/shopCoupon/nomerchant/usecoupon")

//获取开放城市列表
#define shop_getopencity MOXIAN_URL_STR_NEW(@"ad",@"/mo_ad/m2/locations/cities")


// 获取全部分类
#define industryCategory_allcategory MOXIAN_URL_STR_NEW(@"mobiz",@"/mo_biz/m2/industryCategory/nomerchant/allcategory")

// 商品热门关键字
#define shop_hotKeywords MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/nomerchant/hotkeywords")

// 分类商品总数
#define shop_category_filter MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/nomerchant/goodssearch/category")

// 分类商品总数
#define shop_category_location MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/nomerchant/goodssearch/location")

// 分搜索筛选商品
#define shop_goods_search MOXIAN_URL_STR_NEW(@"search",@"/mo_search/m1/search/prefixAggregation")

// 商城关键字搜索
#define shop_goods_keyword_search MOXIAN_URL_STR_NEW(@"search",@"/mo_search/m1/search/common")

/************************** 推送 ******************************************/
// 发送个推客户端ID到服务器
#define push_cid  MOXIAN_URL_STR_NEW(@"push",@"/mo_common_push/m2/push/cid")
// 解绑个推ID
#define unBind_push_cid MOXIAN_URL_STR_NEW(@"push",@"/mo_common_push/m2/push/unbindcid")
/************************** 推送 end ******************************************/

/************************** 商店首页 ******************************************/
// 关于商铺
#define about_shop MOXIAN_URL_STR_NEW(@"mobiz",@"/mo_biz/m2/shop/nomerchant/shopHomePage")
// 全部门店
#define all_shop MOXIAN_URL_STR_NEW(@"mobiz",@"/mo_biz/m2/shop/nomerchant/getShopsByShopId")
// 通用门店
#define common_shop MOXIAN_URL_STR_NEW(@"mobiz",@"/mo_biz/m2/shop/nomerchant/searchShopsByGoods")
// 商铺里的优惠劵列表和商品列表
#define shop_coupon_list MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/shopgoods/nomerchant/homepage/shops/%@")
// 商铺动态信息
#define shop_dynamic MOXIAN_URL_STR(@"/mo_moment/m2/dynamic/getShopDynamics")
// 查询商铺详情
#define shop_info MOXIAN_URL_STR_NEW(@"mobiz",@"/mo_biz/m2/shop/nomerchant/shopHomePage")
//取消关注店铺
#define releasePayAttention_Shop MOXIAN_URL_STR_NEW(@"fans",@"/mo_fans/m2/shopfans/unfollowshop")
//关注商铺的模糊查询接口
#define shop_searchByName MOXIAN_URL_STR_NEW(@"fans",@"/mo_fans/m2/fansShop/nomerchant/searchShopByName")
// 商铺动态列表
#define shop_dynamic_list_url MOXIAN_URL_STR_NEW(@"moment",@"/mo_moment/api/post/getPostListByShopId")
#define dynamic_detail_url MOXIAN_URL_STR_NEW(@"moment",@"/mo_moment/api/post/getPostById")


/************************** 商店首页 End ******************************************/

// 多文件上传
#define upload_files_url MOXIAN_URL_STR_NEW(@"file", @"/mo_common_fileuploadservice/m2/upload/uploadFiles")

/**************** 圈子 Start *******************************/
// 动态消息提醒
#define dynamic_new_message MOXIAN_URL_STR_NEW(@"moment", @"/mo_moment/api/postinfo")
// 查询喜欢的人
#define dynamic_like_persons MOXIAN_URL_STR_NEW(@"moment", @"/mo_moment/api/moment/star/{ID}")
// 发动态
#define write_dynamic MOXIAN_URL_STR_NEW(@"moment", @"/mo_moment/api/moment")

//删除动态
#define delete_dynamic MOXIAN_URL_STR_NEW(@"moment", @"/mo_moment/api/moment/{ID}")

// 魔信关注列表
#define MoFollowList MOXIAN_URL_STR_NEW(@"moment", @"/mo_moment/api/moment")
// 附近动态
#define MoNearbyFollowList MOXIAN_URL_STR_NEW(@"moment", @"/mo_moment/api/moment/nearby?begin={begin}&end={end}")
// 魔信点赞
#define MoMessageLike MOXIAN_URL_STR_NEW(@"moment", @"/mo_moment/api/moment/{ID}/star")
// 魔信取消点赞
#define MoMessageUnLike MOXIAN_URL_STR_NEW(@"moment", @"/mo_moment/api/moment/{ID}/unstar")
// 魔信动态收藏
#define mo_favorite_url MOXIAN_URL_STR_NEW(@"moment", @"/mo_moment/api/hobbies")
// 魔信动态取消收藏
#define mo_cancle_favorite_url MOXIAN_URL_STR_NEW(@"moment", @"/mo_moment/api/hobbies/")
// 魔信动态举报
#define mo_report_url MOXIAN_URL_STR_NEW(@"moment", @"/mo_moment/api/info") //@"http://dev2.moxian.com/mo_moment/api/info"

//  写魔信动态评论
#define mo_send_comment_url MOXIAN_URL_STR_NEW(@"moment", @"/mo_moment/api/article")
// 魔信关注全部评论列表
#define all_comments MOXIAN_URL_STR_NEW(@"moment", @"/mo_moment/api/article/{ID}")
// 屏蔽魔信
#define mo_ignore_dynamic_url MOXIAN_URL_STR_NEW(@"moment", @"/mo_moment/api/moment/{ID}/ignore")

// 魔信动态收藏列表
#define mo_favorite_list MOXIAN_URL_STR_NEW(@"moment", @"/mo_moment/api/hobbies?begin={begin}&end={end}")

// 商品收藏列表
#define mo_favoGoods_list MOXIAN_URL_STR_NEW(@"goods", @"/mo_goods/m2/favoritegoods/nomerchant?pageIndex=%d")
/**************** end *************************************/


/******************************卡包start******************************/
//优惠券兑换券列表
#define card_certificateList_url MOXIAN_URL_STR_NEW(@"order", @"/mo_order/m2/cardbag/%@")
//兑换券猜你喜欢
#define card_coinLikeList_url MOXIAN_URL_STR_NEW(@"order", @"/mo_order/m2/cardbag/likeExchangeCoupon")
//优惠券猜你喜欢
#define card_couponLikeList_url MOXIAN_URL_STR_NEW(@"order", @"/mo_order/m2/cardbag/likeCoupon")
//卡包流水列表
#define card_cardRecordList_url MOXIAN_URL_STR_NEW(@"order", @"/mo_order/m2/cardbag/cardbagWater")
//兑换券详情
#define card_coinDetail_url MOXIAN_URL_STR_NEW(@"order", @"/mo_order/m2/cardbag/exchangeCouponDetail")
//礼品券详情
#define card_gift_url MOXIAN_URL_STR_NEW(@"order", @"/mo_order/m2/cardbag/giftCouponDetail")
//赠送券
#define card_sendCertificate_url MOXIAN_URL_STR_NEW(@"order", @"/mo_order/m2/cardbag/coupon?accepterId=%@&couponId=%@")
//更新优惠券信息为使用状态
#define card_updateGoodsCoupon_url MOXIAN_URL_STR_NEW(@"order", @"/mo_order/m2/cardbag/updateGoodsCoupon")
//更新礼品券信息为使用状态
#define card_updateGoodsGift_url MOXIAN_URL_STR_NEW(@"order", @"/mo_order/m2/cardbag/goodsCoupon")
//检查优惠券是否被使用
#define check_coupon_status MOXIAN_URL_STR_NEW(@"goods", @"/mo_goods/m2/shopCoupon/nomerchant/checkCouponStatus")
/******************************卡包end********************************/

/******************************活动start********************/
//活动首页列表
#define activity_homeList_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitybase/nomerchant/activities/home")
//活动类型
#define activity_type_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitytype/nomerchant")
#define activity_newActivity_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activityaddress/nomerchant/shop/%@/activity")
//活动信息
#define activity_info_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitybase/nomerchant/activityinfo/%@")
//活动详情
#define activity_detail_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitybase/nomerchant/activitydetail/%@")
//活动报名
#define activity_signUp_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activityjoin/nomerchant")
//取消报名
#define activity_cancel_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activityjoin/nomerchant")
//活动评论
#define activity_comment_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitycomment/nomerchant/commentaries")
//发表评论
#define activity_postComment_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitycomment/nomerchant")
//查询是否存在附近红包
#define check_neayby_redpacket_url MOXIAN_URL_STR_NEW(@"mobiz",@"/mo_biz/m2/nomerchant/nears/checks/gifts")
//发表评论
#define activity_create_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitybase/nomerchant")
//活动统计信息量
#define activity_totalCount_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitycount/nomerchant")
//我参与的活动
#define activity_join_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitybase/nomerchant/activities/alljoined")
//我发布的活动
#define activity_publish_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitybase/nomerchant/activities/allpublished")
//举报活动
#define activity_report_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activityreport/nomerchant")
//结束活动
#define activity_end_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitybase/nomerchant/ending")
//二维码扫描活动详情
#define activity_QRCode_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitybase/nomerchant/activity/%@")
//编辑活动
#define activity_edit_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitybase/nomerchant")
//活动搜索
#define activity_search_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitybase/nomerchant/activities/bytheme")
//活动店铺
#define activity_shop_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activityaddress/nomerchant/activityshops/%@")
//报名人数
#define activity_signPerson_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activityjoin/nomerchant/activity/alljoins")
//专题
#define activity_theme_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitysubject/nomerchant/%@")

//店铺所有活动
#define activity_shopAllActivity_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activityaddress/nomerchant/shop/%@/activities")

//摇一摇获奖名单
#define activity_lotterList_url MOXIAN_URL_STR_NEW(@"activities",@"/mo_activities/m2/activitylottery/nomerchant")
/**************** end *************************************/

/***********************订单 start ***************************/
#define payment_walletMo_url MOXIAN_URL_HTTPS(@"payment",@"/mo_payment/m2/walletMo/")
/***********************订单 end *****************************/

/***********************元宝支付 start *****************************/
//生成返利订单
#define rebate_order_url MOXIAN_URL_STR_NEW(@"order",@"/mo_order/m2/rebateorder")
//获取返利订单剩余时间
#define rebate_order_getExpireTime_url MOXIAN_URL_STR_NEW(@"order",@"/mo_order/m2/rebateorder/getExpireTime")
//支付完成后获取返利结果
#define rebate_order_rebateOrderResult_url MOXIAN_URL_STR_NEW(@"order",@"/mo_order/m2/rebateorder/rebate")
//混合支付查询冻结元宝数
#define rebate_order_CheckFrozenCoins_url MOXIAN_URL_STR_NEW(@"payment",@"/mo_payment/m2/paymentOrder")
//关闭未支付返利订单
#define rebate_order_closeNotpaidOrder_url MOXIAN_URL_STR_NEW(@"order",@"/mo_order/m2/rebateorder/closeNotpaidOrder")

/***********************元宝支付 end *******************************/

/*************************  商城   ********************************/
#define shopping_homeDatas MOXIAN_URL_STR_NEW(@"goods",@"/mo_goods/m2/shopgoodsdisplay/nomerchant/getShopGoodsHomeList")
// 爱逛街 - 推荐商家
#define shopping_homeRecomendStore MOXIAN_URL_STR_NEW(@"mobiz",@"/mo_biz/m2/nomerchant/recommends/shops")
// 爱逛街 - 附近商家
#define shopping_homeNearStores MOXIAN_URL_STR_NEW(@"mobiz",@"/mo_biz/m2/nomerchant/nears/shops")
// 爱逛街 - 新店开张
#define shopping_homeNewStores MOXIAN_URL_STR_NEW(@"mobiz",@"/mo_biz/m2/nomerchant/news/shops")
// 首页 － 爱店
#define shopping_homeLoveStore MOXIAN_URL_STR_NEW(@"fans",@"/mo_fans/m2/shopfans/shops/love")
/***********************红包 start *****************************/
#define redPacket_list_url MOXIAN_URL_STR_NEW(@"mobiz",@"/mo_biz/m2/nomerchant/nears/gifts")
#define redPacket_grab_url MOXIAN_URL_STR_NEW(@"redpacket",@"/mo_redpacket/m2/individualRedpacket/user/grabRedpacket")
#define redPacket_userList_url MOXIAN_URL_STR_NEW(@"redpacket",@"/mo_redpacket/m2/individualRedpacket/user/userList")
/***********************红包 end *******************************/


//http://wiki2.moxian.com/index.php?title=%E8%AE%BE%E7%BD%AE%E6%8E%A8%E5%B9%BF%E5%9C%B0%E5%9D%80%E7%82%B9%E5%87%BB%E9%87%8F  设置推广地址点击量
#define shop_nomerchant_visits_url MOXIAN_URL_STR_NEW(@"mobiz", @"/mo_biz/m2/shop/nomerchant/visits/html?shopId={shopId}")
#define mapView_search_url MOXIAN_URL_STR_NEW(@"view", @"/mo_view/m2/viewsearch?latitude={latitude}&longitude={longitude}&radius={radius}")
//h ttp://view.test.moxian.com

/***********************魔抢 begin *******************************/
#define mo_grab_url MX_HTTP_URL_FORMAT(@"grab",@"/mo_grab/login?autologin=true&token=%@&userId=%@")
#define mograb_orderInfo_url MX_HTTP_URL_FORMAT(@"grab",@"/mo_grab/login?autologin=true&token=%@&userId=%@&infoId=%@")
#define mograb_updateAddress_url MOXIAN_URL_STR_NEW(@"order",@"/mo_order/m2/graborder/updateaddress")
/***********************魔抢 end *******************************/

#define yuanbao_instructions_url MOXIAN_URL_STR_NEW(@"page",@"/mo_page/ybintro/yuanbaoInstructions.html")


/*********************** 挖矿游戏 *******************************/
//http://mining.dev2.moxian.com/mo_mining/index.html#/app/login //&env=DEV2
//#define mining_url MOXIAN_URL_STR_NEW(@"mining",@"/mo_mining/index.html?token=%@&userid=%@")

#define mining_url MOXIAN_URL_STR_NEW(@"game",@"")


#ifdef OpenDebugLcwl

#define Khost  @"ws://47.75.197.67:9001/websocket/%@"

//#define LcwlServerRoot @"http://192.168.191.1:8080"

#define LcwlServerRoot @"http://newzf.wgzvip.com"
#define LcwlServerRoot2 @"http://tom2.yhslink.com"

#else
//聊天服务器
#define Khost  @"ws://47.75.197.67:9001/websocket/%@"
//http

#define LcwlServerRoot @"https://new.ck-pay.com"
#define LcwlServerRoot2 @"https://chat.gmcoinclub.com"

#endif



#endif




