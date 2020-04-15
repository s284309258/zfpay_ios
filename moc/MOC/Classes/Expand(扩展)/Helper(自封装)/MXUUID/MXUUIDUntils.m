//
//  MXUUIDUntils.m
//  MoPal_Developer
//
//  Created by fly on 2016/10/19.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import "MXUUIDUntils.h"
#import "JNKeychain.h"

static NSString *kAccessGroup = @"com.moxian.group.ios";
static NSString *kDeviceUuidKey = @"com.moxian.deviceUuidKey";

@implementation MXUUIDUntils

#pragma mark - 保存和读取UUID

+ (void)saveUUIDToKeyChain{
    NSString *strUUID = [self readUUIDFromKeyChain];
    if(!strUUID || [strUUID isEqualToString:@""] ){
        strUUID = [self getUUIDString];
        if ([JNKeychain saveValue:strUUID forKey:kDeviceUuidKey forAccessGroup:kAccessGroup]) {
            MLog("保存成功");
        }else{
            MLog("失败");
        }
        MLog("new device uuid = %@",strUUID)

    }else{
        MLog("exist device uuid = %@",strUUID)
    }
}

+ (BOOL)removeUUIDFromKeyChain{
    return [JNKeychain deleteValueForKey:kDeviceUuidKey forAccessGroup:kAccessGroup];
}

+ (NSString *)readUUIDFromKeyChain{
    NSString *UUID = [JNKeychain loadValueForKey:kDeviceUuidKey forAccessGroup:kAccessGroup];
    return UUID;
}

+ (NSString *)getUUIDString{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef strRef = CFUUIDCreateString(kCFAllocatorDefault , uuidRef);
    NSString *uuidString = [(__bridge NSString*)strRef stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(strRef);
    CFRelease(uuidRef);
    return uuidString;
}

@end
