//
//  MXMoToolbarProtocol.h
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/6/17.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MXMoToolBarActionType) {
    MXMoToolBarActionTypeReplaceAvatar,
    MXMoToolBarActionTypeSetDefault,
    MXMoToolBarActionTypeDeleteAvatar,
};

@protocol MXMoToolbarProtocol <NSObject>

@required
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

@optional

- (void)moToolbarActionClick:(MXMoToolBarActionType)type;

@end
