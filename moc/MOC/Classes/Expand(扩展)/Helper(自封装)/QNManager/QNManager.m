//
//  QNManager.m
//  Lcwl
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "QNManager.h"
#import "UIImage+FixOrientation.h"

@interface QNManager()
@property(nonatomic, copy) NSString *token;
@end

@implementation QNManager
+ (QNManager *)shared {
    static id shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

//七牛host从登录返回
- (NSString *)qnHost {
    if(_qnHost == nil) {
        _qnHost = AppUserModel.qiniu_domain; //[[NSUserDefaults standardUserDefaults] stringForKey:@"qiniu_domain"];
        if(_qnHost == nil) {
            return @"http://cdn.yhswl.com";
        }
    }
    return _qnHost;
}

- (void)getToken:(CompletionBlock)block {
    NSString *url = [NSString stringWithFormat:@"%@/api/common/qiniu/getQiNiuToken",LcwlServerRoot];
    [MXNet Post:^(MXNet *net) {
       
        net.apiUrl(url).params(nil)
        .finish(^(id data) {
            NSString *tok = [data valueForKeyPath:@"data.qiniu_token"];
            self.token = tok ?: self.token;
            NSString *host = [data valueForKeyPath:@"data.qiniu_domain"];
            self.qnHost = host ?: self.qnHost;
            Block_Exec(block,self.token);
        }).failure(^(id error) {
            Block_Exec(block,self.token);
        })
        .execute();
    }];
}

- (NSString *)media:(NSDictionary *)resp {
    return [[resp allKeys] containsObject:@"key"] ? [NSString stringWithFormat:@"%@%@",self.qnHost,[resp valueForKey:@"key"]] : @"";
}

- (void)uploadImage:(UIImage *)image completion:(CompletionBlock)block {
    [self getToken:^(id data) {
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        [upManager putData:UIImageJPEGRepresentation([image fixOrientation], 1) key:nil token:self.token
                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                      NSLog(@"%@", info);
                      NSLog(@"%@", resp);
                      Block_Exec_Main_Async_Safe(^{
                          Block_Exec(block,[resp valueForKey:@"key"]);
                      });
                  } option:[QNUploadOption defaultOptions]];
    }];
}

- (void)uploadImages:(NSArray *)images assets:(NSArray *)assets completion:(CompletionBlock)block {
    [self getToken:^(id data) {
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_queue_create("com.gcd-group.www", DISPATCH_QUEUE_CONCURRENT);
        
        NSMutableArray *urls = [NSMutableArray arrayWithCapacity:1];
        [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [urls addObject:@""];
        }];
        
        __block BOOL success = YES;
            
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        [assets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            dispatch_group_async(group, queue, ^{
                dispatch_group_enter(group);

                NSString *filename = [obj valueForKey:@"filename"];
                NSString *ext = [[filename pathExtension] lowercaseString];
                if([ext isEqualToString:@"gif"]) { //动态图片
                    [upManager putPHAsset:obj key:nil token:self.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                        if(resp == nil && info.error != nil) {
                            NSString *error = [info.error.userInfo valueForKey:@"error"];
                            [NotifyHelper showMessageWithMakeText:error];
                            success = NO;
                        }
                        [urls replaceObjectAtIndex:idx withObject:[resp valueForKey:@"key"] ?: @""];
                        dispatch_group_leave(group);
                    } option:[QNUploadOption defaultOptions]];
                } else { //静态图片
                    UIImage *image = [[images safeObjectAtIndex:idx] fixOrientation];
                    if(image == nil) {
                        return;
                    }
                    
                    [upManager putData:UIImageJPEGRepresentation(image, 1) key:nil token:self.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                        if(resp == nil && info.error != nil) {
                            NSString *error = [info.error.userInfo valueForKey:@"error"];
                            [NotifyHelper showMessageWithMakeText:error];
                            success = NO;
                        }
                        [urls replaceObjectAtIndex:idx withObject:[resp valueForKey:@"key"] ?: @""];
                        dispatch_group_leave(group);
                    } option:[QNUploadOption defaultOptions]];
                }
            });
        }];
        
        dispatch_group_notify(group, queue, ^{
            NSLog(@"done");
            Block_Exec_Main_Async_Safe(^{
                Block_Exec(block,success ? urls : nil);
            });
        });
    }];
}

- (void)uploadAssets:(NSArray *)assets completion:(CompletionBlock)block {
    [self getToken:^(id data) {
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_queue_create("com.gcd-group.www", DISPATCH_QUEUE_CONCURRENT);
        
        NSMutableArray *urls = [NSMutableArray arrayWithCapacity:1];
        [assets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [urls addObject:@""];
        }];
        
        __block BOOL success = YES;
        
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        [assets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            dispatch_group_async(group, queue, ^{
                dispatch_group_enter(group);
                [upManager putPHAsset:obj key:nil token:self.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                    if(resp == nil && info.error != nil) {
                        NSString *error = [info.error.userInfo valueForKey:@"error"];
                        [NotifyHelper showMessageWithMakeText:error];
                        success = NO;
                    }
                    [urls replaceObjectAtIndex:idx withObject:[resp valueForKey:@"key"] ?: @""];
                    dispatch_group_leave(group);
                } option:[QNUploadOption defaultOptions]];
            });
        }];
        
        dispatch_group_notify(group, queue, ^{
            NSLog(@"done");
            Block_Exec_Main_Async_Safe(^{
                Block_Exec(block,success ? urls : nil);
            });
        });
    }];
}


- (void)uploadVideo:(PHAsset *)asset completion:(CompletionBlock)block {
    [self getToken:^(id data) {
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        [upManager putPHAsset:asset key:nil token:self.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            NSLog(@"%@", info);
            NSLog(@"%@", resp);
            Block_Exec_Main_Async_Safe(^{
                Block_Exec(block,[resp valueForKey:@"key"]);
            });
        } option:[QNUploadOption defaultOptions]];
    }];
}

- (void)uploadAudio:(NSString *)filePath completion:(CompletionBlock)block{
    [self getToken:^(id data) {
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        [upManager putFile:filePath key:nil token:self.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            NSLog(@"%@", info);
            NSLog(@"%@", resp);
            Block_Exec_Main_Async_Safe(^{
                Block_Exec(block,[resp valueForKey:@"key"]);
            });
        } option:[QNUploadOption defaultOptions]];
    }];
}
@end
