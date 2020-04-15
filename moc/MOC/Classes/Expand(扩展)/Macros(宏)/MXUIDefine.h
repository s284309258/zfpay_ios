//
//  MXUIDefine.h
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/12/17.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import "MXRouter.h"
#import "AppDelegate.h"

#ifndef MXUIDefine_h
#define MXUIDefine_h

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

//包括 状态栏20像素
#define SCREEN_SIZE [[UIScreen mainScreen] applicationFrame]

#define SCREEN_SCALE [UIScreen mainScreen].scale //屏幕缩放比

#define SafeAreaBottom_Height  [SSDeviceDefault shareCKDeviceDefault].safeAreaBottomHeight

// add by yang.xiangbao
#define CoorFontSize(size) [DeviceManager caculateFontSize:size]
// 通过 iPhone 6及以下尺寸计算，Plus 尺寸
#define PlusDownSize(size) [DeviceManager caculateiPhone6UPDeviceSizeByType:size]
// 通过 iPhone 6及以下尺寸计算，Plus 字体 尺寸
#define PlusDownFontSize(size) [DeviceManager caculateiPhone6UPFontSize:size]
// the end

#define CornerRadius 4

#define Coordinate(size) [DeviceManager caculateDeviceSizeByType:size]

// 行高ForStoreKey
#define RowHeight 44

//选项卡高度
#define SegmentHeight 27

#define AdjustTableBehavior(tv) if (@available(iOS 11.0, *)) {\
    tv.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;\
} else {\
    self.automaticallyAdjustsScrollViewInsets = NO;\
}

static inline UIEdgeInsets safeAreaInset() {
    if (@available(iOS 11.0, *)) {
        return ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController.view.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

static inline CGFloat safeAreaInsetBottom() {
    return safeAreaInset().bottom;
}

#endif /* MXUIDefine_h */
