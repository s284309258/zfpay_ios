//
//  MXNet.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 16/7/20.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import "MXNet.h"
#import "CommonDefine.h"
#import "MXRequest+RequestError.h"
#import "MXBaseRequestApi.h"
#import "MXReachabilityManager.h"
#import "MD5Util.h"
#import "NSString+Ext.h"
#import "RSAManage.h"
#import "AFURLSessionManager.h"

static NSString* key = @"SPNbRiokxGNpAe0ysIEr732QdzcsofDe7O6HNkqd42IXPTJWy2ruCA4jNuwi9yZVryJP1Yrp";
static NSString* key2 = @"Ylm1bDfcfHXhFy5xNX04PqwaGX61fPU2FOtaTtOGZAc7iEk03x315hxK72DA72NVeWbCFUbF";

@interface MXApi : MXBaseRequestApi

@property (nonatomic, strong) NSString        *url;
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
@property (nonatomic, assign) MXRequestMethod method;
@property (nonatomic, strong) NSDictionary    *param;
@end

@implementation MXApi

- (instancetype)init {
    self = [super init];
    if (self) {
        _timeoutInterval = 30;
    }
    return self;
}

- (NSString *)requestUrl {
    return self.url ?: @"";
}

- (MXRequestMethod)requestMXMethod {
    return self.method;
}

- (id)requestArgument {
    return self.param;
}

- (CGFloat)requestTimeoutInterval {
    return self.timeoutInterval;
}

@end

@interface MXNet ()

@property (nonatomic, strong) MXApi         *api;
@property (nonatomic, assign) BOOL          errorRawData;
///是否需要加密
@property (nonatomic, assign) BOOL          needEncrypt;
@property (nonatomic, assign) BOOL          needMsg;
@property (nonatomic, assign) BOOL          needHud;
@property (nonatomic, weak) id showInView; ///hud显示所在的视图，空则显示在window上

@property (nonatomic, strong) id<MXHandleData> dataHandle;
@property (nonatomic, strong) void(^apiFinish)(id);
@property (nonatomic, strong) void(^apiFailure)(id);
@property (nonatomic, strong) void(^apiTimeOut)(void);

@end

@implementation MXNet

- (instancetype)init {
    self = [super init];
    if (self) {
        _api = [[MXApi alloc] init];
    }
    return self;
}

+ (void)Post:(void(^)(MXNet *net))block {
    MXNet *api = [[MXNet alloc] init];
    api.api.method = MXRequestMethodPost;
    
    Block_Exec(block, api);
}

+ (void)Get:(void(^)(MXNet *net))block {
    MXNet *api = [[MXNet alloc] init];
    api.api.method = MXRequestMethodGet;
    
    Block_Exec(block, api);
}

+ (void)Put:(void(^)(MXNet *net))block {
    MXNet *api = [[MXNet alloc] init];
    api.api.method = MXRequestMethodPut;
    
    Block_Exec(block, api);
}

- (MXNet* (^)(NSString *))apiUrl {
    return ^id(NSString *url) {
        self.api.url = url;
        return self;
    };
}

- (MXNet* (^)(void))cache {
    return ^id() {
        self.api.ignoreCache = NO;
        return self;
    };
}

- (MXNet* (^)(void))useMsg {
    return ^id() {
        self.needMsg = YES;
        return self;
    };
}

- (MXNet* (^)(id))useHud {
    return ^id(id superView) {
        self.showInView = superView;
        self.needHud = YES;
        return self;
    };
}

- (MXNet* (^)(void))useEncrypt {
    return ^id() {
        self.needEncrypt = YES;
        return self;
    };
}

- (MXNet* (^)(void))errorRamData {
    return ^id() {
        self.errorRawData = YES;
        return self;
    };
}

- (MXNet* (^)(NSInteger))page {
    return ^id(NSInteger page) {
        self.api.page = @(page);
        return self;
    };
}

- (MXNet* (^)(NSInteger))pageSize {
    return ^id(NSInteger size) {
        self.api.pageSize = @(size);
        return self;
    };
}

static NSString *extracted(MXNet *object, NSMutableDictionary *tmpParam) {
    return [object md5Str:tmpParam key:[object.api.url hasPrefix:LcwlServerRoot] ? key : key2];
}

- (MXNet* (^)(NSDictionary *))params {
    return ^id(NSDictionary *param) {
        NSMutableDictionary* tmpParam = [[NSMutableDictionary alloc]initWithDictionary:param];
        if (![[param allKeys] containsObject:@"token"]) {
            [tmpParam setValue:AppUserModel.token forKey:@"token"];
        }
        NSString* password1 = tmpParam[@"payPassword"];
        if (![StringUtil isEmpty:password1]) {
            [tmpParam setValue:[MD5Util md5FromString:password1] forKey:@"payPassword"];
        }
        NSString* password2 = tmpParam[@"newPayPassword"];
        if (![StringUtil isEmpty:password2]) {
            [tmpParam setValue:[MD5Util md5FromString:password2] forKey:@"newPayPassword"];
        }
        NSString* password3 = tmpParam[@"confirmPayPassword"];
        if (![StringUtil isEmpty:password3]) {
            [tmpParam setValue:[MD5Util md5FromString:password3] forKey:@"confirmPayPassword"];
        }
             
        NSString* login_password1 = tmpParam[@"password"];
        if (![StringUtil isEmpty:login_password1]) {
            [tmpParam setValue:[MD5Util md5FromString:login_password1] forKey:@"password"];
        }
        
        NSString* login_password2 = tmpParam[@"newPassword"];
        if (![StringUtil isEmpty:login_password2]) {
            [tmpParam setValue:[MD5Util md5FromString:login_password2] forKey:@"newPassword"];
        }
        
        NSString* login_password3 = tmpParam[@"confirmPassword"];
        if (![StringUtil isEmpty:login_password3]) {
            [tmpParam setValue:[MD5Util md5FromString:login_password3] forKey:@"confirmPassword"];
        }
        
        NSString* login_password4 = tmpParam[@"login_password"];
        if (![StringUtil isEmpty:login_password4]) {
            [tmpParam setValue:[MD5Util md5FromString:login_password4] forKey:@"login_password"];
        }
        
        NSString* pay_password = tmpParam[@"pay_password"];
        if (![StringUtil isEmpty:pay_password]) {
            [tmpParam setValue:[MD5Util md5FromString:pay_password] forKey:@"pay_password"];
        }
        
        if([self.api.url hasPrefix:@"https://native.gmcoinclub.com"]) {
            [tmpParam removeObjectForKey:@"token"];
        } else if([self.api.url hasPrefix:@"https://chat.gmcoinclub.com"]) {
            [tmpParam setValue:AppUserModel.chatToken forKey:@"token"];
        }
        
        
        NSString* md5Str = extracted(self, tmpParam);
        md5Str = [MD5Util md5FromString:md5Str];
        [tmpParam setValue:md5Str forKey:@"sign"];
        //self.api.param = tmpParam;
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tmpParam options:NSJSONWritingPrettyPrinted error:&error];
        NSString* jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        if(self.needEncrypt) {
//            self.api.param = @{@"data": [RSAManage encryptString:jsonString] ?: @""};
            if([self.api.url hasPrefix:@"https://native.gmcoinclub.com"]) {
                self.api.param = @{@"data": [RSAManage encrypt3String:jsonString] ?: @""};
            } else if([self.api.url hasPrefix:@"https://chat.gmcoinclub.com"]) {
                self.api.param = @{@"data": [RSAManage encrypt2String:jsonString] ?: @""};
            } else {
                self.api.param = @{@"data": [RSAManage encryptString:jsonString] ?: @""};
            }
        } else {
            self.api.param = tmpParam;
        }
        
        NSLog(@"请求参数列表%@",jsonString);
        return self;
    };
}
-(NSString* )md5Str:(NSDictionary* )dict key:(NSString *)signKey{
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableString *contentString = [NSMutableString string];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        NSString *value = [dict valueForKey:categoryId];
        if([StringUtil isEmpty:value]) {
            continue;
        }
        [contentString appendFormat:@"%@=%@&", categoryId, [value removeSpaceAndNewline]];
    }
    [contentString appendFormat:@"key=%@", signKey];
    return contentString;
}


- (MXNet* (^)(id<MXHandleData>))parse {
    return ^id(id<MXHandleData> parseData) {
        self.dataHandle = parseData;
        return self;
    };
}

- (MXNet* (^)(void(^)(id)))finish {
    return ^id(void(^f)(id)) {
        self.apiFinish = f;
        return self;
    };
}

- (MXNet* (^)(void(^)(id)))failure {
    return ^id(void(^error)(id)) {
        self.apiFailure = error;
        return self;
    };
}

- (MXNet* (^)(void(^)(void)))timeOut {
    return ^id(void(^time)(void)) {
        self.apiTimeOut = time;
        return self;
    };
}

- (MXNet* (^)(NSTimeInterval))timeoutInterval {
    return ^id(NSTimeInterval time) {
        self.api.timeoutInterval = time;
        return self;
    };
}

- (void (^)(void))execute {
    return ^(void){
        //        if ([MXReachabilityManager isNetWorkReachable]) {
        //            Block_Exec(self.apiFailre, MXLang(@"", @"网络不给力，请再试试啦~"));
        //            return;
        //        }
        [self showHud];
        [self.api startWithCompletionBlockWithSuccess:^(MXRequest *request) {
            [self hideHud];
            NSDictionary *dict = request.responseJSONObject;
            if(self.needMsg) {
                [NotifyHelper showMessageWithMakeText:Lang([@([[dict valueForKey:@"code"] integerValue]) description])];
            }
            
            if([[dict valueForKey:@"code"] integerValue] == 1003) { //账号已被冻结
                if ([MoApp respondsToSelector:NSSelectorFromString(@"enterLoginPage")]) {
                    [MoApp performSelector:NSSelectorFromString(@"enterLoginPage") withObject:nil afterDelay:0];
                }
//                [MoApp performSelector:NSSelectorFromString(@"showAlertUnlockView") withObject:nil afterDelay:0.25];
                return;
            }
            Block_Exec(self.apiFinish, self.dataHandle ?[self.dataHandle parseData:dict] :dict);
        } failure:^(MXRequest *request) {
            [self hideHud];
            [NotifyHelper showMessageWithMakeText:[request requestError]];
            // 超时
            if (request.responseStatusCode == -1001 && self.apiTimeOut) {
                self.apiTimeOut();
            } else {
                Block_Exec(self.apiFailure, [request requestError]);
            }
        }];
    };
}

- (void)showHud {
    if(self.needHud) {
        if([self.showInView isKindOfClass:[UIViewController class]]) {
            [NotifyHelper showHUDAddedTo:[self.showInView view] animated:YES];
        } else if([self.showInView isKindOfClass:[UIView class]]) {
            [NotifyHelper showHUDAddedTo:self.showInView animated:YES];
        } else {
            [NotifyHelper showHUD];
        }
    }
}

- (void)hideHud {
    if(self.needHud) {
        if([self.showInView isKindOfClass:[UIViewController class]]) {
            [NotifyHelper hideHUDForView:[self.showInView view] animated:YES];
        } else if([self.showInView isKindOfClass:[UIView class]]) {
            [NotifyHelper hideHUDForView:self.showInView animated:YES];
        } else {
            [NotifyHelper hideHUD];
        }
    }
}

- (void (^)(void))cancle {
    return ^(void) {
        [self.api stop];
    };
}

@end

