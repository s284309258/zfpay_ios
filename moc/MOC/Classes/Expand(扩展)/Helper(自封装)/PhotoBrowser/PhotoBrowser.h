//
//  PhotoBrowser.h
//  Lcwl
//
//  Created by mac on 2018/11/23.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLPhotoConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^SelectMediaBlock)(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nullable assets, BOOL isOriginal);

@interface PhotoBrowser : NSObject

+ (instancetype)shared;
- (void)reset;
- (void)showPhotoLibrary:(UIViewController *)showInVC completion:(SelectMediaBlock)block;
- (void)showSelectSinglePhotoLibrary:(UIViewController *)showInVC completion:(SelectMediaBlock)block;
- (void)showSelectSocialContactPhotoLibrary:(UIViewController *)showInVC completion:(SelectMediaBlock)block;

//相册
- (void)showThumbnailPhotoLibrary:(UIViewController *)showInVC completion:(void(^)(NSArray<UIImage *> *images, NSArray<PHAsset *> * assets, BOOL isOriginal)) block ;
//相机
- (void)camera:(UIViewController *)showInVC completion:(void(^)(UIImage * images)) block ;
                                                        
@property (nonatomic, copy) void (^selectImageBlock)(NSArray<UIImage *> *__nullable images, NSArray<PHAsset *> *assets, BOOL isOriginal);


- (void)dynamicShowPhotoLibrary:(UIViewController *)showInVC allowSelectVideo:(BOOL)allow lastSelectAssets:(nullable NSMutableArray<PHAsset *>*)assets completion:(SelectMediaBlock)block;
- (void)dynamicPreviewSelectPhotos:(UIViewController *)showInVC didSelectItemAtIndex:(NSInteger)index completion:(SelectMediaBlock)block;
@end

NS_ASSUME_NONNULL_END
