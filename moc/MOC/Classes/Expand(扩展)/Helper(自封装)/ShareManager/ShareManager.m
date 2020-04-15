//
//  ShareManager.m
//  AdvertisingMaster
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ShareManager.h"
#import "LWShareService.h"
#import "WXApi.h"
@implementation ShareManager
+ (void)shareToWeChatPlatform:(NSString *)title content:(NSString*)content image:(NSString *)image url:(NSString*)url vc:(UIViewController*)vc{
    [LWShareService shared].shareBtnClickBlock = ^(NSIndexPath *index) {
        [[LWShareService shared] hideSheetView];
        
        if(index.row == 0) { //微信
          
            WXMediaMessage *message=[WXMediaMessage message];
            message.title= title;
            message.description= content;
            UIImage* tmpImg = [self getImageFromURL:image];
            //缩略图要小于32KB，否则无法调起微信,32KB = 32*1024B=32678
            UIImage *pressImage = [self compressImage:tmpImg toByte:32765];
//
//            [message setThumbImage:pressImage];
            NSData *imageData = UIImagePNGRepresentation(pressImage);
            WXImageObject *imgObject = [WXImageObject object];
            imgObject.imageData = imageData;
            message.mediaObject=imgObject;
//            WXWebpageObject *webPageObject=[WXWebpageObject object];
//
//            webPageObject.webpageUrl=url;
//
//            message.mediaObject=webPageObject;
            
            
            
            SendMessageToWXReq *req=[[SendMessageToWXReq alloc]init];
            
            req.bText=NO;
            
            req.message=message;
            
            req.scene = WXSceneSession;
            
            
            
            [WXApi sendReq:req];
        }
        else
        {
         //微信
            
//            WXMediaMessage *message=[WXMediaMessage message];
//            message.title= title;
//            message.description= content;
//            UIImage* tmpImg = [self getImageFromURL:image];
//            //缩略图要小于32KB，否则无法调起微信,32KB = 32*1024B=32678
//            UIImage *pressImage = [self compressImage:tmpImg toByte:32765];
//
//            [message setThumbImage:pressImage];
//            WXWebpageObject *webPageObject=[WXWebpageObject object];
//
//            webPageObject.webpageUrl=url;
//
//            message.mediaObject=webPageObject;
            
            
             WXMediaMessage *message=[WXMediaMessage message];
            message.title= title;
            message.description= content;
            UIImage* tmpImg = [self getImageFromURL:image];
            //缩略图要小于32KB，否则无法调起微信,32KB = 32*1024B=32678
            UIImage *pressImage = [self compressImage:tmpImg toByte:32765];
//
//            [message setThumbImage:pressImage];
            NSData *imageData = UIImagePNGRepresentation(pressImage);
            WXImageObject *imgObject = [WXImageObject object];
            imgObject.imageData = imageData;
            message.mediaObject=imgObject;
            SendMessageToWXReq *req=[[SendMessageToWXReq alloc]init];
            
            req.bText=NO;
            
            req.message=message;
            
            req.scene = WXSceneTimeline;
            
            
            
            [WXApi sendReq:req];
        }
    };
    [[LWShareService shared] showInViewController:vc];
    
    
}

+(UIImage *) getImageFromURL:(NSString *)fileURL

{
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
}

#pragma mark - 压缩图片
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}


+ (void)shareToWeChatPlatform2:(NSString *)title content:(NSString*)content image:(NSString *)image url:(NSString*)url vc:(UIViewController*)vc{
    [LWShareService shared].shareBtnClickBlock = ^(NSIndexPath *index) {
        [[LWShareService shared] hideSheetView];

        if(index.row == 0) { //微信

            WXMediaMessage *message=[WXMediaMessage message]; 
            message.title= title;
            message.description= content;
            UIImage* tmpImg = [self getImageFromURL:image];
            //缩略图要小于32KB，否则无法调起微信,32KB = 32*1024B=32678
            UIImage *pressImage = [self compressImage:tmpImg toByte:32765];

            [message setThumbImage:pressImage];
            WXWebpageObject *webPageObject=[WXWebpageObject object];

            webPageObject.webpageUrl=url;

            message.mediaObject=webPageObject;



            SendMessageToWXReq *req=[[SendMessageToWXReq alloc]init];

            req.bText=NO;

            req.message=message;

            req.scene = WXSceneSession;



            [WXApi sendReq:req];
        } else { //抖音
            { //微信

                WXMediaMessage *message=[WXMediaMessage message];
                message.title= title;
                message.description= content;
                UIImage* tmpImg = [self getImageFromURL:image];
                //缩略图要小于32KB，否则无法调起微信,32KB = 32*1024B=32678
                UIImage *pressImage = [self compressImage:tmpImg toByte:32765];

                [message setThumbImage:pressImage];
                WXWebpageObject *webPageObject=[WXWebpageObject object];

                webPageObject.webpageUrl=url;

                message.mediaObject=webPageObject;



                SendMessageToWXReq *req=[[SendMessageToWXReq alloc]init];

                req.bText=NO;

                req.message=message;

                req.scene = WXSceneTimeline;



                [WXApi sendReq:req];
            }
        }
    };
    [[LWShareService shared] showInViewController:vc];
    
    
}
@end
