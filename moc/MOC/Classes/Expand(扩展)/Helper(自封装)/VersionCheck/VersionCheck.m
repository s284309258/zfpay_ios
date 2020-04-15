//
//  VersionCheck.m
//  Lcwl
//
//  Created by mac on 2019/1/24.
//  Copyright © 2019 lichangwanglai. All rights reserved.
//

#import "VersionCheck.h"
#import "MXAlertViewHelper.h"

@implementation VersionCheck
+ (void)checkNewVersion {
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot,@"api/sys/version/getNewVersion"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(@{@"device_type":@"iOS"})
        .finish(^(id data) {
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                NSInteger status = [[tempDic valueForKeyPath:@"data.versionInfo.status"] integerValue];
                NSString* oldVersion = APPBUILDVERSION;
                NSString *newVersion = [tempDic valueForKeyPath:@"data.versionInfo.version_no"];
                NSString *message = [tempDic valueForKeyPath:@"data.versionInfo.note"] ?: @"";
                NSString *openURL = [tempDic valueForKeyPath:@"data.versionInfo.version_url"];
                BOOL needUpdate = ([newVersion compare:oldVersion] == NSOrderedDescending);
                if (needUpdate) {
                    //是否强制更新 0—否，1—是
                    //NSString *cancelTitle = @"立即更新";
                    //NSString *okTitle = @"暂不更新";
                    if(status == 1) {
                        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"检测到新版本" message:nil preferredStyle:UIAlertControllerStyleAlert];

                        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
                        NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
                        [ps setAlignment:NSTextAlignmentLeft];
                        [alertControllerMessageStr addAttribute:NSParagraphStyleAttributeName value:ps range:NSMakeRange(0, message.length)];
                        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, message.length)];
                        [alertCtrl setValue:alertControllerMessageStr forKey:@"attributedMessage"];

                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            NSURL *URL = [NSURL URLWithString:openURL];
                            if(URL == nil) {
                                return;
                            }

                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:^(BOOL success) {

                                }];
                            } else {
                                [[UIApplication sharedApplication]openURL:URL];
                            }
                        }];
                        [alertCtrl addAction:cancelAction];

                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertCtrl animated:YES completion:nil];

                    }
                }

            } else {

            }
        }).failure(^(id error) {

        })
        .execute();
    }];
}


@end
