//
//  NSObject+CapacityAuthorize.h
//  MoPal_Developer
//
//  Created by moxian on 15/11/27.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (CapacityAuthorize)

//验证相机和相册的隐私权限设置
- (BOOL)isAuthorizedCameraStatus;
- (BOOL)isAuthorizedPhotoLibraryStatus;
//验证麦克风的隐私权限设置
- (BOOL)isAuthorizedAudioSessionStatus;
//验证是否开启了定位功能
- (BOOL)isAuthorizedLocationStatus;
//验证是否开启了定位功能,showAlert为YES时，在未开启定位功能时，是否有弹框提示
- (BOOL)isAuthorizedLocationStatus:(BOOL)showAlert;
@end
