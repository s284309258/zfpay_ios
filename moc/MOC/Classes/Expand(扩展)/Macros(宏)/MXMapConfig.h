//
//  MXMapConfig.h
//  MapDemo
//
//  Created by aken on 15/4/23.
//  Copyright (c) 2015年 MapDemo. All rights reserved.
//

#ifndef MapDemo_MXMapConfig_h
#define MapDemo_MXMapConfig_h

// https://console.developers.google.com/
// 企业版的key
#define GoogleMapKey @"AIzaSyA-O7Fn894cuYlsr6JVX66yJW7q6S5XdiY"
#define GooglePlaceKey @"AIzaSyAcQ78E4M2DvA2b9yPRUJLxSUD9tCYWRXU"

// app store的key
#define GoogleMapForStoreKey @"AIzaSyCGSs8SlpBy85KrVefcJw4Gl-MfgdUv9Ec"
#define GooglePlaceForStoreKey @"AIzaSyBq5cGMCtUwEqI--s9AOtdEx4NvoD-YxpU"



#define mapViewMarkerViewBgImage @"wl_map_icon_5.png"

#define mapViewNavigationIcon @"wl_navigation_white.png"

#define mapViewMarkerViewCorner @"wl_map_icon_4.png"

#define mapViewLocationIcon @"wl_location1.png"

// 谷歌服务开发api
#define google_autocomplete_place @"https://maps.googleapis.com/maps/api/place/autocomplete/json"
#define google_service_nearbysearch @"https://maps.googleapis.com/maps/api/place/nearbysearch/json"
#define google_service_place_details @"https://maps.googleapis.com/maps/api/place/details/json"

#define maxSearchRadius 1000

// 地图类型
typedef NS_ENUM(NSInteger, MXMapViewType) {
    
    MXMapViewTypeAppleMap,
    MXMapViewTypeGoogleMap
    
};

// 支持打开第三方地图导航
typedef NS_ENUM(NSInteger, MXNavigationMapType) {
    
    MXNavigationMapTypeAppleMap,
    MXNavigationMapTypeGoogleMap,
    MXNavigationMapTypeBaiduMap
};

// 支持打开第三方地图导航名字
#define kNavigationAppleMap MXLang(@"Talk_controller_locationVC_title_6", @"高德地图")
#define kNavigationGoogleMap MXLang(@"Talk_controller_locationVC_title_7", @"Google地图")
#define kNavigationBaiduMap MXLang(@"Talk_controller_locationVC_title_8", @"百度地图")

#endif
