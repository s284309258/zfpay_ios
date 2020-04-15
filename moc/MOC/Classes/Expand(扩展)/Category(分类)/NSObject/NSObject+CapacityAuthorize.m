//
//  UIApplication+Authorize.m
//  MoPal_Developer
//
//  Created by moxian on 15/11/27.
//  Copyright © 2015年 MoXian. All rights reserved.
//

#import "NSObject+CapacityAuthorize.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MXAlertViewHelper.h"

@implementation NSObject (CapacityAuthorize)


- (BOOL)isAuthorizedCameraStatus{
    return [self isAuthorizedAuthorizationStatus:UIImagePickerControllerSourceTypeCamera];
}
- (BOOL)isAuthorizedPhotoLibraryStatus{
    return [self isAuthorizedAuthorizationStatus:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL)isAuthorizedAuthorizationStatus:(UIImagePickerControllerSourceType)sourceType{
    switch (sourceType) {
        case UIImagePickerControllerSourceTypeCamera:{
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if(authStatus ==AVAuthorizationStatusDenied ||
               authStatus ==AVAuthorizationStatusRestricted ) {
                [self showAuthorizedResult:@"没有操作权限" message:@"请开放相机权限：手机->隐私->相机->礼常往来"];
                return NO;
            }
            return YES;
            break;
        }
        default:{
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            if(author == ALAuthorizationStatusDenied ||
               author == AVAuthorizationStatusRestricted) {
                if([[self class] isSubclassOfClass:[UIViewController class]])
                {
                    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    UIViewController *selfVC = (UIViewController *)self;
                    [selfVC presentViewController:imagePicker animated:YES completion:nil];
                }else{
                    [self showAuthorizedResult:@"没有操作权限" message:@"请开放照片权限：手机->隐私->照片->礼常往来"];
                }
                return NO;
            }
            return YES;
            break;
        }
    }
    return YES;
}

- (BOOL)isAuthorizedAudioSessionStatus{
    if([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)])
    {
        __block BOOL myGranted = NO;
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            myGranted = granted;
        }];
        if (!myGranted) {
            [self showAuthorizedResult:@"没有操作权限" message:@"请为开放麦克风权限：手机->隐私->麦克风->礼常往来"];
        }
        return myGranted;
    }
    return YES;
}

- (BOOL)isAuthorizedLocationStatus{
   return [self isAuthorizedLocationStatus:YES];
}

- (BOOL)isAuthorizedLocationStatus:(BOOL)showAlert{
    if (![CLLocationManager locationServicesEnabled]) {
        if (showAlert) {
            [self showAuthorizedResult:@"没有操作权限" message:@"请为开放定位权限：手机->隐私->定位服务->礼常往来"];
        }
        return NO;
    }
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusDenied) {
        if (showAlert) {
             [self showAuthorizedResult:@"没有操作权限" message:@"请为开放定位权限：手机->隐私->定位服务->礼常往来"];
        }
        return NO;
    }
    return YES;
}

- (void)showAuthorizedResult:(NSString*)title message:(NSString *)message {
    
    if (IOS8_Later) {
        [MXAlertViewHelper showAlertViewWithMessage:message completion:^(BOOL cancelled, NSInteger buttonIndex) {
            if (buttonIndex==0) {
                return;
            }
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
    }else{
        [MXAlertViewHelper showAlertViewWithMessage:message];
    }
}

@end
