//
//  MXMoMessageToolbar.h
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/6/17.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXMoToolbarProtocol.h"

@interface MXMoMessageToolbar : UIView <MXMoToolbarProtocol>

// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

@end

@class TBDeleteButton;

@interface MXMySelfCenterToolbar : UIView <MXMoToolbarProtocol>

@property (nonatomic, strong) UIButton *changeAvatarButton;
@property (nonatomic, strong) UIButton *defaultAvatarButton;
@property (nonatomic, strong) TBDeleteButton *deleteAvatarButton;
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

@end

@interface MXGroupAvatarToolbar : UIView <MXMoToolbarProtocol>

@property (nonatomic, strong) UIButton *changeAvatarButton;
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

@end


@interface TBDeleteButton : UIButton

@end
