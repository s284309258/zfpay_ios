//
//  PublishDynamic.h
//  Lcwl
//
//  Created by mac on 2018/12/6.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "BaseViewController.h"
#import "WBModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PublishDynamicType) {
    PublishDynamicTypeBySelf = 0,
    PublishDynamicTypeTransfer ///转发
};

@class PHAsset;

@interface PublishDynamic : BaseViewController
@property (nonatomic,assign) PublishDynamicType type;
///视频只能选择一个，YES：选择了一个视频。NO：选择的是照片
@property (nonatomic,assign) BOOL curSelectVideo;
@property (nonatomic,copy) NSArray *photosArr;
@property (nonatomic,copy) NSArray *assets;
@property (nonatomic,weak) WBStatus *model;
@property (nonatomic,copy) CompletionBlock block;
@property (nonatomic,strong) NSMutableArray<PHAsset *> *curSelectAssets;
@property (nonatomic,strong) NSMutableArray<UIImage *> *curSelectImages;
@end

NS_ASSUME_NONNULL_END
